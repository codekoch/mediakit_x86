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


#### set new mediakit background image for all users 
sudo cp logo.jpg /usr/share/pixmaps/
sudo chmod 755 /usr/share/pixmaps/logo.jpg
sudo echo '#!/bin/bash' > /usr/bin/mkLoginScript.sh
sudo echo 'xfconf-query --channel xfce4-desktop --list | grep last-image | while read path; do' >> /usr/bin/mkLoginScript.sh
sudo echo '    xfconf-query --channel xfce4-desktop --property $path --set /usr/share/pixmaps/logo.jpg' >> /usr/bin/mkLoginScript.sh
sudo echo 'done' >> /usr/bin/mkLoginScript.sh
sudo chmod 755 /usr/bin/mkLoginScript.sh



#### add user mk
echo "->adding user mk..." 
sudo adduser mk << EOF 
mediakit
mediakit
mediakit




Y
EOF

#### build autostart for mkLoginScript.sh
mkdir /home/mk/.config/autostart
touch /home/mk/.config/autostart/loginscript.desktop
echo "[Desktop Entry]" > /home/mk/.config/autostart/loginscript.desktop
echo "Name=setMediakitBackground.sh" >> /home/mk/.config/autostart/loginscript.desktop
echo "Exec=/usr/bin/mkLoginScript.sh">> /home/mk/.config/autostart/loginscript.desktop
echo "Type=application ">> /home/mk/.config/autostart/loginscript.desktop
echo "Terminal=true">> /home/mk/.config/autostart/loginscript.desktop
chmod 755 /home/mk/.config/autostart/loginscript.desktop

#### set group rights
usermod -a -G adm,dialout,fax,cdrom,floppy,tape,dip,video,plugdev mk

#### set selfhealing home of user mk
sudo cp scripts/resethomedir.sh /etc/init.d/
chmod 777 /etc/init.d/resethomedir.sh
sudo update-rc.d resethomedir.sh defaults
sudo /etc/init.d/resethomedir.sh save


#### set autologin of user mk
sudo mkdir /etc/lightdm/lightdm.conf.d//
sudo echo '[Seat:*]' > /etc/lightdm/lightdm.conf.d/60-autologin.conf
sudo echo 'autologin-user=mk' >> /etc/lightdm/lightdm.conf.d/60-autologin.conf
sudo echo 'autologin-user-timeout=0' >> /etc/lightdm/lightdm.conf.d/60-autologin.conf

#### 
yellow_msg "->DONE!"

