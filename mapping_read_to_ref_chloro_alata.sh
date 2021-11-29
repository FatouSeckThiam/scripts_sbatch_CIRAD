#!/bin/env bash

#

#SBATCH -J bowtie               ### Job name

#SBATCH -o bowtie."%j".out          ### Standard output

#SBATCH -e bowtie."%j".err          ### Standard error

#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --array=0-469%20           
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge


module load bowtie2/2.4.2
module load samtools/1.2

###bowtie2 -f -x Dalata -U Baits_Capture_RADlocus_Alata-Numularia-1.fasta -S mapping_Dalata_baits.sam
### l'option -f correspond au input format fasta et l'option -q correspond aux input format fastq (comme les reads par rexemple)

FILES=(/home/thiamf/scratch/Fatou/Data_Fatou/02_Trimming/*1P.trimmed.fastq.gz)
read=${FILES[$SLURM_ARRAY_TASK_ID]}
base=$(basename $read _1P.trimmed.fastq.gz)
bowtie2 -x Dalata_chloro -1 ${base}_1P.trimmed.fastq.gz -2 ${base}_2P.trimmed.fastq.gz | samtools view -bS - > ${base}.bam



