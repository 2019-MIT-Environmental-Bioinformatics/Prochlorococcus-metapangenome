# Prochlorococcus-metapangenome
Annika Gomez and Irene Zhang

Delmont, T. O., & Eren, A. M. (2018). Linking pangenomes and metagenomes: the \ 
Prochlorococcus metapangenome. PeerJ, 6, e4320. doi:10.7717/peerj.4320 \

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
(http://merenlab.org/software/anvio/) and the ggplot2 library for R if necessary. \


# Downloading data

Download Prochlorococcus isolate genome & SAG fasta files: 

curl -L https://ndownloader.figshare.com/files/9416614 -o PROCHLOROCOCCUS-FASTA-FILES.tar.gz
tar -xzvf PROCHLOROCOCCUS-FASTA-FILES.tar.gz

The file PROCHLOROCOCCUS-FASTA-FILES contains: *CONTIGS-FOR-ISOLATES.fa* and *CONTIGS-FOR-SAGs.fa*

Removed non-Atlantic genomes from TARA ftp file 





