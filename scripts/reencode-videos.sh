#!/usr/bin/env bash

for f in *.mp4; do ffmpeg -i "$f" -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus "${f%.*}.webm" && ffmpeg -i "$f" -c:v libx264 -pix_fmt yuv420p -c:a aac -movflags +faststart "fixed_${f%.*}.mp4"; done
