
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


module purge
module load ncbi-blast/2.6.0+-bin

for infile in *fasta; do
	base=$(echo ${infile} | sed "s/\.fasta//"); echo ${base}.fasta
	###makeblastdb -in ${base}.fasta -title ${base} -out ${base} -dbtype nucl ### pour creer la base de données à partir des contig (.fasta)
	blastn -query Baits_Capture_RADlocus_Alata-Numularia-1.fasta -db ${base} -outfmt "6 qseqid sseqid qlen slen sstart send qstart qend lenght evalue" > ${base}.tsv

done

