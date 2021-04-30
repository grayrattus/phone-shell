#!/usr/bin/env zsh
echo "$(cat ${EMOJI_FILE} | grep $1 | cut -d ';' -f 2 | head -n 1)"
