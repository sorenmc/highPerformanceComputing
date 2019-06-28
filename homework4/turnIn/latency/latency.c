#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>

int pingPong(int arrayLength, int rank){
    
    int i;
    int source = 0;
    int destination = 1;
    int message[arrayLength];
    int bounces = 5;

 
    for(i = 0; i< arrayLength; i++){
        message[i] = i;
    }

    //if it is the source processor, send
    while  (0 < bounces){
        if(rank == source){
            
            MPI_Send(&message,arrayLength,MPI_INT, destination,0,MPI_COMM_WORLD);
            printf("Processor %d sent the message:\n[",rank);
            for(i = 0; i<arrayLength;i++){
                printf("%d, ",message[i]);
            }
            printf("]\n");
            printf("with %d bounces left, to processor %d\n", bounces, destination);
            
            

        //if it is the destination processor, receive
        }else if (rank==destination) {
            MPI_Recv(&message,arrayLength,MPI_INT, source,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);

            printf("Processor %d received the message:\n[",rank);
            for(i = 0; i<arrayLength;i++){
                printf("%d, ",message[i]);
            }
            printf("]\n");
            printf("with %d bounces left, from processor %d\n", bounces, source);
            

        }
        printf("\n");
        source = !source;
        destination = !destination;
        bounces--;
    }

}


main(int argc, char** argv){

    int ierr;
    int i;
    int nNodes;
    int rank;
    int destination = 1;
    int source = 0;
    int loops = 10;
    double wTime1;
    double wTime2;
    

    

    ierr = MPI_Init(NULL, NULL);
    //get number of total processors
    MPI_Comm_size(MPI_COMM_WORLD, &nNodes);
    //get rank of processor
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);

    if (nNodes < 2) {
        printf("Insufficient amount of nodes: %d nodes", nNodes);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    //vary the length of array (message size to figure out time constant)
    
    for(i = 1; i < loops; i++ ){
        wTime1 = MPI_Wtime();
        pingPong(i,rank);//pass length of array to function
        wTime2 = MPI_Wtime();
        wTime2 -= wTime1;
        printf("number of elements in array was %d and time is %f\n",i, wTime2);
        printf("\n\n");
    }

    ierr = MPI_Finalize();
}
