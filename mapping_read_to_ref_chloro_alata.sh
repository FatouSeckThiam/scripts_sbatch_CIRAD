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


# Dalata_chloro correspond à l'index de la séquence de référence Dalata chloroplaste
# bowtie2-build Dalata_chloro_sequence_ref.fasta Dalata_chloro

#1) Mapper les reads sur la référence chloroplase de Dalata
FILES=(/home/thiamf/scratch/Fatou/Data_Fatou/02_Cleaning_reads/Data/*1P.trimmed.fastq.gz)
read=${FILES[$SLURM_ARRAY_TASK_ID]}
base=$(basename $read _1P.trimmed.fastq.gz)
bowtie2 -x Dalata_chloro -1 ${base}_1P.trimmed.fastq.gz -2 ${base}_2P.trimmed.fastq.gz | samtools view -bS - > ${base}.bam


#2) Les	fichiers bam doivent etre triés	et indexés pour extraire les reads nucleaires (non mappés sur la référence de Dalata chloro)
#for i in *.bam; do
#       base=$(basename $i .bam); echo ${base}.bam
#       samtools sort ${base}.bam ${base}_sorted
#       samtools index -b ${base}_sorted.bam
#done






