#!/bin/bash
#SBATCH --partition=general
#SBATCH --ntasks=4
#SBATCH --time=10
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=matthew.phelps@uconn.edu

module load mathematica/11.0.0
math -noprompt -run "<<hpc_bench.m"