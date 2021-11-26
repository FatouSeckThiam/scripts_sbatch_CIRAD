#!/bin/env bash
# ce code permets de compter le nombre de contigs par baits, d'insérer les noms des indiviuds dans la première ligne de chaque fichier afin de pour créer le tableau en gardant les noms des individus
for i in *L001.tsv; do base=$(basename $i _L001.tsv); awk '{c1[$1]++} END {for (e in c1) print e, c1[e]}' ${base}_L001.tsv | sed -e '1i\ \'${base} > ${base}_Conditg_GroupBy_Baits; done


