#!/bin/bash
TOKEN=$(cat token)
BACKUPFOLDER=emojis
mkdir -p $BACKUPFOLDER

for f in $BACKUPFOLDER/*; do
  suffix=${f##*.}
  if [ $suffix = 'alias' ]; then
    echo alias
  else
    echo emoji
  fi
done
