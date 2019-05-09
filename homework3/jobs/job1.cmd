#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N job1.cmd
#PBS -j oe
#PBS -l nodes=1:ppn=4
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework3/Exercises
mpirun -np 4 hello_mpi_grape