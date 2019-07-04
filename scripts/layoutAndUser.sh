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
usermod -a -G adm,dialout,fax,cdrom,floppy,tape,dip,video,plugdev,fuse mk

#### make directory including temporary changes
sudo install -d -o mk -g mk /home/.mk_rw
#### install aufs-layer on home directory
cp /etc/fstab /etc/fstab_old
echo "none /home/mk aufs br:/home/.mk_rw:/home/mk 0 0" >> /etc/fstab

#### xubuntu layout
sudo apt-get install xubuntu-desktop
#### autologin mk
sudo echo '[Seat:*]' > /etc/lightdm/lightdm.conf.d/90-autologin.conf
sudo echo 'autologin-user=Benutzername" >> /etc/lightdm/lightdm.conf.d/90-autologin.conf
sudo echo 'autologin-user-timeout=0' >> /etc/lightdm/lightdm.conf.d/90-autologin.conf
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

