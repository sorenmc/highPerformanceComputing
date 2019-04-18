PROGRAM ones
    !dynamic array - dimension unknown to us before runtime
    integer :: dim, rand !length and hight of matrix, random number
    real :: r
    real, dimension (:,:), allocatable :: squareArray, neighborArray

    WRITE(*,*) "Size of the square array?"
    READ *,dimension

    
    !randomly initialize an array with 1's in some coloumns and 0's in others
    ALLOCATE(squareArray(dim,dim))
    DO i = 1, dim,1
        CALL random_number(r)
        rand = floor( r*2 ) !rand is either 0 or 1
        squareArray(:,i) = rand
    END DO
    
    
    !Assigns a 1 to an array position
    !if the same spot in the other array has 3 neighbors that are 1s
    ALLOCATE(neighborArray(dim,dim))
    do i = 1, dim,1
        do j = 1, dim,1
            if (neighbors(squareArray,i,j,dim) > 2) then
                neighborArray(i,j) = 1
            end if
        end do
    end do
    
    print *, neighborArray

END PROGRAM ones 


INTEGER FUNCTION neighbors(array,i,j,dim) RESULT(y)
    !Returns the number of neighbors the current node in the array has
    
    INTEGER :: nNeighbors = 0

    if (i/=1) THEN
        if (j/=1 .and. array(i-1,j-1) == 1) THEN !top left
            nNeighbors = nNeighbors + 1
        end if
        if (j/=dim .and. array(i-1,j+1) == 1) THEN !top right
            nNeighbors = nNeighbors + 1
        end if
        if (array(i-1,j) == 1) THEN !top middle
            nNeighbors = nNeighbors + 1
        end if
    end if

    if (i/=dim) THEN 
        if (j/=1 .and. array(i+1,j-1) == 1 ) THEN !bottom left
            nNeighbors = nNeighbors + 1
        end if
        if (j/=dim .and. array(i+1,j+1) == 1 ) THEN !bottom right
            nNeighbors = nNeighbors + 1
        end if
        if (array(i+1,j) == 1 ) THEN !bottom center
            nNeighbors = nNeighbors + 1
        end if
    end if

    if (j/= 1 .and. array(i,j-1) == 1) THEN !left
        nNeighbors = nNeighbors + 1
    end if
    if (j/= dim .and. array(i,j+1) == 1) THEN !left
            nNeighbors = nNeighbors + 1
    end if
    
    y = nNeighbors
end function