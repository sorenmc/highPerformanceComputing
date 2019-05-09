#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N job2.cmd
#PBS -j oe
#PBS -l nodes=2:ppn=4
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework3/Exercises
mpirun -np 8 hello_mpi_grape