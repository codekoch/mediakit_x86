#!/bin/bash
IP=`/sbin/ip route get 1 | awk '{print $7}' | head -1`
qrencode -s 10 -o serverQRCode.png "http://$IP:8080"
convert serverQRCode.png -fill black -gravity North -font FreeMono -pointsize 25 -draw "text 0,10 '"$IP":8080'" serverQRCode.png
mkdir ~/Uploads
thunar ~/Uploads &
sleep 1
feh serverQRCode.png &
node-file-manager -p 8080 -d ~/Uploads/
