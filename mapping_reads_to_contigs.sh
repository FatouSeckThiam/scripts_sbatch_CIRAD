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
module load samtools/1.2
###module load bwa/0.7.17
bamfile=(*_reads_mapping_sorted.bam)
input=${bamfile[$SLUR_ARRAY_TASK_ID]}
base=$(basename $input _reads_mapping_sorted.bam)
###bwa index ${base}.fasta ${base}
###bwa mem -t 4 ${base}.fasta ../${base}_unmapped_reads_R1.fq  ../${base}_unmapped_reads_R2.fq | samtools view -bS - > ${base}_reads_mapping.bam
###samtools sort ${base}_reads_mapping.bam ${base}_reads_mapping_sorted
samtools index ${base}_reads_mapping_sorted.bam 	



