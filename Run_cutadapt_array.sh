#!/bin/bash
#
#SBATCH -J cutadapt                    ### Job name
#SBATCH -o cutadapt."%j".out          ### Standard output
#SBATCH -e cutadapt."%j".err          ### Standard error
#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1                 
#SBATCH --ntasks=1 
#SBATCH --array=0-98%10            ### Array index from 0 to 98 with 10 running jobs
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G

module purge

module load cutadapt/3.1

INPUT1=(/home/chairh/scratch/GreaterYam/GBS/PNG_2020/*R1.fastq.gz)
INPUT2=(/home/chairh/scratch/GreaterYam/GBS/PNG_2020/*R2.fastq.gz)
LIST1=$(ls -la /home/chairh/scratch/GreaterYam/GBS/PNG_2020/*R1.fastq.gz|awk 'split($9, a,"/") {print a[7]}'|awk -F"." '{print $1}')
LIST2=$(ls -la /home/chairh/scratch/GreaterYam/GBS/PNG_2020/*R2.fastq.gz|awk 'split($9, a,"/") {print a[7]}'|awk -F"." '{print $1}')

echo cutadapt -a AGATCGGAAGAGCG -A AGATCGGAAGAGCG -O 10 -q 20,20 -f fastq -m 30 -o ${LIST1[$SLURM_ARRAY_TASK_ID]}_cutadapt.fastq.gz -p ${LIST2[$SLURM_ARRAY_TASK_ID]}_cutadapt.fastq.gz ${INPUT1[$SLURM_ARRAY_TASK_ID]} ${INPUT2[$SLURM_ARRAY_TASK_ID]}

