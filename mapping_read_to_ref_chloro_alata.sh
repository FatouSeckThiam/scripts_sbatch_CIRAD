#!/bin/env bash

#

#SBATCH -J bowtie               ### Job name

#SBATCH -o bowtie."%j".out          ### Standard output

#SBATCH -e bowtie."%j".err          ### Standard error

#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --array=0-353%20           
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge

###module load bwa-mem2/2.0
module load bowtie2/2.4.2
module load samtools/1.2

###R1=(/home/thiamf/work_agap/DEFI/R1_R2_nuclear_data_trim/*1P.trimmed.fastq.gz)
###R2=(/home/thiamf/work_agap/DEFI/R1_R2_nuclear_data_trim/*2P.trimmed.fastq.gz)
###bowtie2 -x Dalata -1 ${R1[${SLURM_ARRAY_TASK_ID}]} -2 ${R2[${SLURM_ARRAY_TASK_ID}]} -S out.sam 
 
###bowtie2  -x Dalata -U Baits_Capture_RADlocus_Alata-Numularia-1.fasta -S align.sam

###bowtie2 -f -x Dalata -U Baits_Capture_RADlocus_Alata-Numularia-1.fasta -S mapping_Dalata_baits.sam
### l'option -f correspond au infput format fasta et l'option -q correspond aux input format fatq (comme les reads par rexemple)

FILES = ( /home/thiamf/work_agap/DEFI/R1_R2_nuclear_data_trim/*1P.trimmed.fastq.gz)
read=${FILES[$SLURM_ARRAY_TASK_ID]}
base=$(basename $read _1P.trimmed.fastq.gz)
bowtie2 -x Dalata_chloro -1 ${base}_1P.trimmed.fastq.gz -2 ${base}_2P.trimmed.fastq.gz | samtools view -bS - > ${base}.bam



