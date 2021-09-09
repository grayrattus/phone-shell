#/bin/sh

# Arguments
# number,color,number,color,label;number,color,number,color,label
# label - should be one letter, lowercased

# Usage example:
# sh raport.sh '10,red,20,green,30,blue,m;20,blue,t;30,red,s'

prevIFS="$IFS"
IFS=';'

maxValues=""
columnValues=""

# $1 - color: green, red, orange, yellow, blue, white
colorStdout() {
	case $1 in
		'blue')
			echo -n $(tput setaf 033) 
			;;

		'yellow')
			echo -n $(tput setaf 220) 
			;;

		'green')
			echo -n $(tput setaf 112) 
			;;

		'white')
			echo -n $(tput setaf 255) 
			;;

		'orange')
			echo -n $(tput setaf 208) 
			;;

		'red')
			echo -n $(tput setaf 196) 
			;;

		*)
			echo -n $(tput setaf 255)
			;;
	esac
}

for arugment in $@; do
	IFS=','
	totalAmount=$(echo $arugment |  grep -Eo '[0-9]+' | xargs | sed -E 's/ /\+/g' | bc -l)
	values=$(echo $arugment |  grep -Eo '[0-9]+' | xargs)

	maxValues="$maxValues $totalAmount"

	columnValues="$columnValues$values;"; 
done

maxValue=$(echo $maxValues | sed 's/ /\n/g' | sort -nr | head -n 1)

IFS="$prevIFS"

prevColumnValues=""

prevColums="$columnValues"
colors=$(echo $1 | grep -Eo 'red|green|yellow|white|orange|blue')
colorIndex=1
labels=$(echo $1 | grep -Eo '(,[a-z]+;)+' | grep -Eo '[a-z]') ;
labelIndex=1
for j in $(echo "$prevColums" | xargs); do
	label=$(echo $labels | sed -E 's/ /\n/g' | head -n $labelIndex | tail -1)
	echo -n $label
	for k in $(echo "$j" | xargs -d ';'); do
		echo -n ' '
	done
	labelIndex=$(echo "$labelIndex + 1" | bc)
done
echo

for i in $(seq 1 2 "$maxValue"); do
	for j in $(echo "$prevColums" | xargs); do
		for k in $(echo "$j" | xargs -d ';'); do
			newValue=$(echo "$k - 2" | bc);
			color=$(echo $colors | sed -E 's/ /\n/g' | head -n $colorIndex | tail -1)
			colorIndex=$(echo "$colorIndex + 1" | bc)

			if [ $k -ne 0 ];
			then 
				if [ $newValue -lt 0 ]; 
				then
					colorStdout $color; echo -n "\'"
				else
					colorStdout $color; echo -n ":"
				fi
				newColumns="$newColumns $newValue"
			else 
				echo -n " "
				newColumns="$newColumns $k"
			fi
		done
		newColumns="$newColumns;"
	done
	prevColums="$newColumns"
	newColumns=""
	echo
	colorIndex=1
	# echo "$i values $columnValues"
done

