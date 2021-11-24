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


###samtools index -b ${base}.bam $base
##samtools sort ${base}.bam ${base}_sorted
###done



for i in *_unmapped_reads.bam; do
	base=$(basename $i _unmapped_reads.bam); echo ${base}_unmapped_reads.bam
	###samtools sort ${base}.bam ${base}_sorted
	###samtools index -b ${base}_sorted.bam 
	###samtools view -b -f 12 ${base}_sorted.bam > ${base}_unmapped_reads.bam
	samtools sort -n ${base}_unmapped_reads.bam ${base}_unmapped_reads_sorted
done

