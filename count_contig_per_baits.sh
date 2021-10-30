#!/bin/env bash

for i in *L001.tsv; do base=$(basename $i _L001.tsv); awk '{c1[$1]++} END {for (e in c1) print e, c1[e]}' ${base}_L001.tsv | sed -e '1i\ \'${base} > ${base}_Conditg_GroupBy_Baits; done


