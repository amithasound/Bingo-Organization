;;;; -*- Mode: Lisp; -*-
;;;;
;;;; This file contains startup code for the Lisp Project.
;;;; Please read the comments toward the bottom of this
;;;; file by the VERIFY function to see how to run the code.
;;;;
;;;; This file contains definitions of functions written in
;;;; a style that is more procedural than functional.
;;
;; AUTHORS: PUT NAMES OF TEAMMATES HERE
;;


(defun is-empty-string (x)
  "Returns t iff X is an empty string (i.e. has no characters in it)."
  (equal x ""))

(defun read-int-line (str)
  "This function reads a line of space-separated integers from
the stream in STR, and returns a list of the integers."
  (let ((input-line-string (read-line str))
        (string-list1 nil)
        (string-list2 nil))
    (setf string-list1 (split-sequence " " input-line-string))
    (setf string-list2 (delete-if #'is-empty-string string-list1))
    (mapcar #'parse-integer string-list2)))

(defun bingo-data (str)
  "This function reads from the input stream in STR (standard in), and
returns a list of three elements in this order: 
the 2-d array of the pattern,
the list of called numbers,
and the 2-d array of the bingo card."
  (let ((pattern nil)
        (number-list nil)
        (board nil)
        (temp1 nil)
        (temp2 nil))
    (loop repeat 5 doing
          (setf temp1 (list (read-int-line str)))
          (setf temp2 (append temp2 temp1)))
    (setf pattern temp2)
    (read-int-line str) ;; call to eat up an empty line
    (setf number-list (read-int-line str))
    (read-int-line str) ;; call to eat up an empty line
    (setf temp2 nil)
    (setf temp1 nil)
    (loop for i from 0 to 4 doing
          (setf temp1 (list (read-int-line str)))
          (setf temp2 (append temp2 temp1)))
    (setf board temp2)
    (list pattern number-list board)))


(defun print-matrix (m)
  "A helpful debugging function to pretty-print a 2D matrix of integers."
  (loop for i below 5 doing
        (loop for j below 5 doing
              (format t "~2D " (aref m i j)))
        (format t "~%"))
  (format t "~%"))


(defun print-list-of-lists (m)
  (loop for row in m do
        (loop for element in row do
              (format t "~2D " element ))
        (format t "~%")))

;;------------------------------------------
;;Students should define any helper functions 
;;they feel necessary in this area of the file.
;; I've already started you on rotate90 and
;; verify-data.  Right now, rotate90 just returns
;; the original matrix, and verify-data just
;; returns nil.  You will need to change both
;; functions as well as add any helper functions.

(defun rotate90 (matrix)
  (let ((rows 5) (cols 5))
        (loop for i from 0 below rows
              collect (loop for j from (1- cols) downto 0
                            collect (nth i (nth j matrix)))))
)

(defun list-equality (pattern board)
  (every #'equal pattern board))

(defun contains (num board)
  (some #'(lambda (sublist) (member num sublist)) board))
  ;;lambda fucntions goes thru each sublist (rows) in board and does member function to see if num is in sublist, if any are true it returns true 
    
(defun find-element-location (num matrix)
  (let ((row-index 0)
        (found nil))
    (labels ((search-list (sublist)
               (let ((col-index 0))
                 (dolist (item sublist)
                   (when (eql item num)
                     (setq found (list row-index col-index)))
                   (setq col-index (1+ col-index))))))
      (dolist (sublist matrix)
        (search-list sublist)
        (setq row-index (1+ row-index))))
    found))

(defun make-zero-list (rows columns)
  (loop repeat rows
        collect (loop repeat columns collect 0)))



(defun checkBingo (pattern numbers board type) ;this method checks board for bingo regardless of type
  (setf firstBingo -1)
  (setf boardToCheck (make-zero-list 5 5))
  (setf numLength (- (length numbers) 1))
  (setf bingoBeforeLoop -1)
  

  (if (contains 00 board) ;check to see if there is a free space and set to 1 or 4 if it contributes to pattern
            (progn
              (setf location (find-element-location 00 board))  ;;find where element is on the board
              (setf row (nth 0 location))
              (setf col (nth 1 location))
              (if (= (nth col (nth row pattern)) type) ;;if the pattern has the 1 or 4 
                  (setf (nth col (nth row boardToCheck)) type)) ;;if the pattern has corresponding value then set boardToCheck to 1 or 4 
               (if (list-equality pattern boardToCheck) ;;this checks to see if there is a bingo before we even start
                  (if (= bingoBeforeLoop -1) 
                      (setf bingoBeforeLoop 1))
               )
          )
  )
  (loop for i from 0 to numLength do
        (if (contains (nth i numbers) board)
            (progn
              (setf location (find-element-location (nth i numbers) board)) ;;if the board has the location 
              (setf row (nth 0 location))
              (setf col (nth 1 location))
              (if (= (nth col (nth row pattern)) type) ;; if the pattern has corresponding value then set boardToCheck to 1 or 4 
                  (setf (nth col (nth row boardToCheck)) type)) ;;if its corresponding then set boardtoCheck to 1 or 4
            ))
         (if (and (list-equality pattern boardToCheck) (= i numLength)) ;;if they are equal and all calls have been made
             (if (= firstBingo -1)
                 (setf firstBingo i))) ;;set first bingo index

         (if (and (list-equality pattern boardToCheck) (not (= i numLength))) ;; if they are equal and not all calls have been checked meaning early 
             (if (= firstBingo -1)
                 (setf firstBingo i))) ;;set to firstBingo
  ) 
  
  (if (and (= firstBingo numLength) (= bingoBeforeLoop -1)) ;;if firstBingo is at num length and bingo did not happen before loop
      t
      nil)

)

(defun verify-data (pattern numbers board)
  (setf rotate1 (rotate90 pattern))
  (setf rotate2 (rotate90 rotate1))
  (setf rotate3 (rotate90 rotate2))

  (if (contains 1 pattern) 
      (progn
        (if (checkBingo pattern numbers board 1)
            t
            nil)
      )
      (progn
       ; (print "entering crazy")
        (if (contains 4 pattern)
            (progn
              (setf result1 (checkBingo pattern numbers board 4))
             ; (print result1)
              (setf result2 (checkBingo rotate1 numbers board 4))
             ; (print result2)
              (setf result3 (checkBingo rotate2 numbers board 4))
             ; (print result3)
              (setf result4 (checkBingo rotate3 numbers board 4))
             ; (print result4)
              (if (or result1 result2 result3 result4)
                t
                nil)
              )
          )
      )
  )

  
)

  "Returns T if there is a valid bingo on BOARD
 using the called ints in NUMBERS and following
the PATTERN. Returns NIL otherwise."
 ; (format t "~%PATTERN:~%~A~%CALLED NUMBERS:~%~A~%PLAYER'S CARD:~%~A~%" pattern numbers board) ;; this line must be deleted from final version.

;; STUDENTS WRITE VERIFY-DATA AND ANY HELPER FUNCTIONS FOR IT.
;; this is defined to always return "false".  You need to make your body for this
;; function return either a t (True) or a nil (false) based on the input.
;;------------------------------------------


;; You do not have to edit this VERIFY function.
;; To run the code, you should:
;; 1. load the file into your editor.
;; 2. compile the buffer.
;; 3. in the Listener, first type (verify <numtests>)
;; 4. <numtests> should be the number of tests you expect to run
;; 5. in the Listener, then copy and paste the formatted bingo input like in past projects
;; 6. after the data, you'll see the output from the function
;; NOTE: The program as originally handed to you will run, without any extra code from students.
;;       However, it will always say "NO BINGO" until you add your own code. 
;; NOTE: you can use (time (verify <numtests>)) if you are curious to see how fast or how memory efficient your code is.
(defun verify (numtests &optional (str *standard-input*))
  "This is the top-level function that Anmol will invoke when running your code."
  (loop repeat numtests do
        (let ((bingo-inputs (bingo-data str)))
          (if (verify-data (nth 0 bingo-inputs)
                           (nth 1 bingo-inputs)
                           (nth 2 bingo-inputs))
              (progn ;; use PROGN when you want to have a clause contain more than one function.
                (format t "VALID BINGO~%")
                t)
            (progn
              (format t "NO BINGO~%")
              nil)))))
