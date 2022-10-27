#!/bin/bash                                                                                                               

# Number of nodes resquested
#SBATCH --cpus-per-task=1

# Job name 
#SBATCH --comment=try_julia
#SBATCH --output=try_julia.out
#SBATCH --error=try_julia.error

# Amount of RAM requested per node 
#SBATCH --mem=8G

# Load modules 
module load apps/julia 

echo "Which version of julia is used?"
which julia | echo

julia -e 'println("Hello from Julia!\nI am Julia version $(VERSION)\nI wish u the best in your computing journey!\nI will do my best to help you!")'
