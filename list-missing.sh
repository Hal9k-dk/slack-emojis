#!/bin/bash
cd "$(dirname "$0")"

TOKEN=$(cat token)
BACKUPFOLDER=emojis
mkdir -p $BACKUPFOLDER

emojiList=$(curl -s "https://slack.com/api/emoji.list?token=$TOKEN" | jq '.emoji')


for f in $BACKUPFOLDER/*; do
  key=$(basename $f | cut -f 1 -d '.')
  if [ $(jq -r ".[\"$key\"]" <<< $emojiList) = null ]; then
    echo Missing: $key
  fi
done
