#!/bin/bash

# Job name - An array job with a csv output
#$ -N arrayjob_script_csv

# Determine iterator of jobID (variable $SGE_TASK_ID)
# Ask for a jobID from 1 to 50 by 1 (simple iterative process)
#$ -t 1-50:1

# Run time of each job
#$-l h_rt=1:00:00

# Amount of RAM requested per node
#$-l rmem=1G

# Output and Error
#$ -o arrayR_script.out
#$ -e arrayR_script.error

# Replace by the path to the folder where your script lives  
DIR_SCRIPT=/home/${USER}/hpc_utils

# Load modules - latest version of R kept here
module load apps/R

CRR_JOB=$SGE_TASK_ID

Rscript ${DIR_SCRIPT}/test_array_script_csv.R ${CRR_JOB}