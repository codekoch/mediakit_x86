#!/bin/bash
sudo apt-get install -y check
sudo apt-get install -y libgstreamer1.0-0
sudo apt-get install -y gstreamer1.0-tools
sudo apt-get install -y build-essential
sudo apt-get install -y ubuntu-restricted-extras
sudo apt-get install -y pkg-config
sudo apt-get install -y libglib2.0-dev 
sudo apt-get install -y libreadline-dev
sudo apt-get install -y libudev-dev
sudo apt-get install -y libsystemd-dev
sudo apt-get install -y libusb-dev
sudo apt-get install -y cmake 
sudo cp ./miraclecast/res/org.freedesktop.miracle.conf to /etc/dbus-1/system.d/
cd ./miraclecast
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
make install

