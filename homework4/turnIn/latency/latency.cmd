#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N latency
#PBS -j oe
#PBS -l nodes=1:ppn=2
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework4/cCode/latency
mpirun -np 2 latency

