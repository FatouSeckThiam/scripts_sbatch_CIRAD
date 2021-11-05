#!/bin/env bash

#SBATCH -J Trinity               ### Job name

#SBATCH -o Trinity."%j".out          ### Standard output

#SBATCH -e Trinity."%j".err          ### Standard error

#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --array=0-111%14 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G



module purge

module load trinityrnaseq/2.11.0
module load python/3.4.10
Tourner en boucle
for i in *unmapped_reads_R1.fq; do
	base=$(basename $i _unmapped_reads_R1.fq); echo ${base}_unmapped_reads_R1.fq ${base}_unmapped_reads_R2.fq
	Trinity --seqType fq --no_bowtie --left ${base}_unmapped_reads_R1.fq --right ${base}_unmapped_reads_R2.fq  --max_memory 5G --CPU 5 --output ${base}.trinity
done
Tourner en Array
INPUT=(PATH/*unmapped_reads_R1.fq)
FILE=$(INPUT[$SLURM_ARRAY_TASK_ID-1])
base=$(basename $(FILE) _unmapped_reads_sorted.bam)
Trinity --seqType fq --no_bowtie --left ${base}_unmapped_reads_R1.fq --right ${base}_unmapped_reads_R2.fq  --max_memory 5G --CPU 5 --output ${base}.trinity
