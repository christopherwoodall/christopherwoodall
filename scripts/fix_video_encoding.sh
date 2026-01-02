
for f in *.mp4; do ffmpeg -i "$f" -c:v libx264 -pix_fmt yuv420p -c:a aac -movflags +faststart "fixed_${f}"; done
