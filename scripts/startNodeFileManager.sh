#!/bin/bash
IP=`/sbin/ifconfig | grep -i "inet " | awk '{print $2}' | head -1`
qrencode -s 10 -o serverQRCode.png "http://$IP:8080"
mkdir ~/Uploads
thunar ~/Uploads &
sleep 1
feh serverQRCode.png &
node-file-manager -p 8080 -d ~/Uploads/
