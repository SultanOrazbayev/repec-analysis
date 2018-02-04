#!/bin/bash -x

# run the set of commands that results in a csv with citations data

# import path/url settings
. settings.bash

# the function that describes the main sequence of events
main() {

	# download the raw data
#	getdata

	# transform into cited-citing format
	# the end format is (1)|(2), where (1) is the cited paper ID and (2) is the citing paper ID
	transformcit

	# conclude
	echo -e "All done! `date`"
}

# function for getting the data
getdata () {
	cd "$dataraw"
	curl --location --max-redirs 3 --output "iscited.txt.gz" "$urlcitationsdata" -- && echo "File downloaded on `date`." && gunzip -c "iscited.txt.gz" > "iscited.txt"
}

# function for transforming the data
transformcit () {
	cd "$dataraw"
	awk 'BEGIN {FS=" "} {n=split($2,a,"#"); for (i=0;++i <=n;) print tolower($1"|"a[i])}' "iscited.txt" > "rawcitations.txt" && { echo "idcited|idciting"; cat "rawcitations.txt"; } > "$dataprocessed/rawcitations.txt"
}

# launch
main

