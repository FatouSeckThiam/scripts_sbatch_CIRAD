#!/bin/bash

#SBATCH -J multiqc                  ### Job name

#SBATCH -o multiqc."%j".out          ### Standard output

#SBATCH -e multiqc."%j".err          ### Standard error

#

#SBATCH --partition=agap_normal   ### Partition

#SBATCH --time=01:00:00           ### WallTime

#SBATCH --nodes=1

#SBATCH --ntasks=1

#SBATCH --array=0-353%5            ### Array index from 0 to 19 with 4 running jobs

module purge



module load multiqc/1.9



multiqc .

                                                             

