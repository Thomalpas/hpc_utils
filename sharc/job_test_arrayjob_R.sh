#!/bin/bash

# Number of nodes resquested
#SBATCH --cpus-per-task=1

# Determine iterator of jobID (variable $SGE_TASK_ID)
# Ask for a jobID from 1 to 1000 by 500
#$ -t 1-1000:500

# Job name
#$ -N arrayjob_R

# Amount of RAM requested per node
#$ -l rmem=1G

# Load modules
module load apps/R/4.0.0/gcc-10.1


START=$SGE_TASK_ID
LAST=$(($SGE_TASK_ID + $SGE_TASK_STEPSIZE - 1))

echo "Starting task from ${START} to ${LAST}"
Rscript -e 'args = commandArgs(trailingOnly=TRUE); print(paste0("From ", args[1], " to ", args[2]))' ${START} ${LAST}

