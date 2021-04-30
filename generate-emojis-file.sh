#/bin/sh

# Downloads emoji unicodes and their description and then create file with them
# $1 - name of the file to put emojis with their description
emojiFile=$(mktemp)
unicodes=$(mktemp)
description=$(mktemp)

curl https://unicode.org/Public/emoji/13.1/emoji-sequences.txt | grep Basic_Emoji > $emojiFile

cat $emojiFile | cut -d';' -f 1 |  cut -d'.' -f 1 | tr -s " " | sed -e 's/\s$//' -e 's/\s/\\U/' -e 's/^/\\U/' | tail -n +3 > $unicodes
cat $emojiFile | cut -d ';' -f 3 | cut -d '#' -f 1 | tr -s ' ' | sed -e 's/^\s//' -e 's/\s$//' -e 's/\s/-/g' | tail -n +3 > $description

paste "$description" "$unicodes" -d ';' > $1
