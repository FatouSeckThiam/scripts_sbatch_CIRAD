#!/bin/env bash

#

#SBATCH -J rename               ### Job name

#SBATCH -o rename."%j".out          ### Standard output

#SBATCH -e rename."%j".err          ### Standard error

#
#SBATCH --partition=agap_short   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge
module load bbmap/38.90

 
for infile in *trinity; do 
        base=$(echo ${infile} | sed "s/.trinity//"); echo ${base}.trinity
	rename.sh in=${base}.trinity/Trinity.fasta out=${base}.trinity/${base}.fasta prefix=${base}
done
 ## En bash sans passer par bbmap
 for i in *.fasta; do base=$(basename $i .fasta); sed -e 's/^>.*$/>'$base'/' $i; done 
