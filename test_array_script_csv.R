#### This script illustrates how to use an array job ####
#### with a script to generate a csv data output     ####
#### to be used with jobtest_array_script_csv.sh     ####

rm(list = ls())

# Gather your command arguments, which in this case is just the ${CRR_JOB}
args <- commandArgs(trailingOnly=TRUE)

# Your function - specific to your case - the output will depend on the job ID ${CRR_JOB}
my_func <- function(i)
  {
  
  # parameters created by your function
  id = i
  name = sample(LETTERS[1:5], 1)
  number = sample(1:10, 1)
  value = rnorm(1, mean = as.numeric(id))
  
  # output data, as a .csv line
  output_line = paste(id, name, number, value, sep = ",")
  return(output_line)
  }

# generate your output for the current job - the first command argument
current_job <- args[1]
my_output <- my_func(current_job)

# write your output to a text file, which will append
write(line, file = "output_data.txt", append = TRUE)