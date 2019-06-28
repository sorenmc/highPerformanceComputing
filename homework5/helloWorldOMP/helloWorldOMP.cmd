#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N helloWorldOMP
#PBS -j oe
#PBS -l nodes=1:ppn=8
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework5/helloWorldOMP
setenv OMP_NUM_THREADS 8
./helloWorldOMP
