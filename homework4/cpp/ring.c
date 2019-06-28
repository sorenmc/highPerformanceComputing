#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>


int main(int argv, char *argc){
    int ierr;
    int nNodes;
    int rank;
    int message = 0;
    int source,destination;

    ierr = MPI_Init(NULL, NULL);
    //get number of total processors
    MPI_Comm_size(MPI_COMM_WORLD, &nNodes);
    //get rank of processor
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);

    if (rank == 0){
        message = 4;
    }

    for(source = 0; source < nNodes;source++){
        
        //make sure destination is the right one
        if(source == nNodes-1){
            destination = 0;
        }else{
            destination = source+1;
        }

        
        if(source == rank){
            MPI_Send(&message,1,MPI_INT, destination,0,MPI_COMM_WORLD);
            printf("processor %d sent the message: %d to processor %d\n", source, message, destination);

        }else if(destination == rank){
            MPI_Recv(&message,1,MPI_INT, source,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
            printf("processor %d received the message %d from processor %d\n", destination, message, source);

        }    
    }

    ierr = MPI_Finalize();
    return ierr;
}