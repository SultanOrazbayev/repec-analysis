#!/bin/bash
export LC_ALL=C.UTF-8

# run the set of commands that download the data on documents

# import path/url settings
. settings.bash

# the function that describes the main sequence of events
main() {

        # download the raw data on documents
        getdocuments

	# download the raw data on citations
#	getcitations

	# download the raw data on related documents
#	getrelated

        # conclude
        echo -e "Done downloading! `date`"

}

# function for getting the documents
getdocuments () {

        rsync -vaP --include="*/" --include="*.rdf" --include="*.redif" --exclude="*" --delete "$urlmirrorrepec" data/raw/repecall

}

# function for getting the citations
getcitations () {
        
	curl --location --max-redirs 3 --output "data/raw/iscited.txt.gz" "$urlcitationsdata" -- && echo "File downloaded on `date`." && gunzip -c "data/raw/iscited.txt.gz" > "data/raw/iscited.txt"
	awk 'BEGIN {FS=" "} {n=split($2,a,"#"); for (i=0;++i <=n;) print tolower($1"|"a[i])}' "data/raw/iscited.txt" > "data/raw/rawcitations.txt" && { echo "idcited|idciting"; cat "data/raw/rawcitations.txt"; } > "data/processed/rawcitations.txt"

}

getrelated () {

	curl --location --max-redirs 3 --output "data/raw/related.dat" "$urlrelateddata" -- && echo "File downloaded on `date`."

	# copy a supporting file
	pwd
        perl HASH2JSON.pl "data/raw/related.dat"
        jq -rc 'to_entries|.[] as $x | $x.value | to_entries | .[] as $y | $y.value | to_entries | .[] as $z | [$x.key,$y.key,$z.key,$z.value.year,$z.value.source] | @csv' "$dataraw/data_out.json" > "data/raw/related-ready.txt"
        { echo "iddocument,relatedtype,idrelated,yearrelated,sourcerelated"; cat "data/raw/related-ready.txt"; } > "data/processed/related-ready.txt"

}

# launch
main


