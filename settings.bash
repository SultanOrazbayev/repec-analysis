#!/bin/bash -x

# edit this line to set the path to your working folder
pathmain=~/"Dropbox/RDiversity/draft/"

dataraw="$pathmain/data/raw"
mkdir -p "$dataraw"

dataprocessed="$pathmain/data/processed"
mkdir -p "$dataprocessed"

dataready="$pathmain/data/ready"
mkdir -p "$dataready"

supportscripts="$pathmain/scripts/supporting"
mkdir -p "$supportscripts"

# these URLs should be fairly stable, but can be adjusted if necessary

# citations
urlcitationsdata="ftp://ftp.repec.org/RePEc/cit/conf/iscited.txt.gz"

# related documents
urlrelateddata="ftp://ftp.repec.org/opt/ReDIF/RePEc/cpd/conf/relatedworks.dat"
