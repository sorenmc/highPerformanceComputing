#include <stdio.h>
#include <time.h>
//#include <mpi.h>
#include <math.h>
#include <stdlib.h>

float randN(){
    srand(time(NULL));
    return (((float)rand()/RAND_MAX)*2-1 );
}



float RandRange(int Min, int Max){
    int diff = Max-Min;
    return (((float)(diff+1)/(float)RAND_MAX) * (float)rand() + (float)Min);
}

int main(){
    int i;
    float randn=0.0;
    for(i = 0; i<100;i++){
        randn = (float)randN();
        printf("random number between -1,1:  %f\n",randn);
    }
}