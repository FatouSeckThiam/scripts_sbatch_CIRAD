#!/bin/env bash
# ce code permets de compter le nombre de contigs par baits, d'insérer les noms des indiviuds dans la première ligne de chaque fichier pour garder le nom des accessions dans le tableau final
for i in *.tsv; do base=$(basename $i .tsv); awk '{c1[$1]++} END {for (e in c1) print e, c1[e]}' ${base}.tsv | sed -e '1i\ \'${base} > ${base}_Conditg_GroupBy_Baits; done


