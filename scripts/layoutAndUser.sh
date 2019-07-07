#!/bin/bash
#### get release Data
. /etc/lsb-release

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

sudo apt-get install xubuntu-desktop

#sudo cp logo.jpg /usr/share/wallpapers
#sudo chmod 777 /usr/share/wallpapers/logo.jpg

backgrounds=`ls /usr/share/xfce4/backdrops/*.jpg`
for file in $backgrounds
do
sudo cp ./logo.jpg $file
done
backgrounds=`ls /usr/share/xfce4/backdrops/*.png`
for file in $backgrounds
do
sudo cp ./logo.png $file
done

backgrounds=`ls /usr/share/xfce4/backdrops/*.svg`
for file in $backgrounds
do
sudo cp ./logo.svg $file
done



#sudo xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s "/usr/share/wallpapers/logo.jpg"

sudo echo 'autologin-user=mk' > /etc/lightdm/lightdm.conf.d/60-autologin.conf
sudo echo 'autologin-user-timeout=0' >> /etc/lightdm/lightdm.conf.d/60-autologin.conf
yellow_msg "->DONE!"


exit
#### setting up mediakit layout
yellow_msg "->copying layout files..."
#### menu launch button
sudo cp sources/usr/share/raspberrypi-artwork/launch.png /usr/share/raspberrypi-artwork/ 

#### splashscreen at startup
sudo cp sources/usr/share/plymouth/themes/pix/splash.png /usr/share/plymouth/themes/pix/ 

#### show mediakit version on splashscreen at startup
sudo cp sources/usr/share/plymouth/themes/pix/pix.script /usr/share/plymouth/themes/pix/

#### desktop background (mediakit logo)
sudo cp sources/usr/share/rpd-wallpaper/logo.jpg /usr/share/rpd-wallpaper/

#### desktop background (loading mediakit logo)
sudo cp sources/usr/share/rpd-wallpaper/loading.jpg /usr/share/rpd-wallpaper/


#### all desktop settings and icon arrangements
sudo cp -R sources/home/mk /home/

#### give directories to user mk
sudo chown -R mk:mk /home/mk

#### copying all mediakit desktop icons
sudo cp sources/usr/share/pixmaps/* /usr/share/pixmaps/

