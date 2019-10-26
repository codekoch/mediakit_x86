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

version=``
getVersion
if [ -z $version ]; then
  red_msg "This install script works only on debian like systems (Debian, XUbuntu, Ubuntu etc.)!"  
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

######## install update ability
#yellow_msg "-install update ability..."

######## install startup and mediakit scripts
#yellow_msg "-install startup and mediakit scripts..."
#scripts/mediakitScripts.sh

######## install server ability
#yellow_msg "-install server functions..."
#scripts/server.sh

######## install some useful programs
yellow_msg "-install some useful programs"
scripts/programs.sh
#### openboard
#### python
#### geogebra
#### pinta
#### java
#### gparted
#### ballerburg
#### simplescreenrecorder
#### youtube-dl
exit
######## copying sudoers file to give all necessary rights to user mk
yellow_msg "-copying sudoers file to give all necessary rights to user mk"
sudo cp sources/etc/sudoers /etc/
#### create a copy of /home/mk which is used by restoreMkProfile.sh
yellow_msg "-create copy of /home/mk"
sudo chown -R mk:mk /home/mk
sudo chmod -R 755 /home/mk
sudo mkdir /home/pi/backup
sudo cp -R /home/mk /home/pi/backup/

#### set Version
sudo  sed -i 's/my_image = Image.Text(\"v.*$/my_image = Image\.Text(\"'$version' Copyright Olaf Koch \& Simon Zander 2018\"\, 1\, 1\, 1)\;/g' /usr/share/plymouth/themes/pix/pix.script

green_msg "Done! A restart is necessary!"
green_msg "sudo shutdown -r now" 
blue_msg "(its recommended to make a copy of the current berryboot system including all data"
blue_msg "by this you can allways return to a fresh mediakit install ...)"
