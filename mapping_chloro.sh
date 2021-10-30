#!/bin/env bash

#

#SBATCH -J bowtie2               ### Job name

#SBATCH -o bowtie2."%j".out          ### Standard output

#SBATCH -e bowtie2."%j".err          ### Standard error

#

#SBATCH --partition=agap_normal   ### Partition

#SBATCH --time=01:00:00           ### WallTime

#SBATCH --nodes=1

#SBATCH --ntasks=1

#SBATCH --array=0-353          ### Array index from 0 to 19 with 4 running jobs

module purge
module load bowtie2/2.4.2
module load samtools/1.10
for infile in /home/thiamf/work_agap/DEFI/R1_R2_nuclear_data_trim/*1P.trimmed.fastq.gz; do base=$(echo ${infile} | sed "s/_1P.trimmed\.fastq\.gz//"); echo ${base}_1P.trimmed.fastq.gz ${base}_2P.trimmed.fastq
bowtie2 -x Dalata_chloro -1 ${base}_1P.trimmed.fastq.gz -2 ${base}_2P.trimmed.fastq.gz -S samples_Dalata_chloro.sam
done

