To compile and run the programs:

on grape:
gfortran  -fopenmp <programname>.f90  -o <programname>
qsub <programname>.cmd

on hb:
gfortran  -fopenmp <programname>.f90  -o <programname>
./<programname>
