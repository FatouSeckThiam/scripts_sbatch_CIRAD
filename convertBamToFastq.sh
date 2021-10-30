#!/bin/env bash

#

#SBATCH -J map               ### Job name

#SBATCH -o map."%j".out          ### Standard output

#SBATCH -e map."%j".err          ### Standard error

#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
####SBATCH --array=0-113%10            ### Array index from 0 to 19 with 4 running jobs
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge
module load bedtools/2.30.0

for i in *unmapped_reads_sorted.bam; do
	base=$(basename $i _unmapped_reads_sorted.bam); echo ${base}_unmapped_reads_sorted.bam
	bamToFastq -i ${base}_unmapped_reads_sorted.bam -fq ${base}_unmapped_reads_R1.fq -fq2 ${base}_unmapped_reads_R2.fq
done 
