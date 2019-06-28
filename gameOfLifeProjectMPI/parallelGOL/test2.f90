PROGRAM test
    INCLUDE 'mpif.h' 
    INTEGER ::  ierr, i,ii,j,jj, rank,nNodes,dim,subDim, startLoop, endLoop,disp
    INTEGER , DIMENSION (:,:),ALLOCATABLE  :: subNextBoard,board
    INTEGER , DIMENSION (:), ALLOCATABLE :: receiveBuff,recvCounts,sendBuff
    
    dim = 6

    !initialize MPI
    CALL MPI_INIT(ierr);
    !get number of processors
    CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nNodes,ierr)
    !get the rank of the processor
    CALL MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)

    IF (modulo(dim,nNodes) .NE. 0) THEN 
        print*, "Select a number of nodes that is equally divisable with the dimension = ", dim
        CALL MPI_ABORT(MPI_COMM_WORLD,ierr)
    END IF

    subDim = (dim-rank-1)/nNodes+1
    ALLOCATE(board(dim,dim))
    allocate(receiveBuff(dim*dim))
    allocate(sendBuff(dim*subDim))
    
    board(:,:) = 0

    receiveBuff(:) = 0
    sendBuff(:) = rank
    

    CALL MPI_allgather(sendBuff,dim*subDim,MPI_INTEGER,receiveBuff,dim*subDim,MPI_INTEGER,MPI_COMM_WORLD,ierr)
    board = reshape(receiveBuff,(/dim,dim/))
    CALL printBoard(dim,dim,board)

    

    CALL MPI_Finalize(ierr);

contains

SUBROUTINE printBoard(dim,subDim,board)
    IMPLICIT NONE
    INTEGER dim,subDim, board(dim,subDim)
    DO i = 1, dim,1
        print*, board(i,:)
    END DO
    print*, ""
END SUBROUTINE

SUBROUTINE getStartAndEnd(startLoop,endLoop, dim, subDim,rank,nNodes)

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

END PROGRAM test
    