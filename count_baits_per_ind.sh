#!/bin/env bash

#

#SBATCH -J depth               ### Job name

#SBATCH -o depth."%j".out          ### Standard output

#SBATCH -e depth."%j".err          ### Standard error

#
#SBATCH --partition=agap_normal   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge
module load bbmap/38.90
module load samtools/1.2

for infile in *sort.bam; do
        base=$(echo ${infile} | sed "s/_sort\.bam//"); echo ${base}_sort.bam
        echo "${base}_baits= " && samtools view -c -F 12 ${base}_sort.bam
###pileup.sh in=BGPI-10.sam out=stats.txt
done; -> count_baits_per_ind


