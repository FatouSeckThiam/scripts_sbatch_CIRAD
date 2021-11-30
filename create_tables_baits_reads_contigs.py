#!/usr/bin/env python
import pandas as pd
import numpy as np
from glob import glob

### 1) Création matrice pour compter le nombre de contig par baits à partir du blast

tab_blast_baits=sorted(glob('/home/thiam/count_contig/*Contigs_groupBy_Baits'))
concat_baits=pd.concat((pd.read_csv(file, sep = " ", index_col = 0)
                       for file in tab_blast_baits), axis = 1)
 
 # remplacer les valeurs nulle (NaN) par 0 et conversion en entier                    
concat_baits=concat_baits.replace(np.nan, 0) 
concat_baits=concat_baits.astype(int)
#blast_baits_contig = concat_baits.copy()

# exporter le tableau au format csv 
concat_baits.to_csv("blast_baits_contig.csv", sep= ";")

### 2) Création matrice pour compter le nombre de reads par baits à partir du mapping et du blast 
tab_mapping_reads=sorted(glob('/home/thiam/count_contig/*Contigs_groupBy_Baits'))
concat_reads = pd.concat((pd.read_csv(file, sep = " ", index_col = 0)
                       for file in tab_mapping_reads), axis = 1)
concat_reads

# remplacer les valeurs nulles par 0 et conversion en entier
concat_reads=concat_reads.replcae(np.nan, 0)
concat_reads=concat_reads.astype(int)

# exporter le tableau au format csv 
concat_reads.to_csv("mapping_reads_contig.csv", sep=";")

# Lectures des 2 matrices
blast_baits_contig=pd.read_csv("blast_baits_contig.csv", sep = ";", index_col = 0)
mapping_reads_contig = pd.read_csv("mapping_reads_contig.csv", sep = ";", index_col = 0)

### 3) Définition des fonctions
### Fonctions pour compter le nombre de baits ayant X reads chez N individus (en fonction du seuil de reads)
   ### Fonction 1 
liste=np.arange(10, 220, 10)
df_liste=pd.DataFrame(liste, columns=["nombre_individus"])
def count_baits(data,liste):
    value=[]
    for i in liste:
        a = len(data[(data["Somme"]>= i)])
        value.append(a)
        Data=pd.DataFrame(value, columns=["nombre_baits_seuil_reads"])        
        df_final=pd.concat([df_liste, Data], axis=1)
        df_final.to_csv("count_baits_ind_seuil.csv", sep = ";")
    return df_final
  
  ### Fonction 2
 def count_bait_all(mapping_reads_contig, seuil):
    mapping_reads_Sm = mapping_reads_contig.copy()
    mapping_reads_Sm[mapping_reads_Sm >= seuil] = 1
    mapping_reads_Sm[mapping_reads_Sm != 1] = 0
    mapping_reads_Sm["Somme"]=mapping_reads_Sm.sum(axis=1)
    return count_baits(mapping_reads_Sm, liste)

### Fonction pour ne prendre en compte cette fois ci que les baits ayant 1 hit
def bait_uniq(blast_baits_contig, mapping_reads_contig, minimum):
    blast_baits_contig_1 = blast_baits_contig.copy()
    blast_baits_contig_1[blast_baits_contig_1 !=1] = 0
    mapping_reads_Sm = mapping_reads_contig.copy()
    mapping_reads_Sm[mapping_reads_Sm < minimum] = 0
    mapping_reads_Sm[mapping_reads_Sm >= minimum] = 1
    mapping_reads_Sort_Sm=mapping_reads_Sm.sort_index(axis = 0).sort_index(axis = 1)
    blast_baits_contig_Sort_1 = blast_baits_contig_1.sort_index(axis = 0).sort_index(axis = 1)
    blast_min = pd.concat([mapping_reads_Sort_Sm, blast_baits_contig_Sort_1]).min(level = 0)
    blast_min["Somme"] = blast_min.sum(axis = 1)
    return count_baits(blast_min, liste)
  
  
