#!/bin/bash
cd "$(dirname "$0")"

TOKEN=$(cat token)
BACKUPFOLDER=emojis
mkdir -p $BACKUPFOLDER

emojiList=$(curl -s "https://slack.com/api/emoji.list?token=$TOKEN" | jq '.emoji')

for e in $(jq 'keys|@sh' <<< $emojiList | tr -d \' | tr -d \"); do
  url=$(jq -r ".[\"$e\"]" <<< $emojiList)
  if grep -q -E '^alias:' <<< $url; then
    #alias
    file=$BACKUPFOLDER/${e}.alias
  else
    #url
    suffix=${url##*.}
    file=$BACKUPFOLDER/${e}.$suffix
  fi
  if [ ! -f  $file ]; then
    echo Missing: $file
  fi
done
