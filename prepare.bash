#!/bin/bash
export LC_ALL=C

# run the set of commands that prepares the downloaded data for further processing

# import path/url settings
	. settings.bash

# the function that describes the main sequence of events
main() {

	# create a list of cited-citing documents
	preparecitations

	# create a list of related documents
	preparerelated

        # conclude
        echo -e "Done processing! `date`"

}

preparecitations () {

	echo "idcited|idciting" > "data/processed/rawcitations.txt"
	gunzip -c "data/raw/iscited.txt.gz" | awk 'BEGIN {FS=" "} {n=split($2,a,"#"); for (i=0;++i <=n;) print tolower($1"|"a[i])}' >> "data/processed/rawcitations.txt"

}

preparerelated () {

	# copy a supporting file
	perl HASH2JSON.pl "data/raw/related.dat"

	echo "iddocument,relatedtype,idrelated,yearrelated,sourcerelated" > "data/processed/related-documents.txt"
        jq -rc 'to_entries|.[] as $x | $x.value | to_entries | .[] as $y | $y.value | to_entries | .[] as $z | [$x.key,$y.key,$z.key,$z.value.year,$z.value.source] | @csv' "data/processed/data_out.json" >> "data/processed/related-documents.txt"
	rm -v "data/processed/data_out.json"

}

# launch

	main

