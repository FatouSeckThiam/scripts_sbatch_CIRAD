#!/bin/env bash

#

#SBATCH -J blast               ### Job name

#SBATCH -o blast."%j".out          ### Standard output

#SBATCH -e balst."%j".err          ### Standard error

#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G


for f in *.tsv; do indiv=$(basename $f .tsv); awk -v indiv=$indiv 'BEGIN{samcmd="samtools view -c /home/thiamf/scratch/Fatou/MAPP/nuclear/Trinity_assemblies/Contigs_ind/"indiv"_reads.bam"} {if($5<$6){m=$5;M=$6}else{m=$6; M=$5};if($1!=PREVBAITS){if(NR>1){print samcmd" "regions">"indiv" "PREVBAITS} regions=""; PREVBAITS=$1;} regions=regions $2":"m"-"M;  }END{print samcmd" "regions">"indiv" "PREVBAITS}' $f | awk -F">" '{print("nb=$("$1"); echo \"$nb "$2"\"")}' >_getReads_count_$indiv.sh; done 
