#!/bin/bash -x

# run the set of commands that results in two csv files with author data

# import path/url settings
. settings.bash

# the function that describes the main sequence of events
main() {

	# download the raw data
#	getdata

	# transform into author-specific information
	processauthors

	# conclude
	echo -e "All done! `date`"
}

# function for getting the data
getdata () {
	cd "$dataraw"
	mkdir -p authors
	rsync -vaP --include="*/" --include="*.rdf" --include="*.redif" --exclude="*" --delete rsync://rsync.repec.org/RePEc-ReDIF/per authors
}

# function for processing the author data
processauthors () {
	cd "$dataraw"
	cd authors

	# process information on author-claimed documents
	{ echo "idauthor|doctype|iddocument"; LC_ALL=C grep -raiEH "^author-" . | sed -e "s#.*$pra/\(.*\).rdf:\([^:]*\):\ *\(.*\)#\1|\2|\3#" | cat; } > "$dataprocessed/author-allworks.txt"

	# process information on author-claimed affiliations
	#TBD
}

# launch
main

