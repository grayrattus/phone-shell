#/bin/sh

# Arguments
# number,color,number,color,label;number,color,number,color,label
#

IFS=';'

maxValues=""
columnValues=""

for arugment in $@; do
	IFS=','
	totalAmount=$(echo $arugment |  grep -Eo '[0-9]+' | xargs | sed -E 's/ /\+/g' | bc -l)
	values=$(echo $arugment |  grep -Eo '[0-9]+' | xargs)

	maxValues="$maxValues $totalAmount"

	columnValues="$columnValues$values;"; 
	echo $columnValues
done

maxValue=$(echo $maxValues | sed 's/ /\n/g' | sort -nr | head -n 1)

IFS=' '

prevColumnValues=""
for i in "$(seq 1 $maxValue)"; do
	echo "$i values $columnValues"
done

