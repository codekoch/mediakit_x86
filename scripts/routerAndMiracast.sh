#!/bin/bash
sudo apt-get install check
sudo apt-get install libgstreamer1.0-0
sudo apt-get install gstreamer1.0-tools
sudo apt-get install cmake 
cp ./miraclecast/ res/org.freedesktop.miracle.conf to /etc/dbus-1/system.d/
