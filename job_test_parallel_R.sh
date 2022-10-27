#! /bin/bash

#SBATCH -J test-parallel-R 
#SBATCH -o parallelR.out
#SBATCH -e parallelR.error

# Request five cores
#SBATCH -n 5



Rscript test_parallel.R
