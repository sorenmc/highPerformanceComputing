PROGRAM helloWorld
INCLUDE 'mpif.h'

INTEGER ierr, rank,nNodes,i

!initialize MPI
CALL MPI_INIT(ierr);
!get number of processors
CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nNodes,ierr)
!get the rank of the processor
CALL MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)

PRINT *,"Hello world from processor ", rank, " out of ", nNodes

CALL MPI_Finalize(ierr);

END PROGRAM helloWorld
