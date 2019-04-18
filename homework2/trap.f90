PROGRAM trap
    INTEGER :: N
    REAL :: b,a,startN,endN, integral,func
    WRITE(*,*) "Make integral!"
    WRITE(*,*) "Press 1 for x^2 and 2 for sin(x)"
    read *,func
    WRITE(*,*) "What should the upper bound be?"
    READ *, b
    WRITE(*,*) "What should the lower bound be?"
    READ *, a
    WRITE(*,*) "Number of intervals?"
    READ *, N
    PRINT *,"b is:",b,", a is:",a,"and N is:",N 
    
    !initialize variables and constants
    stepSize = (b-a)/N
    startN = a
    endN = a+stepSize
    integral = 0
    
    !do trapezoid
    DO i = 1, N, 1
        integral = integral + (f(startN,func)+f(endN,func))/2 * stepSize
        startN = endN
        endN = startN + stepSize
    END DO
     
    PRINT *,"integral is", integral 
    
END PROGRAM
    
    
REAL FUNCTION f(x,func) RESULT(y)
        IF (func == 1) THEN
            y = x**2
        ELSE
            y = sin(x)
        END IF
END FUNCTION f