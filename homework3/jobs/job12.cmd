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