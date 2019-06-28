#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N pi
#PBS -j oe
#PBS -l nodes=2:ppn=2
#PBS -l walltime=00:01:00

cd /soe/somchris/assignments/homework4/cCode/pi
mpirun -np 4 pi

