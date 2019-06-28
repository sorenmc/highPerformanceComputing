#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N helloWorld
#PBS -j oe
#PBS -l nodes=2:ppn=4
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework4/cCode/helloWorld
mpirun -np 8 helloWorld

