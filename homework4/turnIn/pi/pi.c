#include <stdio.h>
#include <time.h>
#include <mpi.h>
#include <math.h>
#include <stdlib.h>

float randRange(float a, float b){
    
    return ((b - a) * ((float)rand() / RAND_MAX)) + a;
}

float insideRatio(nIterations,rank){
    float x;
    float y;
    float fourthOfPi;
    float randMin = -1;
    float randMax = 1;
    int i;
    int nInside = 0;

    //generate x and y coordinates. Since the circle has the radius 1, the dart arrow will be inside the circle
    // if the euclidian distance is 1 or less
    srand(rank);
    for(i = 0 ; i<nIterations;i++){
        x = randRange(randMin,randMax);
        y = randRange(randMin,randMax);
        if(sqrt((powf(x,2)+powf(y,2))) <=1 ){
            nInside++;
        }
    }

    fourthOfPi = ((float)nInside)/((float) nIterations);

    return fourthOfPi;

}

int main(int argv, char *argc){
    int ierr;
    int nProcessors; // total number of processors in the cluster
    int rank;//the processor number in the cluster
    int nInside = 0;
    int message = 0;
    int i;
    //int source,destination;
    
    int nIterations = 100000;
    float fourthOfPi;
    float totalPi;
    

    ierr = MPI_Init(NULL, NULL);
    //get number of total processors
    MPI_Comm_size(MPI_COMM_WORLD, &nProcessors);
    //get rank of processor
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);

    
    fourthOfPi = insideRatio(nIterations);
    printf("processor is %d and the fourthOfPi is: %f\n", rank, fourthOfPi);
    
    //sendbuffer, receive buffer, count, data type, operation, root rank, MPI_COMM_WORLD
    MPI_Reduce(&fourthOfPi ,&totalPi ,1 ,MPI_FLOAT,MPI_SUM, 0, MPI_COMM_WORLD);

    if(rank == 0){
        printf("Calculated pi is: %f\n", totalPi);
    }
    
    

    ierr = MPI_Finalize();
}
