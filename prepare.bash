#!/bin/bash
export LC_ALL=C

# run the set of commands that prepares the downloaded data for further processing

# import path/url settings
	. settings.bash

# the function that describes the main sequence of events
main() {

	# create a list of cited-citing documents
#	preparecitations

	# create a list of related documents
#	preparerelated

	# create a json file with document meta-data
	preparemetadata

        # conclude
        echo -e "Done preparing! `date`"

}

preparecitations () {

	echo "idcited|idciting" > "data/processed/rawcitations.txt"
	gunzip -c "data/raw/iscited.txt.gz" | awk 'BEGIN {FS=" "} {n=split($2,a,"#"); for (i=0;++i <=n;) print tolower($1"|"a[i])}' >> "data/processed/rawcitations.txt"

}

preparerelated () {

	# copy a supporting file
	perl prepare-hash2json.pl "data/raw/related.dat"

	echo "iddocument,relatedtype,idrelated,yearrelated,sourcerelated" > "data/processed/related-documents.txt"
        jq -rc 'to_entries|.[] as $x | $x.value | to_entries | .[] as $y | $y.value | to_entries | .[] as $z | [$x.key,$y.key,$z.key,$z.value.year,$z.value.source] | @csv' "data/processed/data_out.json" >> "data/processed/related-documents.txt"
	rm -v "data/processed/data_out.json"

}

# this function accepts a file and converts it to json format
converttojson () {

	while read -r rawline; do
		line=$( echo "$rawline" | awk '{print tolower($0)}'| tr -d '\000-\011\013\014\016-\037' | tr -d '\r' | sed $'s/\xEF\xBB\xBF//' | awk 'NR==1{sub(/^\xef\xbb\xbf/,"")}{print}' )
		if [[ $line =~ ^.*template-type:.*  ]]; then

			# if closed is 0 then the previous entry is not complete
			# if closed is 1 then this is a new entry
				if [[ $closed == 0 ]]; then
	        	                if [[ $authors != "" ]]; then
        	        	                echo -e ",\"authors\": [ $authors ] "
                	        	fi
	                        	echo "}"
		                	closed=1
				fi
		
			echo -e "{\"filename\":\"$1\"",
			closed=0
			authors=""
			echo -e "$line" | sed -e "s#^\([^:]*\):\(.*\)#\"\1\" : \"\2\"#"
		elif [[ $line =~ ^author-name:.* ]]; then
			tempname=$( echo -e "$line" | sed -e 's#"##g' -e "s#^\([^:]*\):\(.*\)#\"\2\"#" )
			if [[ $authors == "" ]]; then
			authors="$tempname"
			else
			authors="$authors, $tempname"
			fi
		elif [[ $line =~ ^title:.*|^creation-date:.*|^length:.*|^classification-jel:.*|^keywords:.*|^handle:.*|^paper-handle:.*|^name:.*|^type:.*|^revision-date:.*|^number:.*|^volume:.*|^issue:.*|^doi:.*|^year:.*|^month:.*|^journal:.*|^edition:.*|^in-book:.*|^pages:.*|^chapter:.*|^description:.*  ]]; then
			echo -e "$line" | sed -e 's#"##g' -e "s#^\([^:]*\):\(.*\)#,\"\1\" : \"\2\"#"
		fi
	done < "$1"

		if [[ "$closed" == 0 ]]; then
                        if [[ $authors != "" ]]; then
                                echo -e ",\"authors\": [ $authors ] "
                        fi
                        echo "}"
                        closed=1
		fi 

}
export -f converttojson

preparemetadata () {
	# find .rdf files and process them in parallel
	find data -type f -name "*.rdf" | parallel -I % -n 1 converttojson % > data/processed/metadata.json
}

# launch

	main

