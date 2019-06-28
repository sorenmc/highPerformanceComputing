PROGRAM parallelGOL
    INCLUDE 'mpif.h' 
    INTEGER ::  ierr,rank,nNodes
    INTEGER ::  i,ii,j,jj,nIterations, aliveNeighbours,dim,subDim,startLoop,endLoop,subAliveCells,nAliveCells
    LOGICAL :: gameAlive = .TRUE. 
    INTEGER , DIMENSION (:,:),ALLOCATABLE  :: subNextBoard,board
    INTEGER , DIMENSION (:), ALLOCATABLE :: receiveBuff,sendBuff,recvCounts
    nIterations = 0

    dim = 12
    

    !initialize MPI
    CALL MPI_INIT(ierr);
    !get number of processors
    CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nNodes,ierr)
    !get the rank of the processor
    CALL MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)
    
    ! MAKE SURE THAT THE NUMBER OF PROCESSORS CAN EVENLY DIVIDE number of columns of the board
    IF (modulo(dim,nNodes) .NE. 0) THEN 
        print*, "Select a number of nodes that is equally divisable with the dimension = ", dim
        CALL MPI_ABORT(MPI_COMM_WORLD,ierr)
    END IF

    subDim = (dim-rank-1)/nNodes+1 !number of columns to give each processor
    
    allocate(board(dim,dim))
    allocate(receiveBuff(dim*dim))
    allocate(subNextBoard(dim,subDim))
    allocate(sendBuff(dim*subDim))

    board(:,:) = 0
    receiveBuff(:) = 0
    sendBuff(:) = 0
    board(6,5) = 1
    board(6,6) = 1
    board(6,7) = 1
    board(5,6) = 1

    !CALL initBoard(dim,board)

    !make subNextBoard equal to the part of the board it mimics
    subNextBoard(:,:) = board(:,(rank)*subDim+1:(rank+1)*subDim)

    IF ( rank .EQ. 0) THEN
        print*,"board initialized"
        CALL printBoard(dim,dim,board)
        print*, ""
    END IF
    
    CALL getStartAndEnd(startLoop,endLoop, dim, subDim,rank,nNodes)


    DO WHILE(gameAlive)
        !alive neighbours 
        DO i = 1,dim,1
            ii = ii + 1
            DO j = startLoop, endLoop, 1
                jj = jj + 1
                aliveNeighbours = getNumNeighbours(i,j,dim,board)
                CALL updateSubBoard(dim,subDim,aliveNeighbours,ii,jj,subNextBoard,board(i,j))
            END DO
            jj = 0
        END DO 
        ii = 0

        sendBuff = reshape(subNextBoard,(/dim*subDim/))
        subAliveCells = sum(sendBuff)
        !get total number of alive cells
        CALL MPI_REDUCE(subAliveCells,nAliveCells,1,MPI_INTEGER,MPI_SUM,0,MPI_COMM_WORLD,ierr) 
        !concatenate all sub boards to get the updated board.
        CALL MPI_allgather(sendBuff,dim*subDim,MPI_INTEGER,receiveBuff,dim*subDim,MPI_INTEGER,MPI_COMM_WORLD,ierr) 
        board = reshape(receiveBuff,(/dim,dim/))

        !print total number of alive cells and current board
        IF ( rank .EQ. 0) THEN
            print*, "total number of alive cells = ",nAliveCells
            CALL printBoard(dim,dim,board)
        END IF

        nIterations = nIterations+1
    END DO 
    
    CALL MPI_Finalize(ierr);

contains
INTEGER FUNCTION getNumNeighbours(row,col,dim,board)
    !returns number of neighbours for a given cell
    IMPLICIT NONE   
    INTEGER :: row,col,dim,board(dim,dim)
    INTEGER :: aliveNeighbours,i,j
    aliveNeighbours = 0
    DO i = -1 , 1, 1
        DO j = -1 , 1, 1
            IF ( (i .EQ. 0 .AND. j .EQ. 0) .OR. .NOT.( neighbourInside(row+i,col+j,dim,board) ) ) THEN
            !don't do anything if either i and j are both 0 or the neighbour is outside of boundary
            ELSE IF (board(row+i,col+j) .EQ. 1) THEN
                aliveNeighbours = aliveNeighbours+1
            END IF
        END DO
    END DO


    getNumNeighbours = aliveNeighbours

END FUNCTION

SUBROUTINE updateSubBoard(dim,subDim,aliveNeighbours,row,col,subNextBoard,cValue)
    !updates the sub board stored in each processor.
    IMPLICIT NONE
    INTEGER dim,subDim,aliveNeighbours,row,col,nextValue,cValue
    INTEGER subNextBoard(dim,subDim)


    IF(aliveNeighbours .EQ. 3) THEN
        nextValue = 1
    ELSE IF(aliveNeighbours .EQ. 2) THEN
        nextValue = cValue
    ELSE IF (aliveNeighbours < 2 .OR. 3 <aliveNeighbours) THEN
        nextValue = 0
    END IF
    
    subNextBoard(row,col) = nextValue
END SUBROUTINE

SUBROUTINE initBoard(dim,board)
    INTEGER dim , board(dim,dim)
    INTEGER ::  inputX,inputY,nCoordinates
    print*, "How many cells do you want?"
    read(*,*) nCoordinates

    DO i = 1, nCoordinates,1
        print*,"x coordinate?"
        read(*,*) inputX
        print*,"y coordinate?"
        read(*,*) inputY
        board(inputX,inputY) = 1
    END DO

END SUBROUTINE

SUBROUTINE printBoard(dim,subDim,board)
    !prints the board
    IMPLICIT NONE
    INTEGER dim,subDim, board(dim,subDim)
    DO i = 1, dim,1
        print*, board(i,:)
    END DO
    print*, ""
END SUBROUTINE

SUBROUTINE getStartAndEnd(startLoop,endLoop, dim, subDim,rank,nNodes)
    !updates the start and end column for each processor (the columns that the processor will be looking at)
    IMPLICIT NONE
    INTEGER i, startLoop,endLoop, dim, subDim,rank, nNodes, nExtra
    nExtra = modulo(dim,nNodes)
    IF (rank < nExtra) THEN 
        startLoop = 1 + subDim*rank
    ELSE
        startLoop = nExtra*(subDim+1)+subDim*(rank-nExtra)+1
    END IF
    
    endLoop = startLoop + subDim-1
END SUBROUTINE

LOGICAL FUNCTION neighbourInside(i,j,dim,board)
    !returns true if the neighbour is within the boards boundaries.
    IMPLICIT NONE
    INTEGER i,j,dim,board(dim,dim)
    IF( (i .EQ. 0 .OR. j .EQ. 0) .OR. (i .EQ. dim+1 .OR. j .EQ. dim+1)) THEN
        neighbourInside = .FALSE.
    ELSE 
        neighbourInside = .TRUE.
    END IF
END FUNCTION neighbourInside

END PROGRAM parallelGOL
    