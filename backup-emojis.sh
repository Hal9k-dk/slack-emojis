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
    sed -e 's/^alias:\(.*\)/\1/' <<< $url > $file
  else
    #url
    suffix=${url##*.}
    file=$BACKUPFOLDER/${e}.$suffix
    if [ -f $file ]; then
      curl -s -o $file.tmp $url
      if $(cmp --silent $file.tmp $file); then
	rm $file.tmp
      else
        mv $file $file.$(date +%s)
        mv $file.tmp $file
      fi
    else
      curl -s -o $file $url
    fi
  fi
done
