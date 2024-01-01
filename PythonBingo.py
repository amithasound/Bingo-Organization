# Amitha Soundararajan 
# Organization of PL - 01 (Python)

import sys
def main():
      # Read the input data from standard input
      new_list = []
      subarrays = []

      for line in sys.stdin:
           line = line.strip()
           if line:
             new_list.append(line)

      for i in range(0, len(new_list), 11 ):
         subarray = new_list[i: i + 11]
         subarrays.append(subarray)
   

      for subarray in subarrays: 
         raw_pattern = subarray[0:5]
         calls = subarray[5].split() 
         raw_board = subarray[-5:]

         pattern = []
         for line in raw_pattern:
            row = line.split()
            pattern.append(row)

         board = []
         for line in raw_board:
            row = line.split()
            board.append(row)


         if(contains('1',pattern)):
            if(check_bingo(calls, pattern, board, '1') == True):
                 print("VALID BINGO")
            elif(check_bingo(calls, pattern, board, '1') == False):
                  print("NO BINGO")
         elif(contains('4',pattern)):
             if(check_bingo(calls, pattern, board, '4') == True):
                 print("VALID BINGO")
             else:
                  rotation90 = list(zip(*pattern[::-1]))
                  if(check_bingo(calls, rotation90, board, '4') == True):
                        print("VALID BINGO")
                  else:
                     rotation180 = list(zip(*rotation90[::-1]))
                     if(check_bingo(calls, rotation180, board, '4') == True):
                           print("VALID BINGO")
                     else: 
                           rotation270 = list(zip(*rotation180[::-1]))
                           if(check_bingo(calls, rotation270, board, '4') == True):
                              print("VALID BINGO")
                           else:
                              print("NO BINGO")
         else:
            print("NO BINGO")

def check_bingo(values, pattern, board, num):
   check_array = [['0' for _ in range(5)] for _ in range(5)]
   x, y, index_at_bingo = 0, 0, 0
   free_space = False

   for r in range(len(values)):#for each value
        for i in range(5):
            for j in range(5): #loop thru each element in the board 
               #print(board[i][j])
               if board[i][j] == values[r]: #if board has value
                  x = i # save value 
                  y = j
                  
               if board[i][j] == '00' and pattern[i][j] == num:
                  free_space = True
                  check_array[i][j] = num
                  
        if pattern[x][y] == num:
            check_array[x][y] = num


        if are_arrays_equal(pattern, check_array):
            one_value_pattern = False
            index_at_bingo = r

            if len(values) == 1 and free_space == True:
               one_value_pattern = True
                
      
            if r == len(values)-1 and one_value_pattern == False:
               return True
            else:
                return False
            
   return False

def pprint(m):
   for row in m:
      for item in row:
         print(item, end=' ')
      print()


def contains(n, array):
    for row in array:
            for value in row:
               if value == n:
                  return True






def are_arrays_equal(arr1, arr2):
    for i in range(len(arr1)):
        for j in range(len(arr1[i])):
            if arr1[i][j] != arr2[i][j]:
                # Elements are not equal
                return False
    return True
         
main()