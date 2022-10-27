#! /bin/bash

# Job name 
#$ -N test-parallel-R

# Error message
#$ -e parallelR.error
#Output message
#$ -o parallelR.out

# Amount of RAM requested per node 
#$ -l rmem=1G

# Request five cores
#$ -pe openmp 5

# Replace by the path to the folder where your script lives if nessary  
DIR_SCRIPT=/home/${USER}/hpc_utils

# Load R modules
module load apps/R/4.2.1/gcc-8.2.0

Rscript ${DIR_SCRIPT}/test_parallel.R
