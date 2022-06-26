# Dask 

This set of script makes deploying a scalable dask cluster easy. It is made to be run from the master node, through the deploy.sh script. 

# Setup

In the script.sh file, you need to change the first 3 lines to match your use-case

```bash
USER_DIR="/home/user"
CONDA_DIR="$USER_DIR/miniconda3"
MASTER_IP="192.168.0.2"
```
In this example, the user and conda dirs are the default for Okeanos. Master IP refers to the local-ip of the master node. 

If you get some sort of error regarding the network interface, you can change the eth interface to the correct one in script.sh.

```bash
MY_IP=$(/sbin/ifconfig eth2 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
                       ^^^^
```

# How to run

In the master node, you should run this (LH for localhost - do not change this like the other one):

```terminal
user@master IP=LH bash deploy.sh
```

This will create the environment and run a scheduler in the master node.

For each worker node, you should run this (change WORKER_LOCAL_IP with the local ip of the worker - 192.168.0.3 for example):

```terminal
user@master IP=WORKER_LOCAL_IP bash deploy.sh
```

If you don't want the prompt to last, you can add the nohung to the end (&)

# New cluster

If you need to reset the cluster, you can just rerun the scripts the same way. If conda is present, they will just spin up the workers and schedulers.
