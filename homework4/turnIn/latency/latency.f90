PROGRAM latency
INCLUDE 'mpif.h'

INTEGER :: ierr, rank,nNodes,i
INTEGER :: bounce = 1
INTEGER :: arraySize = 1
DOUBLE PRECISION :: wTime1,wTime2;

!initialize MPI
CALL MPI_INIT(ierr);
!get number of processors
CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nNodes,ierr)
!get the rank of the processor
CALL MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)



DO WHILE(arraySize<20)

    wTime1 = MPI_WTIME()
    i = pingpong(rank,arraySize)
    wTime2 = MPI_WTIME()
    wTime2 = wTime2-wTime1
    print*, "The array size was:",arraySize,"and the time it took was:",wTime2
    arraySize = arraySize+1
END DO


CALL MPI_Finalize(ierr);

contains

    INTEGER FUNCTION pingPong(rank,arraySize)
        INTEGER, intent(in) :: rank,arraySize
        INTEGER :: status(MPI_STATUS_SIZE)
        INTEGER :: source = 0
        INTEGER :: destination = 1
        INTEGER, dimension(:),allocatable :: message
        INTEGER :: i = 1
        INTEGER :: bounce = 5

        ALLOCATE(message(arraySize))
        DO i = 1,arraySize 
            message(i) = i
        end do

        DO i = 1,bounce
            IF(rank .EQ. source) THEN
                CALL MPI_SEND(message,arraySize,MPI_INTEGER,destination,0,MPI_COMM_WORLD,ierr)
            ELSE IF(rank .EQ. destination) THEN
                CALL MPI_RECV(message,arraySize,MPI_INTEGER,source,0,MPI_COMM_WORLD,status,ierr)
            END IF
        
            !swap source and destination with xor function
            source = ieor(source,1)
            destination = ieor(destination,1)
        
        END DO


        pingPong = 0

    END FUNCTION 

END PROGRAM latency
