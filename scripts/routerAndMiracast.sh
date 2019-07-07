#!/bin/bash
sudo apt-get install check
sudo apt-get install libgstreamer1.0-0
sudo apt-get install gstreamer1.0-tools
sudo apt-get install build-essential
sudo apt-get install ubuntu-restricted-extras
sudo apt-get install pkg-config
sudo apt-get install libglib2.0-dev 
sudo apt-get install libreadline-dev
sudo apt-get install libudev-dev
sudo apt-get install libsystemd-dev
sudo apt-get install libusb-dev
sudo apt-get install cmake 
cp ./miraclecast/ res/org.freedesktop.miracle.conf to /etc/dbus-1/system.d/
cd ./miracalecast
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
make install

