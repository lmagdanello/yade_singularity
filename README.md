# yade_singularity

This project is a .def with the purpose of generating the image of a Singularity container with Ubuntu and Yade (https://yade-dem.org).

---
#### Building...

Clone this repository:
```shell
git clone https://github.com/lmagdanello/yade_singularity.git
```

Access the main directory:
```shell
cd yade_singularity
```
And build w/ singularity:
```shell
sudo singularity build --notest def/yade.sif def/yade_container.def
```

This process will generate the image of the container with the name of **yade.sif**.

---
#### Running...

You can run the image itself, without using singularity:
```shell
$ def/yade.sif
Container was created
Arguments received:
Welcome to Yade 2018.02b
Warning: no X rendering available (see https://bbs.archlinux.org/viewtopic.php?id=13189)
TCP python prompt on localhost:9000, auth cookie `ueasks'
XMLRPC info provider on http://localhost:21000
[[ ^L clears screen, ^U kills line. F8 plot. ]]

In [1]:
```

Or using singularity (run, exec and shell):
```shell

$ singularity run def/yade.sif
Container was created
Arguments received:
Welcome to Yade 2018.02b
Warning: no X rendering available (see https://bbs.archlinux.org/viewtopic.php?id=13189)
TCP python prompt on localhost:9000, auth cookie `ucysse'
XMLRPC info provider on http://localhost:21000
[[ ^L clears screen, ^U kills line. F8 plot. ]]

In [1]:


$ singularity exec def/yade.sif yade --version
Yade version: 2018.02b


$ singularity shell def/yade.sif
Singularity> yade --version
Yade version: 2018.02b
Singularity> cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.5 LTS"
Singularity>
```

You can also pass arguments to the container, like other scripts. For example, given a python script that calculates the square root of *144*, we will execute it with yade:
Note: *-x* is to suppress Yade's iterative terminal;
```python
# sqrt.py
import math
print(math.sqrt(144))
```

```shell
$ def/yade.sif -x sqrt.py
Container was created
Arguments received: -x sqrt.py
Welcome to Yade 2018.02b
Warning: no X rendering available (see https://bbs.archlinux.org/viewtopic.php?id=13189)
TCP python prompt on localhost:9000, auth cookie `ycdaku'
XMLRPC info provider on http://localhost:21000
Running script sqrt.py
12.0


$ singularity run def/yade.sif -x sqrt.py
Container was created
Arguments received: -x sqrt.py
Welcome to Yade 2018.02b
Warning: no X rendering available (see https://bbs.archlinux.org/viewtopic.php?id=13189)
TCP python prompt on localhost:9000, auth cookie `eskyua'
XMLRPC info provider on http://localhost:21000
Running script sqrt.py
12.0


$ singularity exec def/yade.sif yade -x sqrt.py
Welcome to Yade 2018.02b
Warning: no X rendering available (see https://bbs.archlinux.org/viewtopic.php?id=13189)
TCP python prompt on localhost:9000, auth cookie `scksau'
XMLRPC info provider on http://localhost:21000
Running script sqrt.py
12.0


$ singularity shell def/yade.sif
Singularity> yade -x sqrt.py
Welcome to Yade 2018.02b
Warning: no X rendering available (see https://bbs.archlinux.org/viewtopic.php?id=13189)
TCP python prompt on localhost:9000, auth cookie `esaudy'
XMLRPC info provider on http://localhost:21000
Running script sqrt.py
12.0
```

#### Testing...

Yade has some regression tests built into the software. These same tests are covered by the container, you can run them to validate Yade as follows:

```shell

$ singularity test def/yade.sif
```

#### Help and Inspect

```shell

$ singularity run-help def/yade.sif
        This is a container that uses Ubuntu to prepare the environment for installing Yade (https://yade-dem.org/), which is an extensible open-source framework for discrete numerical models, focused on Discrete Element Method.
```

```shell
$ singularity inspect def/yade.sif
Author: leonardo.araujo@atos.net
Version: v0.0.2
org.label-schema.build-date: Tuesday_24_November_2020_15:4:2_-03
org.label-schema.schema-version: 1.0
org.label-schema.usage: /.singularity.d/runscript.help
org.label-schema.usage.singularity.deffile.bootstrap: docker
org.label-schema.usage.singularity.deffile.from: ubuntu:18.04
org.label-schema.usage.singularity.runscript.help: /.singularity.d/runscript.help
org.label-schema.usage.singularity.version: 3.5.2-1.1.el7
```

#### Slurm

This container can be executed inside a sbatch, in the Slurm queue.

E.g .:

```shell

# sbatch_file_example.sh:

#!/bin/bash
#SBATCH --nodes=<Total of Nodes>
#SBATCH --ntasks-per-node=<Number of Tasks/Node>
#SBATCH --ntasks=<Total Tasks>
#SBATCH -p <Partition> 
#SBATCH -J <Job Name> 

echo $SLURM_JOB_NODELIST
nodeset -e $SLURM_JOB_NODELIST
echo
singularity run def/yade.sif -x sqrt.py
```

The output will look like:
```shell

node[1068-1071]
node1068 node1069 node1070 node1071

Container was created
Arguments received: -x sqrt.py
TCP python prompt on localhost:9000, auth cookie `yedkua'
Welcome to Yade 2018.02b
Warning: no X rendering available (see https://bbs.archlinux.org/viewtopic.php?id=13189)
XMLRPC info provider on http://localhost:21000
Running script sqrt.py
12.0
```

*This sample sbatch is available at: sbatch/job.sh*

---

Author: leonardo.araujo@atos.net
Brazil, Sao Paulo








