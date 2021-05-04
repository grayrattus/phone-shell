#!/usr/bin/env zsh
# Script returns unicode emoji for given name of emoji. When full name is matched
# then the matching emoji is returned. If no full match is present only first matching
# occurence is returned
# $1 - emoji to grep for. 

grep $1 ${EMOJI_FILE} | while read -r matchedLine; do
 	if [[ "$1" == "$(echo $matchedLine | cut -d ';' -f 1)" ]]; then
 		printf "$(echo $matchedLine | cut -d ';' -f 2)";
 		exit 0;
 	fi
done
printf "$(echo $matches | grep $1 | cut -d ';' -f 2 | head -n 1)"
exit 0;

