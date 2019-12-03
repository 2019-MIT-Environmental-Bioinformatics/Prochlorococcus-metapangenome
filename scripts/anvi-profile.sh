#!/bin/bash
#SBATCH --job-name=profile
#SBATCH -p  compute 
#SBATCH --mail-type=END
#SBATCH --mail-user=gomezal@mit.edu
#SBATCH -N 1
#SBATCH -n 20
#SBATCH --mem=50gb
#SBATCH --time=05:00:00
#SBATCH --output=profile_%j.log

for sample in `awk '{print $1}' data/quality-filtered-fastqs/Atlantic_samples.txt`
do
	if [ "$sample" == "sample" ]; then continue; fi

	anvi-profile -c databases/Prochlorococcus-CONTIGS.db -i output/"$sample".bam -M 100 --skip-SNV-profiling --num-threads 20 -o databases/"$sample"
done 

