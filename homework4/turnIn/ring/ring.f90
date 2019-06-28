PROGRAM ring
INCLUDE 'mpif.h'

INTEGER :: ierr, rank,nNodes,i
INTEGER :: source = 0
INTEGER :: destination = 1
INTEGER :: message = 4
INTEGER :: stat(MPI_STATUS_SIZE)

!initialize MPI
CALL MPI_INIT(ierr);
!get number of processors
CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nNodes,ierr)
!get the rank of the processor
CALL MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)

IF(rank .EQ. source) THEN
    message = 5
END IF

DO i = 0,nNodes-1
    source = i
    IF(source .EQ. nNodes-1) THEN
        destination = 0
    ELSE 
        destination = i+1
    END IF

    IF(rank .EQ. source) THEN
        CALL MPI_Send(message,1,MPI_INT,destination,0,MPI_COMM_WORLD,ierr)
        print *,"message sent:",message,"from processor", rank, "to processor", destination 
    ELSE IF(rank .EQ. destination) THEN
        CALL MPI_Recv(message,1,MPI_INT,source,0,MPI_COMM_WORLD,stat,ierr)
        print *,"message received:",message,"on processor", rank , "from processor", source
    END IF

END DO


CALL MPI_Finalize(ierr);
    
END PROGRAM ring
