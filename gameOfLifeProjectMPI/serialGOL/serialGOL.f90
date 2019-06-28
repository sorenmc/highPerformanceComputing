PROGRAM serialGOL
    IMPLICIT NONE 
    INTEGER :: dim, i,j,nIterations, aliveNeighbours
    REAL :: rand,minValue
    DOUBLE PRECISION :: t1,t2
    INTEGER, DIMENSION (:,:), ALLOCATABLE :: nextBoard, board
    
    !initialize field
    dim = 4
    ALLOCATE(board(dim,dim))
    ALLOCATE(nextBoard(dim,dim))

    CALL initializeBoard(dim,board)
    nextBoard = board

    CALL printBoard(dim,board)
    
    nIterations = 0
    DO WHILE(nIterations < 10)
        DO i = 1, dim, 1
            DO j = 1, dim, 1
                aliveNeighbours = getNumNeighbours(i,j,dim,board)
                nextBoard = updateBoard(dim,aliveNeighbours,i,j,nextBoard)
                print*, "alive = ",aliveNeighbours,"i=",i,"j=",j
            END DO
        END DO 
        
        board = nextBoard
        CALL printBoard(dim,board)
        nIterations = nIterations + 1
    
    END DO

contains

INTEGER FUNCTION getNumNeighbours(row,col,dim,board)
    IMPLICIT NONE   
    INTEGER :: row,col,dim,board(dim,dim)
    INTEGER :: aliveNeighbours,i,j
    aliveNeighbours = 0
    DO i = -1 , 1, 1
        DO j = -1 , 1, 1
            !
            IF ( (i .EQ. 0 .AND. j .EQ. 0) .OR. .NOT.( neighbourInside(row+i,col+j,dim,board) ) ) THEN
            !don't do anything if either i and j are both 0 or the neighbour is outside of boundary
            ELSE IF (board(row+i,col+j) .EQ. 1) THEN
                aliveNeighbours = aliveNeighbours+1

            END IF
        END DO
    END DO
    
    

    getNumNeighbours = aliveNeighbours

END FUNCTION

FUNCTION updateBoard(dim,aliveNeighbours,row,col,board)
    IMPLICIT NONE
    INTEGER dim,aliveNeighbours,row,col,board(dim,dim)
    INTEGER updateBoard(dim,dim)

    IF(aliveNeighbours < 2) THEN
        board(row,col) = 0
    ELSE IF(3 <= aliveNeighbours ) THEN
        board(row,col) = 1
    END IF

    updateBoard = board

END FUNCTION

SUBROUTINE initializeBoard(dim,board)
    IMPLICIT NONE
    INTEGER dim, board(dim,dim)
    DO i = 1, dim,1
        DO j = 1,dim,1
            board(i,j) = 0
        END DO
    END DO
    
    board(2,1) = 1
    board(2,2) = 1
    board(2,3) = 1
END SUBROUTINE

SUBROUTINE printBoard(dim,board)
    IMPLICIT NONE
    INTEGER dim, board(dim,dim)
    DO i = 1, dim,1
        print*, board(:,i)
    END DO
    print*, ""

END SUBROUTINE


LOGICAL FUNCTION neighbourInside(i,j,dim,board)
    IMPLICIT NONE
    INTEGER i,j,dim,board(dim,dim)
    IF( (i .EQ. 0 .OR. j .EQ. 0) .OR. (i .EQ. dim+1 .OR. j .EQ. dim+1)) THEN
        neighbourInside = .FALSE.
    ELSE 
        neighbourInside = .TRUE.
    END IF
    
END FUNCTION neighbourInside

END PROGRAM serialGOL
    