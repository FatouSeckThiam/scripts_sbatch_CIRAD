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

#SBATCH --array=0-469%5            ### Array index from 0 to 19 with 4 running jobs

module purge



module load fastqc/0.11.7
INPUT=(/home/thiamf/scratch/Fatou/Data_Fatou/00_Raw_Reads/*R*.fastq.gz)
fastqc ${INPUT[$SLURM_ARRAY_TASK_ID]} -o /home/thiamf/scratch/Fatou/Data_Fatou/01_QualityControl_FastQC_MultiQC
# Pour faire tourner multiqc, se mettre dans le répertoire de sortie fastqc(01_QualityControl_FastQC_MultiQC), et faire multiqc .


