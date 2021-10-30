#! /usr/bin/env bash
###################################################################
# rsync.sh : Ecrit par Jérémy Verrier				  #
# Script permettant la copie sécurisée de fichiers ou de dossiers #
###################################################################

# Entrez votre nom d'utilisateur
USER=/home/thiamf/scratch/Fatou
# Entrez le chemin complet du répertoire ou du fichier à copier (/home/verrier/work/results.txt)
DOSSIER_CLUSTER=
# Entrez le chemin complet du répertoire ou du fichier de destination
DOSSIER_PERSO=/home/zotta

while [ 1 ]
do
    rsync -avz --progress --partial "${USER}"@muse-login.hpc-lr.univ-montp2.fr:"${DOSSIER_CLUSTER}" "${DOSSIER_PERSO}"
    if [ "$?" = "0" ] ; then
        echo "Rsync OK"
        exit
    else
        echo "Rsync erreur, nouvelle tentative dans 1 minute..."
        sleep 60
    fi
done
