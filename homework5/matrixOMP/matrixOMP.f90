PROGRAM matrixOMP
IMPLICIT NONE 
INTEGER  NTHREADS, TID, OMP_GET_NUM_THREADS, OMP_GET_THREAD_NUM
double precision OMP_GET_WTIME
integer :: dim, i,j
real :: rand,minValue
double precision :: t1,t2
real, dimension (:,:), allocatable :: A,B,C
real, dimension (:), allocatable:: miLoc

dim = 2
ALLOCATE(A(dim,dim))
ALLOCATE(B(dim,dim))
ALLOCATE(C(dim,dim))
ALLOCATE(miLoc(2))

minValue = 2 !highest value is 1, initialize value that is higher than that.

!$OMP PARALLEL DO SHARED(A,B,C,minValue,miLoc,t1,t2) PRIVATE(i,j)
DO i = 1, dim,1
    DO j = 1,dim,1
        CALL random_number(rand)
        A(i,j) = rand
        CALL random_number(rand)
        B(i,j) = rand
    END DO
END DO

!$OMP END PARALLEL DO

t1 = OMP_GET_WTIME()
!$OMP PARALLEL DO SHARED(A,B,C,minValue,miLoc) PRIVATE(i,j)
DO i = 1, dim,1
    DO j = 1,dim,1
        C(i,j) = sum(A(i,:) * B(:,j)) !the elementwise multiplication allows vectorization
        IF (C(i,j) < minValue) THEN
            minValue = C(i,j)
            miLoc = (/i,j/)
        END IF
    END DO
END DO
!$OMP END PARALLEL DO
t2 = OMP_GET_WTIME()

print*,"A is",A
print*,"B is",B
print*,"with manual matrix multiplication C is",C
print*,"minvalue of array C is", minValue,"and location of that value is",miLoc
print*,"it took",t2-t1,"for the manual calculation"

t1 = OMP_GET_WTIME()
!$OMP PARALLEL SHARED(A,B,C,miLoc,minValue)
!$OMP WORKSHARE

    C = matmul(A,B)
    
    minValue = minval(C)
    miLoc = minloc(C)

    
!$OMP END WORKSHARE
!$OMP END PARALLEL
t1 = OMP_GET_WTIME()
print*,"C is",C
print*,"minvalue of array C is", minValue,"and location of that value is",miLoc
print*,"it took",t2-t1,"for the built in calculation"
END PROGRAM matrixOMP
