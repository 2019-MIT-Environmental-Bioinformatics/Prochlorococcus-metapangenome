#!/bin/bash
#SBATCH --job-name=bowtie
#SBATCH -p  compute 
#SBATCH --mail-type=END
#SBATCH --mail-user=gomezal@mit.edu
#SBATCH -N 1
#SBATCH -n 20
#SBATCH --mem=100gb
#SBATCH --time=10:00:00
#SBATCH --output=bowtie_%j.log

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




