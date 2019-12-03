#!/bin/bash

for split_name in `sqlite3 databases/Prochlorococcus-CONTIGS.db 'select split from splits_basic_info;'`
do
    # in this loop $split_name looks like this AS9601-00000001_split_00001, form which
    # we can extract the genome name the split belongs to:
   # GENOME=`echo $split_name | awk 'BEGIN{FS="-"}{print $1}'`

    # print it out with a TAB character
    #echo -e "$split_name\t$GENOME"
	echo $split_name
done > Prochlorococcus-GENOME-COLLECTION.txt
