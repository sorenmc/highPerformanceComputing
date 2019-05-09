#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N job7.cmd
#PBS -j oe
#PBS -l nodes=1:ppn=4
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework3/Exercises
setenv OMP_NUM_THREADS 4
./hello_omp_grape