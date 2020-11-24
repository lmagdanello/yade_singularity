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
