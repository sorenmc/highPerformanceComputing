

PROGRAM pi
INCLUDE 'mpif.h'

REAL :: fourthOfPi, totalPi
INTEGER :: ierr, rank,nNodes,i
INTEGER :: root = 0
INTEGER :: message = 4
INTEGER :: stat(MPI_STATUS_SIZE)


!initialize MPI
CALL MPI_INIT(ierr);
!get number of processors
CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nNodes,ierr)
!get the rank of the processor
CALL MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)

fourthOfPi = insideRatio()
print*, "local value of 1/4 pi is:", fourthOfPi,"on processor",rank

CALL MPI_REDUCE(fourthOfPi,totalPi,1,MPI_REAL,MPI_SUM,root,MPI_COMM_WORLD,ierr)

IF(rank == root) THEN
    print*,"Estimated value of PI is:", totalPi
END IF

CALL MPI_Finalize(ierr)


contains
        REAL FUNCTION insideRatio()
            implicit none
            REAL :: radius = 1
            INTEGER :: i,nInside = 0
            INTEGER :: nIterations = 10000
            REAL :: x,y
            do i = 1,nIterations
                x = randRange()
                y = randRange()
        
                if ( sqrt(x**2+y**2) <= 1 ) THEN
                    nInside = nInside + 1
                END IF
            END DO
            
            insideRatio = nInside/real(nIterations)
          
            RETURN
        END FUNCTION insideRatio
        
        REAL FUNCTION randRange()
            implicit none
            REAL :: randN
            
            CALL random_number(randN)
            randRange = 2*randN-1
            
        END FUNCTION randRange

END PROGRAM pi


