#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N ring
#PBS -j oe
#PBS -l nodes=4:ppn=2
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework4/cCode/ring
mpirun -np 8 ring

