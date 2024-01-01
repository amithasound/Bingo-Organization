#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void rotate90Degrees(int matrix[5][5], int rotatedMatrix[5][5]) {
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            rotatedMatrix[j][4 - i] = matrix[i][j];
        }
    }
}

int contains(int n, int array[5][5]) {
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            if (array[i][j] == n) {
                return 1; // true
            }
        }
    }
    return 0; // false
}

int are2DArraysEqual(int arr1[5][5], int arr2[5][5]) {
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++){
            if (arr1[i][j] != arr2[i][j]) {
                return 0; // False
            }
        }
    }
    return 1; // True
}


int checkBingo(int board[5][5],  int pattern[5][5], int values[], int num, int callLength){
    int checkArray[5][5] = {{0}};
    int x, y, indexAtBingo = 0;
    int freeSpace = 0;
    int oneValuePattern;
    
    int result = 0;
      for (int r = 0; r < callLength; r++) { // For each value
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) { // Loop through each element in the board
                // printf("hi4");
                if (board[i][j] == values[r]) { // If board has the value
                    x = i; // Save index
                    y = j;
                }
                
                if (board[i][j] == 0 && pattern[i][j] == num) {
                    freeSpace = 1;
                    checkArray[i][j] = num;
                }
            }
        }//end of both loops
             printf("hi5");
            if (pattern[x][y] == num) {
                checkArray[x][y] = num;
            }
            // printf("pattern \n");
            // for (int row = 0; row < 5; row++) {
            //          for (int col = 0; col < 5; col++) {
            //     printf("%d ", pattern[row][col]);
            // }
            //         printf("\n");
            // }
                 
            // printf("checking \n");     
            // for (int row = 0; row < 5; row++) {
            //     for (int col = 0; col < 5; col++) {
            //       printf("%d ", checkArray[row][col]);
            //     }
            //         printf("\n");
            // }

            if (are2DArraysEqual(pattern, checkArray) == 1) { //big if
                oneValuePattern = 0;
                indexAtBingo = r;
                  printf("hi6");
                if(callLength == 1 && freeSpace == 0){
                    oneValuePattern = 1;
                }
                
                if((r = callLength-1) && oneValuePattern == 0){
                    return 1;
                }else{
                    return 0;
                }
              
            }//end of entire if
      }//end of big loop
      
    return 0;
    }


int main() {
    int pattern[5][5]; // 5 rows of 5 characters each
    char numbersArray[100];
    char numbersArray2[100];
    char numbersArray3[226];
    char numbers[10];
    int board[5][5];
    char temp[20];
    
    int arr1[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
    int arr2[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
    
 
while(fgets(numbers, sizeof(numbers), stdin) != NULL ){
    
    printf("hi");
    char *token2 = strtok(numbers, " ");
    int k = 0;
    
    while(token2 != NULL){
        pattern[0][k] = atoi(token2);
        k++;
        token2 = strtok(NULL, " ");
    
    }
    
    for (int row = 1; row < 5; row++) {
        for (int col = 0; col < 5; col++) {
            if (scanf(" %d", &pattern[row][col]) != 1) {
                // Handle error or end-of-file here
                perror("scanf");
                return 1;
            }
        }
    }

    fgets(numbersArray, sizeof(numbersArray), stdin);
    fgets(numbersArray2, sizeof(numbersArray2), stdin);
    fgets(numbersArray3, sizeof(numbersArray3), stdin);
    
    int values[226];
    char *token = strtok(numbersArray3, " ");
    int numOfCalls = 0;

    // Loop to tokenize and convert each substring to an integer
    while (token != NULL) {
        values[numOfCalls] = atoi(token); // Convert the token to an integer
        numOfCalls++;
        token = strtok(NULL, " ");
    }
 
    for (int row = 0; row < 5; row++) {
        for (int col = 0; col < 5; col++) {
            scanf(" %d", &board[row][col]);
        }
    }
     
    fgets(temp, sizeof(temp), stdin);
     printf("hi2");
     if(contains(1, pattern) == 1){
         printf("hi3");
         if(checkBingo(board, pattern, values, 1, numOfCalls)== 1){
	   		printf("VALID BINGO \n");
	   }else if(checkBingo(board, pattern, values, 1, numOfCalls)== 0) {
	           printf("NO BINGO \n");
	   }
    }else if(contains(4, pattern) == 1){
        //printf("hi3");
        int rotatedMatrix[5][5];
        int rotatedMatrix2[5][5];
        int rotatedMatrix3[5][5];
        rotate90Degrees(pattern, rotatedMatrix);
        rotate90Degrees(rotatedMatrix, rotatedMatrix2);
        rotate90Degrees(rotatedMatrix2, rotatedMatrix3);
        
        
        
        
        if(checkBingo(board, pattern, values, 4, numOfCalls)== 1){
	   		printf("VALID BINGO \n");
	    }else if(checkBingo(rotatedMatrix, pattern, values, 4, numOfCalls)== 1) {
	           	printf("VALID BINGO \n");
        }else if(checkBingo(rotatedMatrix2, pattern, values, 4, numOfCalls)== 1) {
	           	printf("VALID BINGO \n");
	    }else if(checkBingo(rotatedMatrix3, pattern, values, 4, numOfCalls)== 1) {
	           	printf("VALID BINGO \n");
	     }else{
	         	printf("NO BINGO\n");
        }
    }
    
      

    printf("You entered the following characters:\n");
    for (int row = 0; row < 5; row++) {
        for (int col = 0; col < 5; col++) {
            printf("%d ", pattern[row][col]);
        }
        printf("\n");
    }
    
    printf("Values:\n");
    int num_integers = numOfCalls;
    
    for (int i = 0; i < num_integers; i++) {
        printf("%d ", values[i]);
    }
     printf("\n");
    
    printf("You entered the following characters:\n");
        for (int row = 0; row < 5; row++) {
            for (int col = 0; col < 5; col++) {
                printf("%d ", board[row][col]);
            }
            printf("\n");
        }
        
        
    
        
        
    }//while loop
    
    
}






