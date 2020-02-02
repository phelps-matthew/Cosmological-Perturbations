#!/bin/bash
#SBATCH --partition=parallel
#SBATCH --ntasks=25
#SBATCH --time=3
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=matthew.phelps@uconn.edu

module load mathematica/11.0.0
math -noprompt -run "<<xpc_run.m"