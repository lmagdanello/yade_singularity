#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=2
#SBATCH --ntasks=8
#SBATCH -p cpu_dev
#SBATCH -J yade
#SBATCH --exclusive
#SBATCH --output=yade-%j.out

echo $SLURM_JOB_NODELIST
nodeset -e $SLURM_JOB_NODELIST

singularity run /scratch/app/yade/yade.sif -x sqrt.py
