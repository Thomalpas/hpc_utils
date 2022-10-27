#!/bin/bash                                                                                                               

# Number of nodes resquested
#SBATCH --cpus-per-task=1

# Job name 
#$ -N try_julia

# Error message
#$ -e try_julia.error
#$ -o try_julia.out

# Amount of RAM requested per node 
#$ -l rmem=1G

# Load modules 
module load apps/julia 

echo "Which version of julia is used?"
which julia | echo

julia -e 'println("Hello from Julia!\nI am Julia version $(VERSION)\nI wish u the best in your computing journey!\nI will do my best to help you!")'
