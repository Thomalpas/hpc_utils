#!/bin/bash

# Number of nodes resquested
#SBATCH --cpus-per-task=1

# Determine iterator of jobID (variable $SGE_TASK_ID)
# Ask for a jobID from 1 to 1000 by 500
#$ -t 1-1000:500

# Job name
#$ -N arrayjob_julia

# Amount of RAM requested per node
#$ -l rmem=1G

# Load modules
module load apps/julia/1.8.5/binary

START=$SGE_TASK_ID
LAST=$(($SGE_TASK_ID + $SGE_TASK_STEPSIZE - 1))

echo "Starting task from ${START} to ${LAST}"
julia -e 'println("From $(ARGS[1]) to $(ARGS[2])")' ${START} ${LAST}
