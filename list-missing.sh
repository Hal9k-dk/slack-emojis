#!/bin/bash
cd "$(dirname "$0")"

TOKEN=$(cat token)
BACKUPFOLDER=emojis
mkdir -p $BACKUPFOLDER

emojiList=$(curl -s "https://slack.com/api/emoji.list?token=$TOKEN" | jq '.emoji')

for key in $(ls $BACKUPFOLDER/* | xargs -n 1 basename | cut -f 1 -d '.' | sort -u) ; do
  if [ $(jq -r ".[\"$key\"]" <<< $emojiList) = null ]; then
    echo "Emoji deleted: $key -> :$key:"
  fi
done
