# repec-analysis
A set of scripts to analyse the data from RePEc.

This is a work in progress. Comments are welcome! A descriptive paper is available here: https://ideas.repec.org/p/pra/mprapa/81963.html. Also, be sure to check out another repository with RePEc-related scripts: https://github.com/repec-org. 

The raw data can be processed in several independent procedures, after completing these procedures the processed data can be merged for further analysis.

Software requirements: bash (curl, awk), rsync, Perl, jq.

A) Data on citations

Data on citations is processed/collected by CitEc (http://citec.repec.org). The bash script "run-citations.bash" downloads the raw data, processes it into csv format (cited paper ID | citing paper ID).

B) Data on related documents (works)

Data on related documents (works) is collected by EconPapers (https://econpapers.repec.org). The bash script "run-related.bash" downloads the raw data file and converts it into a csv format (document ID | related document ID).

C) Data on authors (including claimed documents)

Data on authors is collected by RePEc Author Service (https://authors.repec.org). The bash script "run-authors.bash" downloads the data and creates two csv files: (author|claimed document), (author|claimed affiliation).


