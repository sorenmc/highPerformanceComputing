#!/bin/csh
#SBATCH -p Course
#SBATCH -J job6.cmd
#SBATCH -e job%j.err
#SBATCH -o job%j.out
#SBATCH -N 2
#SBATCH --ntasks-per-node 4
#SBATCH -t 00:05:00

mpirun -np 8 hello_mpi_hb