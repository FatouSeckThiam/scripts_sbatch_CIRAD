#!/bin/env bash

#

#SBATCH -J map               ### Job name

#SBATCH -o map."%j".out          ### Standard output

#SBATCH -e map."%j".err          ### Standard error

#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --array=0-113%10            ### Penser à adapter le nombre d'array en fonction du nombre d'échantillons
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge


module load bowtie2/2.4.2
module load samtools/1.2

for i in *_nuclear_reads.bam; do
        base=$(basename $i _nuclear_reads.bam); echo ${base}_nuclear_reads.bam
        #1) samtools view -b -f 12 ${base}_sorted.bam > ${base}_nuclear_reads.bam    #extraction des reads nucleaires au format bam avec l'option f 12 de samtools view
        #2) samtools sort -n ${base}_nuclear_reads.bam ${base}_nuclear_reads_sorted  #Tri des fichier bam nucleaires par nom (pas par postion) avec l'option -n de samtools sort
done

