PROGRAM pingPong
INCLUDE 'mpif.h'

INTEGER :: ierr, rank,nNodes,i
INTEGER :: bounce = 1
INTEGER :: source = 0
INTEGER :: destination = 1
INTEGER :: stat(MPI_STATUS_SIZE)

!initialize MPI
CALL MPI_INIT(ierr);
!get number of processors
CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nNodes,ierr)
!get the rank of the processor
CALL MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)

IF(rank .EQ. source) THEN
    bounce = 5
END IF

DO WHILE(0 < bounce )
    IF(rank .EQ. source) THEN
        CALL MPI_SEND(bounce,1,MPI_INTEGER,destination,0,MPI_COMM_WORLD,ierr)
        print *,"message sent: ",bounce," from processor ", rank, " to processor ", destination 
        
    ELSE IF(rank .EQ. destination) THEN
        CALL MPI_RECV(bounce,1,MPI_INTEGER,source,0,MPI_COMM_WORLD,stat,ierr)
        print *,"message received: ",bounce," on processor ", rank , "from processor ", source
    END IF
    source = ieor(source,1)
    destination = ieor(destination,1)
    bounce = bounce-1

END DO

CALL MPI_Finalize(ierr);

STOP
END PROGRAM pingPong

