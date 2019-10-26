#!/bin/bash
#### get release Data
#. /etc/lsb-release

function backup () {
  test -s $1 && cp $1 $1-`date +%Y%m%d-%H%M%S`-`stat -c '%G-%U-%a' $1`
}

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



yellow_msg "->Set password for current user on mediakit (usually 'mediakitadmin'):"
passwd

backgrounds=`ls /usr/share/desktop-base/active-theme/wallpaper/contents/images/*.svg`
for file in $backgrounds
do
sudo cp ./logo.svg $file
sudo chmod 755 $file
done




#### add user mk
echo "->adding user mk..." 
sudo adduser mk << EOF 
mediakit
mediakit
mediakit




Y
EOF
echo " "
usermod -a -G adm,dialout,fax,cdrom,floppy,tape,dip,video,plugdev mk
sudo cp scripts/resethomedir.sh /etc/init.d/
chmod 777 /etc/init.d/resethomedir.sh
sudo update-rc.d resethomedir.sh defaults
sudo /etc/init.d/resethomedir.sh save

#sudo apt-get install xubuntu-desktop

#sudo cp logo.jpg /usr/share/wallpapers
#sudo chmod 777 /usr/share/wallpapers/logo.jpg

#backgrounds=`ls /usr/share/xfce4/backdrops/*.jpg`
#for file in $backgrounds
#do
#sudo cp ./logo.jpg $file
#done
#backgrounds=`ls /usr/share/xfce4/backdrops/*.png`
#for file in $backgrounds
#do
#sudo cp ./logo.png $file
#done

#backgrounds=`ls /usr/share/desktop-base/active-theme/wallpaper/contents/images/*.svg`
#for file in $backgrounds
#do
#sudo cp ./logo.svg $file
#sudo chmod 755 $file
#done

#sudo xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s "/usr/share/wallpapers/logo.jpg"
sudo mkdir /etc/lightdm/lightdm.conf.d//
sudo echo '[Seat:*]' > /etc/lightdm/lightdm.conf.d/60-autologin.conf
sudo echo 'autologin-user=mk' >> /etc/lightdm/lightdm.conf.d/60-autologin.conf
sudo echo 'autologin-user-timeout=0' >> /etc/lightdm/lightdm.conf.d/60-autologin.conf
yellow_msg "->DONE!"
#sudo cp ./themes/* /usr/share/plymouth/themes/xubuntu-logo/
#sudo update-initramfs -u

#exit

