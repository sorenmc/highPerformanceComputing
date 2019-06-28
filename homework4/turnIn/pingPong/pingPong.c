#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>

main(int argc, char** argv){
    int ierr;
    int nNodes;
    int rank;
    int destination = 1;
    int temp;
    int source = 0;
    int bounces = 5;

    ierr = MPI_Init(NULL, NULL);
    //get number of total processors
    MPI_Comm_size(MPI_COMM_WORLD, &nNodes);
    //get rank of processor
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);

     if (nNodes < 2) {
        fprintf(stderr, "World size must be greater than 1 for %s\n", argv[0]);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    //if it is the source processor, send
    while  (0 < bounces){
        if(rank == source){
            
            MPI_Send(&bounces,1,MPI_INT, destination,0,MPI_COMM_WORLD);
            printf("Processor %d sent the message: '%d bounces left'  to processor %d\n", rank, bounces, destination);
            

        //if it is the destination processor, receive
        }else if (rank==destination) {
            MPI_Recv(&bounces,1,MPI_INT, source,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
            printf("Processor %d received the message: '%d bounces left' from processor %d\n", rank, bounces, source);

        }
        printf("\n");
        source = !source;
        destination = !destination;
        bounces--;
    }
    ierr = MPI_Finalize();

}
