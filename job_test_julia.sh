#!/bin/bash                                                                                                               

# Number of nodes resquested
#SBATCH --nodes=1

# Job name 
#SBATCH --job-name=try_julia 

# Amount of RAM requested per node 
#SBATCH --mem=8G

# Load modules 
module load apps/julia 

echo "Which version of julia is used?"
which julia | echo

julia -e 'println("Hello from Julia!\n I am Julia version $(VERSION)\nI wish u the best in your computing journey!\nI will do my best to help you!")'
