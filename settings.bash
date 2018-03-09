#!/bin/bash -x

# echo current dir and make folders
echo "Current directory is:"
pwd

mkdir -p data/raw
mkdir -p data/processed
mkdir -p data/ready

# these URLs should be fairly stable, but can be adjusted if necessary

# all directories
urlmirrorrepec="rsync://rsync.repec.org/RePEc-ReDIF/"

# citations
urlcitationsdata="ftp://ftp.repec.org/RePEc/cit/conf/iscited.txt.gz"

# related documents
urlrelateddata="ftp://ftp.repec.org/opt/ReDIF/RePEc/cpd/conf/relatedworks.dat"
