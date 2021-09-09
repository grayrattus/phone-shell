#/bin/zsh

# $1 - file to generate raport from

dayIndex=1;
prevDateIndex=$(cat $1 | grep -E '^([0-6]{2})/[0-6]{2}' | cut -d ' ' -f 1,2 | sort -k 4 -k 1 -k 2 -r | cut -d '/' -f 2 | head -n 1);
diaryEntriesFromWeek=""

cat $1 | grep -E '^([0-6]{2})/[0-6]{2}' | cut -d ' ' -f 1,2 | sort -k 4 -k 1 -k 2 -r | while read day
do
	if [ $dayIndex -gt 7 ];
	then
		IFS=";"
		elements=""
		index=1;
		for i in $diaryEntriesFromWeek; do
			for j in 😀 😏 😐 🙁 😭; do
				# Fix bug here
				elements="$elements $(echo -n $(echo $i | grep -o $j | wc -l)),white"
			done
			elements="$elements,$index;"
			index=$(echo "$index + 1" | bc)
			# elements=$(echo "$(echo $i | sed 's/,/\n/g' | wc -l) - 1" | bc )
			# echo $i
		done

		echo $elements
		# echo $diaryEntriesFromWeek
		# number,color,number,color,label;number,color,number,color,label
		break
	fi
	dateIndex=$(echo $day | cut -d '/' -f 2);

	if [ $dateIndex -eq $prevDateIndex ];
	then
		diaryEntriesFromWeek="$diaryEntriesFromWeek $day,";
	else
		diaryEntriesFromWeek="$diaryEntriesFromWeek, $day;";
		prevDateIndex=$dateIndex;
		dayIndex=$(echo "$dayIndex + 1" | bc);
	fi
done

