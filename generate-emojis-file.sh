#/bin/sh

# Downloads emoji unicodes and their description and then create file with them
# $1 - name of the file to put emojis with their description. When not provided it will store .csv in
#      ~/.config/emoji/emoji.csv
emojiFile=$(mktemp)
unicodes=$(mktemp)
description=$(mktemp)

emojiDefaultDir=~/.config/emoji
defaultFile=$emojiDefaultDir/emoji.csv
outFile=$1
if [ -z $outFile ]; then
	echo "No arguments provided. Default file will be used in $defaultFile"
	[ ! -d $emojiDefaultDir ] && mkdir -p $emojiDefaultDir
	touch $defaultFile
	outFile="${defaultFile}"
fi

curl https://unicode.org/Public/emoji/13.1/emoji-sequences.txt | grep Basic_Emoji > $emojiFile

cat $emojiFile | cut -d';' -f 1 |  cut -d'.' -f 1 | tr -s " " | sed -e 's/\s$//' -e 's/\s/\\U/' -e 's/^/\\U/' | tail -n +3 > $unicodes
cat $emojiFile | cut -d ';' -f 3 | cut -d '#' -f 1 | tr -s ' ' | sed -e 's/^\s//' -e 's/\s$//' -e 's/\s/-/g' | tail -n +3 > $description

paste "$description" "$unicodes" -d ';' > ${outFile}
