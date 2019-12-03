#!/bin/bash
#SBATCH --job-name=anvi-db-cogs-hmm
#SBATCH --mail-type=END
#SBATCH --mail-user=gomezal@mit.edu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=50gb
#SBATCH --time=12:00:00
#SBATCH --output=anvi-db_%j.log

anvi-gen-contigs-database -f data/PROCHLOROCOCCUS-FASTA-FILES/seqs-fixed.fa -o databases/Prochlorococcus-CONTIGS.db -n "Prochlorococcus Isolates and SAGs"

anvi-run-hmms -c databases/Prochlorococcus-CONTIGS.db --num-threads 20

anvi-run-ncbi-cogs -c databases/Prochlorococcus-CONTIGS.db --num-threads 20

bowtie2-build data/PROCHLOROCOCCUS-FASTA-FILES/seqs-fixed.fa databases/prochlorococcus-bowtie

for sample in `awk '{print $1}' data/quality-filtered-fastqs/Atlantic_samples.txt`
do
    if [ "$sample" == "sample" ]; then continue; fi
    # do the bowtie mapping to get the SAM file:
    bowtie2 --threads 20 \
            -x databases/prochlorococcus-bowtie \
            -1 data/quality-filtered-fastqs/"$sample"-QUALITY_PASSED_R1.fastq \
            -2 data/quality-filtered-fastqs/"$sample"-QUALITY_PASSED_R2.fastq \
            --no-unal \
            -S output/"$sample".sam

    # covert the resulting SAM file to a BAM file:
    samtools view -F 4 -bS output/"$sample.sam" > output/"$sample-RAW.bam"

    # sort and index the BAM file:
    samtools sort output/"$sample"-RAW.bam -o output/"$sample".bam
    samtools index output/"$sample".bam

    # remove temporary files:
    rm output/"$sample.sam" output/"$sample"-RAW.bam
done

for sample in `awk '{print $1}' data/quality-filtered-fastqs/Atlantic_samples.txt`
do
  	if [ "$sample" == "sample" ]; then continue; fi

        anvi-profile -c databases/Prochlorococcus-CONTIGS.db -i output/"$sample".bam -M 100 --skip-SNV-profiling --num-threads 20 -o databases/"$sample"
done
