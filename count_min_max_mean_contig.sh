#!/bin/bash

#
#SBATCH -J Trimmomatic                    ### Job name
#SBATCH -o Trimmomatic."%j".out          ### Standard output
#SBATCH -e Trimmomatic."%j".err          ### Standard error
#
#SBATCH --partition=agap_normal   ### Partition
#SBATCH --nodes=1                 
#SBATCH --ntasks=1 
#SBATCH --array=0-223%50            ### Array index from 0 to 19 with 4 running jobs
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G


module purge
module load seqkit/2.0.0


INPUT=(*.trinity)
file=${INPUT[$SLURM_ARRAY_TASK_ID]}
base=$(basename $file .trinity)


cat ${base}.trinity/${base}.fasta | seqkit seq | seqkit stats > ${base}_min_max_mean.csv














