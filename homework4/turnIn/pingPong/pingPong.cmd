#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N pingPong
#PBS -j oe
#PBS -l nodes=2:ppn=2
#PBS -l walltime=00:02:00

cd /soe/somchris/assignments/homework4/cCode/pingPong
mpirun -np 4 pingPong

