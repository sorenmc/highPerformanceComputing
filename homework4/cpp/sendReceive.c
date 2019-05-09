#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>

main(int argc, char** argv){
    int ierr;
    int nNodes;
    int rank;
    int message;
    int destination;
    int source;

    ierr = MPI_Init(NULL, NULL);
    //get number of total processors
    MPI_Comm_size(MPI_COMM_WORLD, &nNodes);
    //get rank of processor
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);

     if (nNodes < 2) {
        fprintf(stderr, "World size must be greater than 1 for %s\n", argv[0]);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    //if it is the first processor, send
    if(rank == 0){
        message = 5;
        destination = rank+1;
        MPI_Send(&message,1,MPI_INT, destination,0,MPI_COMM_WORLD);
        printf("Processor %d sent the message: %d to processor %d\n", rank, message, destination);
    
    //if it is the second processor, receive
    }else if (rank==1) {
        source = rank-1;
        MPI_Recv(&message,1,MPI_INT, source,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
        printf("Processor %d received the message: %d from processor %d\n", rank, message, source);
    }

    ierr = MPI_Finalize();

}