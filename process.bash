#!/bin/bash
export LC_ALL=C

# run the set of commands that processes the downloaded data

# import path/url settings
	. settings.bash

# the function that describes the main sequence of events
main() {

	# create a list of author-claimeddocuments and author-affiliations
	processauthors

	# create a list of author-affiliation
#	processaffiliations

        # conclude
        echo -e "Done processing! `date`"

}

# accepts a file name and extracts claimed documents
getauthordocuments () {

	# tempcopy to avoid reading the file multiple times
	tempcopy=$( cat "$1" )

	# get author id
	tempid=$( echo "$tempcopy" |  awk '{print tolower($0)}' | sed -n -e 's#^short-id:\ *##p' )

	# get claimed documents
	echo "$tempcopy" | awk '{print tolower($0)}'|  grep -ai "^author-[paperarticle]*:" | sed -n -e "s#^author-\([a-z]*\):\ *\(.*\)#\1|\2#p" -e "s#^#$tempid|#p"

}
export -f getauthordocuments


# accepts a file name and extracts affiliations with shares
getauthoraffiliations () {

	# tempcopy to avoid reading the file multiple times
	tempcopy=$( cat "$1" )

	# get author id
	tempid=$( echo "$tempcopy" |  awk '{print tolower($0)}' | sed -n -e 's#^short-id:\ *##p' )

	# get claimed affiliations
	echo "$tempcopy" | awk '{print tolower($0)}' | sed -n -e "s#^workplace-\([a-z]*\):\ *\(.*\)#$tempid|\1|\2#p"

}
export -f getauthoraffiliations


processauthors () {

	echo "idauthor|documenttype|iddocument" > data/processed/author-documents.txt
	find data/raw/repecall/per/pers -type f -name "*.rdf" | parallel -n 1 -I % getauthordocuments % >> data/processed/author-documents.txt

	find data/raw/repecall/per/pers -type f -name "*.rdf" | parallel -n 1 -I % getauthoraffiliations % > data/processed/author-affiliations.txt

}

# launch

	main

