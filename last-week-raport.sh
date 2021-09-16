#/bin/zsh

# $1 - file to generate raport from

dayIndex=1;
prevDateIndex=$(cat $1 | grep -E '^([0-9]{2})/[0-9]{2}' | cut -d ' ' -f 1,2 | sort -k 4 -k 1 -k 2 -r | cut -d '/' -f 2 | head -n 1);
diaryEntriesFromWeek=""

days=(q w e \r t y u);
cat $1 | grep -E '^([0-9]{2})/[0-9]{2}' | cut -d ' ' -f 1,2 | sort -k 4 -k 1 -k 2 -r | while read day
do
	if [ $dayIndex -gt 7 ];
	then
		elements=""
		index=1;
		parts=(${(s/;/)diaryEntriesFromWeek})
		for i in $parts; do
			for j in 😀 😏 😐 🙁 😭; do
				# Fix bug here
				color=$(echo $j | sed 's/😀/blue/g' | sed 's/😏/green/g' | sed 's/😐/yellow/g' | sed 's/🙁/orange/g' |   sed 's/😭/red/g')
				elements="$elements $(echo -n $(echo $i | grep -o $j | wc -l)),$color,"

			done
			elements=$(echo $elements | sed 's/,$//g' | sed 's/ //g')
			elements="$elements,${days[index]};"
			index=$(echo "$index + 1" | bc)
			# elements=$(echo "$(echo $i | sed 's/,/\n/g' | wc -l) - 1" | bc )
		done

		zsh utils/raport.sh $elements
		# echo $diaryEntriesFromWeek
		# number,color,number,color,label;number,color,number,color,label
		break
	fi
	dateIndex=$(echo $day | cut -d '/' -f 2);

	if [ $dateIndex -eq $prevDateIndex ];
	then
		diaryEntriesFromWeek="$diaryEntriesFromWeek $day,";
	else
		diaryEntriesFromWeek="$diaryEntriesFromWeek;$day";
		prevDateIndex=$dateIndex;
		dayIndex=$(echo "$dayIndex + 1" | bc);
	fi
done

