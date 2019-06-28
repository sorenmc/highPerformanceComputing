#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N parallelGOL
#PBS -j oe
#PBS -l nodes=2:ppn=2
#PBS -l walltime=00:02:00

cd /soe/somchris/assignments/finalProject/
mpirun -np 4 paraleleGOL

