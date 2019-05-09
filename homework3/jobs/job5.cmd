#!/bin/csh
#SBATCH -p Course
#SBATCH -J job5.cmd
#SBATCH -e job%j.err
#SBATCH -o job%j.out
#SBATCH -N 1
#SBATCH --ntasks-per-node 4
#SBATCH -t 00:05:00

mpirun -np 4 hello_mpi_hb