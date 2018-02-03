# repec-analysis
A set of scripts to analyse the data from RePEc.

This is a work in progress. Comments are welcome! A descriptive paper is available here: https://ideas.repec.org/p/pra/mprapa/81963.html.

The raw data can be processed in several independent procedures, after completing these procedures the processed data can be merged for further analysis.

A) Data on citations

Data on citations is processed/collected by CitEc (http://citec.repec.org). The bash script "run-citations.bash" downloads the raw data, processes it into csv format (cited paper ID | citing paper ID). Stata script "run-citations.do" uses the csv file to generate some descriptive statistics.

B) Data on authors

TBC.


