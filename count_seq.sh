#!/bin/env bash

#

#SBATCH -J count               ### Job name

#SBATCH -o count."%j".out          ### Standard output

#SBATCH -e count."%j".err          ### Standard error

#

#SBATCH --partition=agap_normal   ### Partition

#SBATCH --time=01:00:00           ### WallTime

#SBATCH --nodes=1

#SBATCH --ntasks=1




liste= ls -la R1_R2_nuclear_data_trim/*2P.trimmed.fastq.gz |awk 'split($9, a,"/"){print a[2]}'|awk -F"_" '{print $1}'
for i in ${liste}; do zcat $i | echo -ne $i "\t" $((`wc -l`/4)); done > liste_count

####for i in $(less liste_count); do echo $(($i*2)); done > count_reads_trim
###Permets de multiplier le nombre de reads par 2 (genre avoir le nombre de reads dans R1 et R2 pour chaque individu)
