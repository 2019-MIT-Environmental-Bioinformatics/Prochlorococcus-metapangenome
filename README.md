# Prochlorococcus-metapangenome
Annika Gomez and Irene Zhang

Delmont, T. O., & Eren, A. M. (2018). Linking pangenomes and metagenomes: the 
Prochlorococcus metapangenome. PeerJ, 6, e4320. doi:10.7717/peerj.4320 

We propose to use the 31 isolate genomes for Prochlorococcus that Delmont and Eren \
downloaded from the NCBI database (totaling 55 MB, available at  \
https://figshare.com/articles/Prochlorococus_FASTA_files_for_isolates_and_SAGs/5447221 \
along with 25 metagenomes from the Atlantic Ocean from the TARA Oceans project as opposed \
to the 93 used in the paper (about 1 GB). We will filter these reads for quality using the \
parameters delineated by Delmont and Eren and annotate functional genes within these \
genomes. We will distinguish between environmental core genes and environmental accessory \
genes for each genome using anvi’o based upon a coverage value threshold (25%) for each \
gene across all genomes. From this we can compute the Prochlorococcus pangenome in anvi’o. \
We will visualize the results of our analysis and recreate Figures 1-4 using anvi’o \
(http://merenlab.org/software/anvio/) and the ggplot2 library for R if necessary. 

# Anvi'o installation

We installed anvi'o 6.1 using conda according to the instructions found here: http://merenlab.org/2016/06/26/installation-v2/

    conda create -n anvio-6.1 python=3.6
    conda activate anvio-6.1
    conda install -y -c conda-forge -c bioconda anvio=6.1
    conda install -y diamond=0.9.14

We checked the installation using:

    anvi-self-test --suite mini

And saved the environment using:

    conda env export > anvio-6.1.yml

After attempting to run a later step, we realized that another necessary part of the installation was setting up the NCBI COG database: 
    
    anvi-setup-ncbi-cogs


# Downloading data

Download Prochlorococcus isolate genome & SAG fasta files: 

    curl -L https://ndownloader.figshare.com/files/9416614 -o PROCHLOROCOCCUS-FASTA-FILES.tar.gz
    tar -xzvf PROCHLOROCOCCUS-FASTA-FILES.tar.gz

The file PROCHLOROCOCCUS-FASTA-FILES contains: *CONTIGS-FOR-ISOLATES.fa* and *CONTIGS-FOR-SAGs.fa*
To combine these into a single fasta file, run the following command:

    cat CONTIGS-FOR-ISOLATES.fa CONTIGS-FOR-SAGs.fa > Prochlorococcus-genomes.fa

We also included in the analysis 5 new SAGs (courtesy of Maria), which were downloaded into the folder *Maria_SAGs*. To unzip each of these files: 

    for fasta in Maria_SAGs/
    do
    gunzip $fasta
    done 

We then combined all the genome sequences into a single file...

    cat Maria_SAGs/*.fna Prochlorococcus-genomes.fa >> all-genome-seqs.fa

...And edited the deflines of the new SAGs to be consistent with the ones used in the paper:

    awk '{ if (substr($1,1,3) == ">CA") print ">" substr($10,1,10) substr($10,16,length($10)-1); else print $0}' all-genome-seqs.fa > all-genome-seqs-fixed.fa

For example, a defline in the *PROCHLOROCOCCUS-FASTA-FILES/CONTIGS-FOR-ISOLATES.fa* file is:

">AS9601-00000001"; where "AS9601" represents the name of the isolate, and "00000001" represents the contig within that genome. The file *CONTIGS-FOR-SAGs.fa* follows the same format. 
  
However, the deflines in the new SAGs we downloaded are formated as follows:
 
">CACAYO010000001.1 uncultured Prochlorococcus sp. isolate AG-349-G23 genome assembly, contig: AG-349-G23_NODE_1, whole genome shotgun sequence"
The awk command above extracts the genome (AG-349-G23) and contig number (1) from the defline and formats it in a way that is consistent with the deflines given above. 

Removed non-Atlantic genomes from TARA ftp file 




# Creating Anvi'o contigs database:
    - An anvio contigs database stores the sequence information from each of the inputted contigs, predicts ORFs, and adds information generated from searching these contigs against a reference databases, using HMMs and BLAST, to uncover function of genes populating the database
    
Before generating the database, we using the following command to edit the deflines in the fasta files to anvi'o's specifications:

    anvi-script-reformat-fasta data/PROCHLOROCOCCUS-FASTA-FILES/all-genome-seqs-fixed.fa -o seqs-fixed.fa -l 0 --simplify-names --report-file report-deflines.tab
 
 We then used the *anvi-db-cogs-hmms.sh* script to generate a contigs database and populate it with information from an HMM and BLAST search.
 
    sbatch scripts/anvi-db-cogs-hmms.sh 






