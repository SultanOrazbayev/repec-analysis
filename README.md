# repec-analysis
A set of scripts to analyse the data from RePEc.

This is a work in progress. Comments are welcome! A descriptive paper is available here: https://ideas.repec.org/p/pra/mprapa/81963.html. Also, be sure to check out another repository with RePEc-related scripts: https://github.com/repec-org. 

The raw data can be processed in several independent procedures, after completing these procedures the processed data can be merged for further analysis.

Software requirements: bash (curl, awk), rsync, Perl, jq.

# First step - downloading the data

To download all the data (publications, citations, author, institutions), run bash script "download.bash".





=======OLD STUFF BELOW

1A) Data on citations

Data on citations is processed/collected by CitEc (http://citec.repec.org). The bash script "run-citations.bash" downloads the raw data, processes it into csv format (cited paper ID | citing paper ID).

1B) Data on related documents (works)

Data on related documents (works) is collected by EconPapers (https://econpapers.repec.org). The bash script "run-related.bash" downloads the raw data file and converts it into a csv format (document ID | related document ID).

1C) Data on authors (including claimed documents)

Data on authors is collected by RePEc Author Service (https://authors.repec.org). The bash script "run-authors.bash" downloads the data and creates two csv files: (author|claimed document), (author|claimed affiliation).

1D) Data on documents (works)

TBD: Data on documents is provided by archive maintainers (mostly volunteers). The bash script "run-docs.bash" downloads the data and creates the following csv files: (document|jelcode), (document|meta). Meta information contains publication year, name of the journal of working paper series.

1E) Data on organizations (institutions, departments, etc.)

TBD.

# Second steps (further processing and merging of the data)

# Third step (analysis)
