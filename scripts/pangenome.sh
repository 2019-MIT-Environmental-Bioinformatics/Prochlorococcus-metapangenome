#!/bin/bash
#SBATCH --job-name=isolate_pangenome
#SBATCH -p  compute 
#SBATCH --mail-type=END
#SBATCH --mail-user=gomezal@mit.edu
#SBATCH -N 1
#SBATCH -n 20
#SBATCH --mem=100gb
#SBATCH --time=10:00:00
#SBATCH --output=isolate_pangenome_%j.log

anvi-gen-genomes-storage -i internal-genomes.txt -o ../databases/Prochlorococcus-ISOLATE-PAN-GENOMES.db

anvi-pan-genome -g ../databases/Prochlorococcus-ISOLATE-PAN-GENOMES.db --use-ncbi-blast --minbit 0.5 --mcl-inflation 10 --project-name Prochloroccocus-ISOLATE-PAN --num-threads 20



