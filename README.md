# hpc_utils

guidelines for sheffield hpc setup. It will contain guidelines but also script
examples to run julia code (may be R code too), to submit jobs and to
parallelize julia code (and R code too may be if useful).

Do not hesitate to raise issues and to give feedbacks. 

## Few disclaimers

Here I take ShARC cluster as example, but you can change for bessemer and
stanage.

Those guidelines are oriented for UNIX users (e.g. Linux/MACOS), but
contributions are welcome for WINDOWS users.  

# How to use this tutorial 

Connect to your favorite cluster (e.g. sharc or bessemer) and clone this git
repository into it :) (if you clone it elsewhere than in your home folder, you
may have to adapt a little some scripts!)

# ShARC and Bessemer

Because nothing is so simple with HPCs, ShARC uses SGE (Sun Grid Engine) for job
managements while bessemer uses SLURM. It means that the options for job
submission will be different while being quite similar. It is for this reason
that the minimal scripts for job submissions are placed in `sharc` and
`bessemer` respectively.

## Sharc

Let's get through the examples!

### First julia exemple

We just load julia and ask julia for a little hello. To run this job, just type
`qsub job_test_julia.sh` (while being in the `sharc` folder).

After 30s (time for the job to be allocated to a node and executed), you should  
see two files: `try_julia.error` and  `try_julia.out`. The former should be
empty if everything went fine. Read the latter file to see the ouput of the job,
e.g. type `cat try_julia.out`

### First parallel example with R

A little example of job with R using multiple cores. The R script is
`test_parallel.R`

Carefully examine `job_test_parallel_R.sh` and then run this command:
`qsub job_test_parallel_R.sh`

This job should take 2 minutes to run (you can monitor its state by running
`qstat`).

Now if you look at the output of `parallelR.out` (e.g. `cat parallel.out`),
you should see something like that:

```
Number of cores:[1] 16

Parallel computation time:
   user  system elapsed 
  0.017   0.017  20.034 

Serial computation time:
   user  system elapsed 
  0.047   0.003 100.138 
```

We asked for 5 cores but R detected 16 (haha, I do not understand at the
moment). BUT, you can see that the parallel computation took env. 20s while the 
serial computation took env. 100s, i.e. five times more! It corresponds to the
fact that we defined the parallel computation with five cores :) 

### Julia more serious example (TODO)

# Other stuff 

## Connect to the hpc 

In a terminal:

```
ssh username@sharc.shef.ac.uk
```

## Start an interactive session 



using [qrshx (support graphical application) on sharc](https://docs.hpc.shef.ac.uk/en/latest/referenceinfo/scheduler/SGE/Common-commands/qrshx.html?highlight=qrshx)

```
qrhx
```

or

with [srun on bessemer](https://docs.hpc.shef.ac.uk/en/latest/hpc/scheduler/index.html#submit-interactive-bessemer)

```
srun --pty bash -i
```

## Load modules 

- List available modules:

```
module avail
```

```
module load apps/R/4.2.1/gcc-8.2.0
```

```
module load apps/julia
```

## Clone a github repo on the cluster 

```
git clone https://github.com/...git 
```

If using ssh (you would need to generate ssh keys on the cluster and to add the
public key to your github account):

```
git clone git@...git 
```


## Set a shortcut to connect to hpc (optional)

If you are tired of typing ssh username@sharc.shef.ac.uk ... 

Add the following to your `~/.ssh/config`: 

```
Host sharc 
    HostName sharc.shef.ac.uk
    User MyUserName 
    Port 22

AddKeysToAgent yes
```

Restart ssh-agent: `sudo service ssh retart` 

Now you should be able to connect to sharc by just typing `ssh sharc` 


## Set up SSH connection with keys (optional) 

If you are tired of entering your password and to use MFA each time you are
connecting to the cluster...
But you probably need to know a bit about [ssh keys](https://www.ssh.com/academy/ssh-keys). 

### Generate a pair of keys 

You can follow the nice guidelines of github [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).


### Send your public key to the cluster 

```
scp ~/.ssh/id_rsa.pub MyUserName@sharc.shef.ac.uk:~/.ssh/
```

### Set the cluster to look for your keys 

Add the following in your .bashrc:

```
nano ~/.bashrc
```

```
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
    ssh-add
fi
```

logout and now you can connect without password and MFA!!!
