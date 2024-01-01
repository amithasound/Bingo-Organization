/*
 * @author Amitha Soundararajan 
 * Organization of Programming Languages_1 - Dr. Klassner
 * Bingo - Java 
 * September 10, 2023 
 * 
 */

import java.util.*;
public class Bingo {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner kb = new Scanner(System.in);    
		int[][] pattern = new int[5][5];
		int[][] board = new int[5][5];
	 	boolean runLoop = true;
	 	boolean line1;

	while(runLoop) {
         // Check if the second line is empty or null
		for (int i = 0; i< 5; i++) {
			for (int j = 0; j<5; j++) {
			    	int z = kb.nextInt();
			        pattern[i][j] = z;
			}
		}
		
		kb.nextLine();
		kb.nextLine();  
		
		String nums = kb.nextLine();
	   	String parts[] = nums.split(" ");
	
	   	
	   	int [] values = new int [parts.length];
	    for(int i=0; i<parts.length; i++) {
	       values[i] = Integer.parseInt(parts[i]);
	    }
	
	
	    for (int i = 0; i< 5; i++) {
			for (int j = 0; j<5; j++) {
			    	int z = kb.nextInt();
			        board[i][j] = z;
			}
		}
	 
		
	    if(crazyOrNot(pattern) == "Normal") {
	    	if(checkBingo(values, pattern, board, 1)== true){
	    		System.out.println("VALID BINGO");
	    	}else if(checkBingo(values, pattern, board, 1)== false) {
	    		System.out.println("NO BINGO");
	    	}
		}else if(crazyOrNot(pattern) == "Crazy"){
			 int[][] rotatedArray = rotate90Degrees(pattern);
			 int[][] rotatedArray1 = rotate90Degrees(rotatedArray);
			 int[][] rotatedArray2 = rotate90Degrees(rotatedArray1);
			
			if(checkBingo(values,pattern,board,4)==true){
				System.out.println("VALID BINGO");
			}else if(checkBingo(values,rotatedArray,board,4)==true) {
				System.out.println("VALID BINGO");
			}else if(checkBingo(values,rotatedArray1,board,4)==true) {
				System.out.println("VALID BINGO");
			}else if(checkBingo(values,rotatedArray2,board,4)==true) {
				System.out.println("VALID BINGO");
			}else {
				System.out.println("NO BINGO");
			}
		}else {
			System.out.println("NO BINGO");
			// all zeros
		}
	    
	    if(kb.hasNext()) {
	    	runLoop = true;
	    }else {
	    	runLoop = false;
	    }
	 }
		//kb.close()
}// end of main
	public static boolean checkBingo(int []values,int[][] pattern, int [][] board, int num) {
		
	
		int[][] checkArray = new int[5][5];
		int x = 0;
		int y = 0;
		int indexAtBingo = 0;
		
		
		
		for(int r = 0; r< values.length;r++) {//for each value search the entire board
			 for (int i = 0; i < 5; i++) {
		            for (int j = 0; j < 5; j++) {
		                if (board[i][j] == values[r]) { //if board contains called number
		                    x = i; //saving the index of value on the board 
		                    y = j;
		                }
		                
		                if ((board[i][j] == 0) && (pattern[i][j] == num)) { //if board contains called number
		                    checkArray[i][j]= num;
		                }
		               
		            }
		        }
		      
			 	
			 
			if(pattern[x][y] == num) { //if the value on the board has a 1 or 4 on the pattern
				checkArray[x][y] = num; //new board is updated to have a 1 or 4 
			}
			
		if(areArraysEqual(pattern, checkArray)){ //check at each value if the two board are equal (BINGO)
				indexAtBingo = r; // finding out what index of values Bingo occurred at
				
				if(r == values.length -1) 
				{
					return true;
				}else {
					return false;
				}
			}
		 }
		return false;	
		
	}
	
	public static String crazyOrNot(int[][] arr1) {
		for (int i = 0; i < 5; i++) { //this equals to the row in our matrix.
		     for (int j = 0; j < 5; j++) { //this equals to the column in each row.
		        if(arr1[i][j] == 4) {
		        	return "Crazy";
		        }else if(arr1[i][j] == 1) {
		        	return "Normal";
		        }
		       
		     }
		 } 
		return "Other";
	}

	public static boolean areArraysEqual(int[][] arr1, int[][] arr2) {
        for (int i = 0; i < arr1.length; i++) {
            for (int j = 0; j < arr1[i].length; j++) {
                if (arr1[i][j] != arr2[i][j]) { // Elements are not equal
                    return false; 
                }
            }
        }

        return true;
	}

	public static int[][] rotate90Degrees(int[][] matrix) {
    int[][] rotatedMatrix = new int[5][5];
   
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
            	rotatedMatrix[j][4-i] = matrix[i][j];
            	}
        }
        return rotatedMatrix;
    }
  }// end of class
