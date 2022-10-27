#!/bin/bash                                                                                                               

# Job name 
#$ -N Pkg.add()

# Error message
#$ -e pkg_add.error
#$ -o pkg_add.out

# Amount of RAM requested per node 
#$ -l rmem=16G

# Replace by the path to the folder where your script lives if necessary  
DIR_SCRIPT=/home/${USER}/hpc_utils

# Load modules 
module load apps/julia

julia ${DIR_SCRIPT}/julia_setup.jl
