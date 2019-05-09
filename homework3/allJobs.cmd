JOB1
#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N job1.cmd
#PBS -j oe
#PBS -l nodes=1:ppn=4
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework3/Exercises
mpirun -np 4 hello_mpi_grape

JOB2
#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N job2.cmd
#PBS -j oe
#PBS -l nodes=2:ppn=4
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework3/Exercises
mpirun -np 8 hello_mpi_grape


JOB5
#!/bin/csh
#SBATCH -p Course
#SBATCH -J job5.cmd
#SBATCH -e job%j.err
#SBATCH -o job%j.out
#SBATCH -N 1
#SBATCH --ntasks-per-node 4
#SBATCH -t 00:05:00

mpirun -np 4 hello_mpi_hb


JOB6
#!/bin/csh
#SBATCH -p Course
#SBATCH -J job6.cmd
#SBATCH -e job%j.err
#SBATCH -o job%j.out
#SBATCH -N 2
#SBATCH --ntasks-per-node 4
#SBATCH -t 00:05:00

mpirun -np 8 hello_mpi_hb


JOB7
#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N job7.cmd
#PBS -j oe
#PBS -l nodes=1:ppn=4
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework3/Exercises
setenv OMP_NUM_THREADS 4
./hello_omp_grape


JOB8
#PBS -S /bin/tcsh
#PBS -q newest
#PBS -N job8.cmd
#PBS -j oe
#PBS -l nodes=1:ppn=8
#PBS -l walltime=00:05:00

cd /soe/somchris/assignments/homework3/Exercises
setenv OMP_NUM_THREADS 8
./hello_omp_grape


JOB11
#!/bin/csh
#SBATCH -p Course
#SBATCH -J job11.cmd
#SBATCH -e job%j.err
#SBATCH -o job%j.out
#SBATCH -N 1
#SBATCH -c 4
#SBATCH -t 00:05:00

setenv OMP_NUM_THREADS 4
./hello_omp_hb


JOB12
#!/bin/csh
#SBATCH -p Course
#SBATCH -J job12.cmd
#SBATCH -e job%j.err
#SBATCH -o job%j.out
#SBATCH -N 1
#SBATCH -c 8
#SBATCH -t 00:05:00

setenv OMP_NUM_THREADS 8
./hello_omp_hb