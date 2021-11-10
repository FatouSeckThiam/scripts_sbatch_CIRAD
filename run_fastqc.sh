#!/bin/bash

#

#SBATCH -J fastqc                   ### Job name

#SBATCH -o fastqc."%j".out          ### Standard output

#SBATCH -e fastqc."%j".err          ### Standard error

#

#SBATCH --partition=agap_normal   ### Partition

#SBATCH --time=01:00:00           ### WallTime

#SBATCH --nodes=1                 

#SBATCH --ntasks=1 

#SBATCH --array=0-115%5            ### Array index from 0 to 19 with 4 running jobs

module purge



module load fastqc/0.11.7

INPUT=(/home/thiamf/scratch/Fatou/new_run/R1_R2_new_run_trim/*.trimmed.fastq.gz)

fastqc ${INPUT[$SLURM_ARRAY_TASK_ID]} -o /home/thiamf/scratch/Fatou/new_run/R1_R2_new_run_trim/fastqc_trim



