#!/bin/bash

mkdir -p hls

while true
do
  echo "playlist çekiliyor..."

  curl -s http://akrepyayin.site.je/playlist.json -o playlist.json

  rm -f list.txt

  jq -r '.playlist[] | "file \(. )"' playlist.json > list.txt

  ffmpeg -re -f concat -safe 0 -stream_loop -1 -i list.txt \
  -c:v libx264 -preset veryfast -b:v 1000k \
  -c:a aac -b:a 128k \
  -f hls \
  -hls_time 4 \
  -hls_list_size 6 \
  -hls_flags delete_segments+append_list \
  hls/stream.m3u8

done
