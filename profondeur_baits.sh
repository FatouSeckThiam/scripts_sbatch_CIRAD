#!/bin/env bash

#

#SBATCH -J depth               ### Job name

#SBATCH -o depth."%j".out          ### Standard output

#SBATCH -e depth."%j".err          ### Standard error

#
#SBATCH --partition=agap_short   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge
module load bbmap/38.90
module load samtools/1.2

for bait in $(less baits_names.txt) ; do
        ###base=$(echo ${infile} | sed "s/.trinity//"); echo ${base}.trinity
	samtools depth -r $bait $1 | awk '{sum+=$3} END { print "Zone "$bait" = ",sum/NR}'
###pileup.sh in=BGPI-10.sam out=stats.txt
done

