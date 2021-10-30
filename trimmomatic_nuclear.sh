#!/bin/bash
#
#SBATCH -J Trimmomatic                    ### Job name
#SBATCH -o Trimmomatic.%j.out          ### Standard output
#SBATCH -e Trimmomatic.%j.err          ### Standard error
#
#SBATCH --partition=agap_long   ### Partition
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --array=0-353            ### Array index from 0 to 19 with 4 running jobs
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=4G

module purge

module load trimmomatic/0.39
module load java/jre1.8.0_31


###INPUT1=(/nfs/work/agap/DEFI/transcriptome_alata/*R1_001.fastq.gz)
###INPUT2=(/nfs/work/agap/DEFI/transcriptome_alata/*R2_001.fastq.gz)
INPUTS1=(/nfs/work/agap/DEFI/nuclear_data/R1_R2_nuclear_data/*R1_001.fastq.gz)
INPUTS2=(/home/thiamf/work_agap/DEFI/nuclear_data/R1_R2_nuclear_data/*R2_001.fastq.gz)

###INPUTS=(/home/thiamf/work_agap/DEFI/nuclear_data/R1_R2_nuclear_data/*fastq.gz)
LIST=$(ls -la /home/thiamf/work_agap/DEFI/nuclear_data/R1_R2_nuclear_data/*R1_001.fastq.gz |awk 'split($9, a,"/"){print a[8]}')
trimmomatic PE -threads 5 -phred33 ${INPUT1[$SLURM_ARRAY_TASK_ID]} ${INPUT2[$SLURM_ARRAY_TASK_ID]} -baseout ${LIST[$SLURM_ARRAY_TASK_ID]} ILLUMINACLIP:truseq.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
