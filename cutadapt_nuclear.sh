#!/bin/bash

#

#SBATCH -J cutadapt                   ### Job name

#SBATCH -o cutadapt."%j".out          ### Standard output

#SBATCH -e cutadapt."%j".err          ### Standard error

#

#SBATCH --partition=agap_normal   ### Partition

#SBATCH --time=10:00:00           ### WallTime

#SBATCH --nodes=1

#SBATCH --ntasks=1

#SBATCH --array=0-353            ### Array index from 0 to 19 with 4 running jobs

module purge



module load cutadapt/3.1



for i in /nfs/work/agap/DEFI/nuclear_data/R1_R2_nuclear_data/*R1_001.fastq.gz
do
  SAMPLE=$(echo ${i} | sed "s/_R1_001\.fastq\.gz//")
  echo ${SAMPLE}_R1_001.fastq.gz ${SAMPLE}_R2_001.fastq.gz

cutadapt -a CTGTCTCTTATACACATCT -A CTGTCTCTTATACACATCT -g CTGTCTCTTATACACATCT -G CTGTCTCTTATACACATCT -a CTGTCTCTTATACACATCT -A CTGTCTCTTATACACATCT -g CTGTCTCTTATACACATCT -G CTGTCTCTTATACACATCT -o ${SAMPLE}_R1_001.trimmed.fastq.gz -p  ${SAMPLE}_R2_001.trimmed.fastq.gz  ${SAMPLE}_R1_001.fastq.gz  ${SAMPLE}_R2_001.fastq.gz 
done


###  cutadapt -a CTGTCTCTTATACACATCT -A CTGTCTCTTATACACATCT -B AGATGTGTATAAGAGACAG -o Vun51_S28_L001_R1_001.T.fastq.gz -p Vun51_S28_L001_R2_001.T.fastq.gz  Vun51_S28_L001_R1_001.fastq.gz  Vun51_S28_L001_R2_001.fastq.gz
