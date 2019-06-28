#include <stdio.h>
#include <mpi.h>

main(int argc, char **argv){
    int ierr; //the variable that initializes everything
    int nameLen;
    int nNodes;
    int rank;
    
    //initialize MPI
    ierr = MPI_Init(&argc, &argv);
    // get number of processors
    MPI_Comm_size(MPI_COMM_WORLD, &nNodes);
    //get the rank of the processor
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);
    
    printf("Hello world from processor %d out of %d processors\n",rank,nNodes);

    ierr = MPI_Finalize();
 
}
