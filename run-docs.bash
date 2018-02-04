#!/bin/bash -x

# run the set of commands that download and process meta data on documents

# import path/url settings
. settings.bash

# the function that describes the main sequence of events
main() {

	# download the raw data
#	getdata

	# process documents
#	processdocs

	# conclude
	echo -e "All done! `date`"
}

# function for getting the data
getdata () {
	cd "$dataraw"
	mkdir -p repecall
	rsync -vaP --include="*/" --include="*.rdf" --include="*.redif" --exclude="*" --delete rsync://rsync.repec.org/RePEc-ReDIF/ repecall
}

# function for processing the author data
processdocs () {
	cd "$dataraw"
	cd repecall
:
#TBD
}

# launch
main
