#!/usr/bin/env bash

for f in *.gif; do ffmpeg -i "$f" -vf "fps=24,scale=1080:-1:flags=lanczos,split[s0][s1];[s0]palettegen=stats_mode=full[p];[s1][p]paletteuse=dither=sierra2_4a" "hd_${f}"; done


# # High-Quality 1080p MP4 that looks/loops like a GIF
# for f in *.gif; do ffmpeg -i "$f" -c:v libx264 -crf 18 -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "hd_video_${f%.gif}.mp4"; done
