#!/bin/bash
function red_msg() {
echo -e "\\033[31;1m${@}\033[0m"
}
 
function green_msg() {
echo -e "\\033[32;1m${@}\033[0m"
}
function yellow_msg() {
echo -e "\\033[33;1m${@}\033[0m"
}
 
function blue_msg() {
echo -e "\\033[34;1m${@}\033[0m"
}

function getVersion() {
version=`uname -a | grep -i "Ubuntu"`
if  [ -n "$version" ]; then
  version="ubuntu"
  return
fi
version=`uname -a | grep -i "Debian"`
if [ -n "$version" ]; then
  version="debian"
  return
fi
}

version=`debian`
getVersion
if [ -z $version ]; then
  red_msg "This install script works only on debian systems!"  
  exit
fi 

yellow_msg "Installing mediakit_x86 on $version system..."



green_msg "install and configure everything..."

######## install mediakit layout and user
yellow_msg "-install mediakit layout and mediakit user..."
sudo scripts/layoutAndUser.sh

######## install router and miracast ability
#yellow_msg "-install router and miracast ability..."
#scripts/routerAndMiracast.sh

######## install startup and mediakit scripts
#yellow_msg "-install startup and mediakit scripts..."
#scripts/mediakitScripts.sh

######## install server ability
#yellow_msg "-install server functions..."
#scripts/server.sh

######## install some useful programs
yellow_msg "-install some useful programs"
scripts/programs.sh

green_msg "Done! A restart is necessary!"
green_msg "sudo shutdown -r now" 
