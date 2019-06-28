#include <stdio.h>
#include <stdlib.h>

#define nGrid 4

struct gol{
    char board[nGrid][nGrid] = {0};
}

char getNNeighbors(struct gol game,char cellRow, char cellCol){
    char left,right,top,bot,liveNeighbors = 0;
    char i,j;
    
    for(i = -1 ; i<=1 ; i++){
        for(j = -1 ; j<=1 ; j++){
            top = cellRow != 0 && i != -1;
            bot = cellRow != nGrid-1 && i != 1;
            left = cellCol != 0 && j != -1;
            right = cellCol != nGrid-1 && j != 1;

            if ( top && bot && left && right && game.board[cellRow+i][cellCol+j]){
                liveNeighbors++;
            }
        }
    }  
    return liveNeighbors;
}

char updateGame(char golMatrix[nGrid][nGrid],char cellRow, char cellCol, char liveNeighbors){
    
    if(liveNeighbors < 2 ){
        golMatrix[cellRow][cellCol] = 0;
    } else if (3 <= liveNeighbors){
        golMatrix[cellRow][cellCol] = 1;
    }
    return golMatrix;
}
    
int main(){
    char gameAlive = 1;
    char i,j,liveNeighbors;
    char golMatrix[nGrid][nGrid];

    struct gol game;
    //char (*golMatrix)[nGrid] = malloc(sizeof(*golMatrix) * nGrid );
    game.board[1][1] = 1;
    game.board[1][2] = 1;
    game.board[1][3] = 1;

    while(gameAlive < 5){
        for(i = 0 ; i < nGrid ; i++ ){
            for(j = 0 ; j < nGrid ; j++ ){

                
                
                liveNeighbors = getNNeighbors(game,i,j);
            
                //golMatrix = updateGame(golMatrix,i,j,liveNeighbors);
                printf("%d",golMatrix[i][j]);
                
                
            }
            printf("\n");
        }
        printf("\n\n");
        gameAlive++;

    }
}

