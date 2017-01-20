#!/bin/bash
cd "$(dirname "$0")"

TOKEN=$(cat token)

message=$(cat)

if [ -n "$message" ]; then 
  curl -s \
    --data-urlencode "text=$message" \
    --data-urlencode "username=Emojiconsan" \
    --data-urlencode "token=$TOKEN" \
    --data-urlencode "channel=#meta" \
    --data-urlencode "icon_emoji=:yes_sir:" \
    https://hal9k.slack.com/api/chat.postMessage &>/dev/null
fi
