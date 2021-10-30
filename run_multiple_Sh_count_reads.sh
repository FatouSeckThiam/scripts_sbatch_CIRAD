#!/bin/env bash

#

#SBATCH -J count               ### Job name

#SBATCH -o count."%j".out          ### Standard output

#SBATCH -e count."%j".err          ### Standard error

#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --array=0-47%20 
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G


module purge
module load samtools/1.10


INPUT1=(/home/thiamf/scratch/Fatou/new_run/R1_R2_new_run_trim/Contig_ID_new_run/Count_reads_per_Ind_Baits/*sh)

sh_file=${INPUT1[$SLURM_ARRAY_TASK_ID]}
base=$(basename $sh_file _L001.sh)
. ${sh_file} > ${base}_count_reads.csv







