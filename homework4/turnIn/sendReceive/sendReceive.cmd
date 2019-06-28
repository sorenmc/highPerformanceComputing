#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N sendReceive
#PBS -j oe
#PBS -l nodes=2:ppn=2
#PBS -l walltime=00:02:00

cd /soe/somchris/assignments/homework4/cCode/sendReceive
mpirun -np 4 sendReceive

