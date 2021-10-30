#!/bin/env bash

#

#SBATCH -J map               ### Job name

#SBATCH -o map."%j".out          ### Standard output

#SBATCH -e map."%j".err          ### Standard error

#
#SBATCH --partition=agap_normal   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge

###module load bwa-mem2/2.0
module load bowtie2/2.4.2
module load samtools/1.2


###bowtie2 -f -x Dalata -U Baits_Capture_RADlocus_Alata-Numularia-1.fasta -S align.sam

###l'option -f correspond au infput format fasta et l'option -q correspond aux input format fastq (comme les reads par rexemple)


###for infile in /home/thiamf/scratch/Fatou/MAPP/nuclear/*reads_R1.fq; do
###base=$(echo ${infile} | sed "s/_unmapped_reads_R1\.fq//"); echo ${base}_unmapped_reads_R1.fq ${base}_unmapped_reads_R2.fq
for infile in /home/thiamf/scratch/Fatou/MAPP/nuclear/*baits_RU.bam; do
	base=$(echo ${infile} | sed "s/_baits_RU\.bam//"); echo ${base}_baits_RU.bam
	###bowtie2 -p 4 -x /home/thiamf/scratch/Fatou/baits -1 ${base}_unmapped_reads_R1.fq -2 ${base}_unmapped_reads_R2.fq | samtools view -bS - > ${base}_baits_RU.bam
	samtools sort ${base}_baits_RU.bam ${base}_baits_sort_RU
done


