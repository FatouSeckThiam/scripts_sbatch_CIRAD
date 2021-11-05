#!/bin/env bash

#

#SBATCH -J map               ### Job name

#SBATCH -o map."%j".out          ### Standard output

#SBATCH -e map."%j".err          ### Standard error

#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --array=0-113%10            ### Array index from 0 to 19 with 4 running jobs
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G

module purge

module load bowtie2/2.4.2
module load samtools/1.2

###R1=(/home/thiamf/work_agap/DEFI/R1_R2_nuclear_data_trim/*1P.trimmed.fastq.gz)
###R2=(/home/thiamf/work_agap/DEFI/R1_R2_nuclear_data_trim/*2P.trimmed.fastq.gz)
###bowtie2 -x Dalata -1 ${R1[${SLURM_ARRAY_TASK_ID}]} -2 ${R2[${SLURM_ARRAY_TASK_ID}]} -S out.sam


###bowtie2 -f -x Dalata -U Baits_Capture_RADlocus_Alata-Numularia-1.fasta -S mapping_Dalata_baits.sam
###l'option -f correspond au infput format fasta et l'option -q correspond aux input format fastq 
###sample=$(ls -la /nfs/work/agap/DEFI/R1_R2_nuclear_data_trim/*1P.trimmed.fastq.gz|awk 'split($9, a,"/") {print a[7]}'|awk -F"_" '{print $1}')


###for i in *_1P.trimmed.fastq.gz; do
###	base=$(basename $i _1P.trimmed.fastq.gz); echo ${base}_1P.trimmed.fastq.gz ${base}_2P.trimmed.fastq.gz
###	bowtie2 -p 4 -x /home/thiamf/scratch/Fatou/Dalata -1 ${base}_1P.trimmed.fastq.gz -2 ${base}_2P.trimmed.fastq.gz | samtools view -bS - > ${base}.bam
###done

for i in *_unmapped_reads.bam; do
	base=$(basename $i _unmapped_reads.bam); echo ${base}_unmapped_reads.bam
	### 1) samtools sort ${base}.bam ${base}_sorted
	### 2) samtools index -b ${base}_sorted.bam 
	### 3) samtools view -b -f 12 ${base}_sorted.bam > ${base}_unmapped_reads.bam
	samtools sort -n ${base}_unmapped_reads.bam ${base}_unmapped_reads_sorted (dernière partie à exécuter)
done

