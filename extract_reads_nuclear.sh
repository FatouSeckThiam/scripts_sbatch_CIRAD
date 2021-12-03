#!/bin/env bash

#

#SBATCH -J map               ### Job name

#SBATCH -o map."%j".out          ### Standard output

#SBATCH -e map."%j".err          ### Standard error

#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --array=0-222%20         ###  Penser à adapter le nombre d'array en fonction du nombre d'échantillons
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge


module load samtools/1.2

#Penser à adapter les chemins des fichiers d'entrée en cas de besoin.

for i in PATH/04_Mapping_Reads_To_Ref_Chloro/Data/*_sorted.bam; do
        base=$(basename $i _sorted.bam); echo ${base}_sorted.bam
        #1) samtools view -b -f 12 ${base}_sorted.bam > ${base}_nuclear_reads.bam    #extraction des reads nucleaires au format bam avec l'option f 12 de samtools view
        #2) samtools sort -n ${base}_nuclear_reads.bam ${base}_nuclear_reads_sorted  #Tri des fichiers bam nucleaires par nom (non pas par postion) avec l'option -n de samtools sort
done



