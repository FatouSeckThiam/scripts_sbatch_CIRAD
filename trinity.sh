#!/bin/env bash

#SBATCH -J Trinity               ### Job name

#SBATCH -o Trinity."%j".out          ### Standard output

#SBATCH -e Trinity."%j".err          ### Standard error

#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --array=0-111%14 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge

module load trinityrnaseq/2.11.0
module load python/3.4.10
#Tourner en boucle
#for i in /home/thiamf/scratch/Fatou/Data_Fatou/06_BamToFastq_Reads/*nuclear_reads_R1.fq; do
#	base=$(basename $i _nuclear_reads_R1.fq); echo ${base}_nuclear_reads_R1.fq ${base}_nuclear_reads_R2.fq
#	Trinity --seqType fq --left ${base}_nuclear_reads_R1.fq --right ${base}_nuclear_reads_R2.fq  --max_memory 5G --CPU 5 --output ${base}.trinity
#done

#Tourner en Array
INPUT=(/home/thiamf/scratch/Fatou/Data_Fatou/06_BamToFastq_Reads/*nuclear_reads_R1.fq)
FILE=$(INPUT[$SLURM_ARRAY_TASK_ID-1])
base=$(basename $(FILE) _nuclear_reads_sorted.bam)
Trinity --seqType fq --left ${base}_nuclear_reads_R1.fq --right ${base}_nuclear_reads_R2.fq  --max_memory 5G --CPU 5 --output ${base}.trinity


