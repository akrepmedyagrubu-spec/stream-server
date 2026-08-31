#!/bin/bash

mkdir -p hls

while true
do
  echo "scene alınıyor..."

  curl -s https://github.com/akrepmedyagrubu-spec/yayin-panel/blob/main/scene.json -o scene.json

  TEXT=$(jq -r '.elements[]?.text' scene.json 2>/dev/null | head -n1)

  ffmpeg -re -stream_loop -1 -i video.mp4 \
  -vf "drawtext=text='${TEXT:-YAYIN}':x=20:y=20:fontsize=30:fontcolor=white" \
  -c:v libx264 -preset veryfast -b:v 1000k \
  -c:a aac -b:a 128k \
  -f hls \
  -hls_time 4 \
  -hls_list_size 6 \
  -hls_flags delete_segments+append_list \
  hls/stream.m3u8

done
