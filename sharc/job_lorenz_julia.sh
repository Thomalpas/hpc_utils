#!/bin/bash                                                                                                               

# Job name 
#$ -N lorenz 

# Error message
#$ -e lorenz.error
#$ -o lorenz.out

# Amount of RAM requested per node 
#$ -l rmem=16G

# Replace by the path to the folder where your script lives if necessary  
DIR_SCRIPT=/home/${USER}/hpc_utils

# Load modules 
module load apps/julia

julia ${DIR_SCRIPT}/julia_lorenz.jl
