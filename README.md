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

We asked for 5 cores but R detected 16. You can see that the parallel computation took env. 20s while the
serial computation took env. 100s, i.e. five times more! It corresponds to the
fact that we defined the parallel computation with five cores :)

### Julia Pkg installation

The clusters have internet connection, so you can install julia package normally.
You can test it by running `qsub job_pkg_install_julia.sh`!

If you look at `pkg_add.error`, you will see something like that:

```julia
Installing known registries into `~/.julia`
  Updating registry at `~/.julia/registries/General.toml`
 Resolving package versions...
 Installed JpegTurbo_jll ──────────────────── v2.1.2+0
 Installed x265_jll ───────────────────────── v3.5.0+0
 Installed Calculus ───────────────────────── v0.5.1
 Installed TreeViews ──────────────────────── v0.3.0
 Installed libfdk_aac_jll ─────────────────── v2.0.2+0
 Installed DifferentialEquations ──────────── v7.6.0
```

So julia created in your home directory a folder architecture in `~/.julia` to
keep track of the installed package and their version.

### DifferentialEquation example

Run lorenz equation example: see `julia_lorenz.jl`

In `sharc` folder, type `qsub job_lorenz_julia.sh`

### Parallel computation in julia

[Interesting examples](https://www.stochasticlifestyle.com/multi-node-parallelism-in-julia-on-an-hpc/).

Let's first test interactively:

```
# Request 1 node with 5G
qrsh -pe smp 1 -l  h_vmem=5G
julia
```

In julia:

```julia
using Distributed
println("n workers: ",nworkers(), ", n process:", nprocs())
```

You should see that there is only one core and one process. Now quit Julia.

See how many cpu you have at your node by typing `nproc`

Restart Julia:

```julia
julia -p 5
```

In julia:

```julia
using Distributed
println("n workers: ",nworkers(), ", n process:", nprocs())
```

Now you should see that you have access to 5 workers. You can even see their
names:

```
pmap(x->run(`hostname`),workers());
```
The node names are the same because we requested only one name.

[Interesting example for simulation](https://cecileane.github.io/computingtools/pages/notes1209.html)

### Array jobs

When you have very intensive computational task, you may want to split the work
load in several jobs. SGE allows to do that by [generating iterators](https://docs.hpc.shef.ac.uk/en/latest/parallel/JobArray.html#).

You can even generate iterators from one number to another with a specified
[stepsize](https://docs.hpc.shef.ac.uk/en/latest/parallel/JobArray.html#grouping-tasks-for-efficiency).

In a design, imagine that you have a table with each row containing parameter
combination to run over. You want want that each job perform a number of
paramer combination, like one hundred, one thousand, etc...

I provide a dummy example for `julia` and `R` in the  
`sharc`:
- `job_test_arrayjob_julia.sh`
- `job_test_arrayjob_R.sh`

Those example will show you how to set an iterator and how to pass it to `julia` and `R`.

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

Now load Julia and R:

```
module load apps/R/4.0.0/gcc-10.1
module load apps/julia
```

Please note that you have to load the above specific version of R if you intend
also to use Julia. Other R versions will make Julia fails (From Desmond Ryan:
"The julia install is pre-built binaries so suspect there is an incapability
between gcc versions (for the R version you used & the compilation of julia)") .

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
