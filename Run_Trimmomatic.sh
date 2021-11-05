#!/bin/bash

#
#SBATCH -J Trimmomatic                    ### Job name
#SBATCH -o Trimmomatic."%j".out          ### Standard output
#SBATCH -e Trimmomatic."%j".err          ### Standard error
#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1                 
#SBATCH --ntasks=1 
#SBATCH --array=0-115%5            ### Array index from 0 to 19 with 4 running jobs
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G

module purge

module load trimmomatic/0.39 
module load java/jre1.8.0_31
###Tourner en Array (2 Façons)
###  1)
###INPUT1=(/home/thiamf/scratch/Fatou/new_run/R1_R2_new_run_not_trim/*R1_001.fastq.gz)
###INPUT2=(/home/thiamf/scratch/Fatou/new_run/R1_R2_new_run_not_trim/*R2_001.fastq.gz)
####L1=$(ls -la /home/thiamf/scratch/Fatou/new_run/R1_R2_new_run_not_trim/*R1_001.fastq.gz|awk 'split($9, a,"/") {print a[8]}'|awk -F"_" '{print $1}')
###trimmomatic PE -threads 5 -phred33 ${INPUT1[$SLURM_ARRAY_TASK_ID]} ${INPUT2[$SLURM_ARRAY_TASK_ID]} -baseout ${L1[$SLURM_ARRAY_TASK_ID]} ILLUMINACLIP:NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36"

###  2) 
###INNPUT=(/home/thiamf/scratch/Fatou/new_run/R1_R2_new_run_not_trim/*R1_001.fastq.gz)
###file=$(INPUT[$SLURM_ARRAY_TASK_ID])
###base=$(basename $(file) _*R1_001.fastq.gz)
####trimmomatic PE -threads 5 -phred33 ${base}_R1_001.fastq.gz ${base}_R2_001.fastq.gz ${base}_1P.trimmed.fastq.gz ${base}_1U.trimmed.fastq.gz ${base}_2P.trimmed.fastq.gz 
	${base}_2U.trimmed.fastq.gz ILLUMINACLIP:NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
	
### Passer directement par une boucle for
for infile in /home/thiamf/scratch/Fatou/new_run/R1_R2_new_run_not_trim/*R1_001.fastq.gz; do 
	base=$(basename $infile _R1_001.fastq.gz); echo ${base}_R1_001.fastq.gz ${base}_R2_001.fastq.gz
	trimmomatic PE -threads 5 -phred33 ${base}_R1_001.fastq.gz ${base}_R2_001.fastq.gz ${base}_1P.trimmed.fastq.gz ${base}_1U.trimmed.fastq.gz ${base}_2P.trimmed.fastq.gz 
	${base}_2U.trimmed.fastq.gz ILLUMINACLIP:NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done



