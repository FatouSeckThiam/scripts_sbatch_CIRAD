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

### commande pour afficher que les colonnes 1 et 3,  changer la dispostion des colonnes et enfin ajouter les noms des individu dans la      
### première ligne de chaque fichier pour avoir la forme d'un tableau avec 2 entrées
### on pouvait ne pas faire de redirections et écrire directement dans le fichier en remplacant l'option -e de sed par -i 

for infile in *count_reads.csv; do
	base=$(basename $infile _count_reads.csv); awk '{print $1,$3}' ${base}_count_reads.csv | awk -F' ' 'BEGIN {OFS=" "} { print $2,$1 }' | sed -e '1i\ \'${base} > ${base}_with_ID_concat        
done


