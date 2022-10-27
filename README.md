# hpc_utils

guidelines for sheffield hpc setup. It will contain guidelines but also script
examples to run julia code (may be R code too), to submit jobs and to
parallelize julia code (and R code too may be if useful).

Do not hesitate to raise issues and to give feedbacks. 

# Few disclaimers

Here I take ShARC cluster as example, but you can change for bessemer and
stanage.

Those guidelines are oriented for UNIX users (e.g. Linux/MACOS), but
contributions are welcome for WINDOWS users.  

# Connect to the hpc 

In a terminal:

```
ssh username@sharc.shef.ac.uk
```

# Start an interactive session 

using [qrshx (support graphical application)](https://docs.hpc.shef.ac.uk/en/latest/referenceinfo/scheduler/SGE/Common-commands/qrshx.html?highlight=qrshx)

```
qrhx
```

or

with [srun](https://docs.hpc.shef.ac.uk/en/latest/hpc/scheduler/index.html#submit-interactive-bessemer)

```
srun --pty bash -i
```

# Load modules 

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

# Clone a github repo on the cluster 

```
git clone https://github.com/...git 
```

If using ssh (you would need to generate ssh keys on the cluster and to add the
public key to your github account):

```
git clone git@...git 
```


# Set a shortcut to connect to hpc (optional)

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


# Set up SSH connection with keys (optional) 

If you are tired of entering your password and to use MFA each time you are
connecting to the cluster...
But you probably need to know a bit about [ssh keys](https://www.ssh.com/academy/ssh-keys). 

## Generate a pair of keys 

You can follow the nice guidelines of github [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).


## Send your public key to the cluster 

```
scp ~/.ssh/id_rsa.pub MyUserName@sharc.shef.ac.uk:~/.ssh/
```

## Set the cluster to look for your keys 

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
