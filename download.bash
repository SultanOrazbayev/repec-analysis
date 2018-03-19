#!/bin/bash
export LC_ALL=C

# run the set of commands that download the data on documents

# import path/url settings
	. settings.bash

# the function that describes the main sequence of events
main() {

        # download the raw data on documents
        getdocuments

	# download the raw data on citations
	getcitations

	# download the raw data on related documents
	getrelated

        # conclude
        echo -e "Done downloading! `date`"

}

# function for getting the documents
getdocuments () {

        rsync -vaP --include="*/" --include="*.rdf" --include="*.redif" --exclude="*" --delete "$urlmirrorrepec" data/raw/repecall

}

# function for getting the citations
getcitations () {
        
	curl --location --max-redirs 3 --output "data/raw/iscited.txt.gz" "$urlcitationsdata" -- && echo "File downloaded on `date`." 

}

getrelated () {

	curl --location --max-redirs 3 --output "data/raw/related.dat" "$urlrelateddata" -- && echo "File downloaded on `date`."

}

# launch

	main
