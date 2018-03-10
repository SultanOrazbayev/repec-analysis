#!/bin/bash -x

# run the set of commands that results in a csv with related documents

# import path/url settings
. settings.bash

# the function that describes the main sequence of events
main() {

	# download the raw data
#	getdata

	# convert into json format
	# the end format is (1)|(2), where (1) is a document ID and (2) is the ID of a related document (note that by default the data will be symmetric and to distinguish which of the files is the 'original' and which is 'latest' requires additional meta-data (further processing)
	convertrelated

	# conclude
	echo -e "All done! `date`"
}

# function for getting the data
getdata () {
	cd "$dataraw"
	curl --location --max-redirs 3 --output "related.dat" "$urlrelateddata" -- && echo "File downloaded on `date`."
}

# function to convert related data into json format
convertrelated () {
	cp "$supportscripts/HASH2JSON.pl" "$dataraw/HASH2JSON.pl"
	cd "$dataraw"
	perl HASH2JSON.pl related.dat
	jq -rc 'to_entries|.[] as $x | $x.value | to_entries | .[] as $y | $y.value | to_entries | .[] as $z | [$x.key,$y.key,$z.key,$z.value.year,$z.value.source] | @csv' data_out.json > related-ready.txt
	{ echo "iddocument,relatedtype,idrelated,yearrelated,sourcerelated"; cat "related-ready.txt"; } > "$dataprocessed/related-ready.txt"
}

# launch
main
