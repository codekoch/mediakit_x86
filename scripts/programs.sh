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

######## get latest updates and upgrades 
sudo apt-get update
sudo apt-get -y upgrade

######## install needed basic programs
sudo apt -y install wget unzip
sudo apt-get install -y imagemagick
sudo apt-get install -y qrencode
sudo apt-get install -y flatpak
sudo apt-get install -y geogebra
sudo apt-get install -y youtube-dl
sudo apt-get install -y simplescreenrecorder
sudo apt-get install -y ballerburg
sudo apt-get install -y python-pip


#### Netbeans
wget https://www-us.apache.org/dist/incubator/netbeans/incubating-netbeans/incubating-11.0/incubating-netbeans-11.0-bin.zip 
unzip incubating-netbeans-11.0-bin.zip
sudo mv netbeans/ /opt/
echo 'export PATH="$PATH:/opt/netbeans/bin/"' >> /etc/bash.bashrc
echo '[Desktop Entry]' > /usr/share/applications/netbeans.desktop
echo 'Name=Netbeans IDE' >> /usr/share/applications/netbeans.desktop
echo 'Comment=Netbeans IDE' >> /usr/share/applications/netbeans.desktop
echo 'Type=Application' >> /usr/share/applications/netbeans.desktop
echo 'Encoding=UTF-8' >> /usr/share/applications/netbeans.desktop
echo 'Exec=/opt/netbeans/bin/netbeans' >> /usr/share/applications/netbeans.desktop
echo 'Icon=/opt/netbeans/nb/netbeans.png' >> /usr/share/applications/netbeans.desktop
echo 'Categories=GNOME;Application;Development;' >> /usr/share/applications/netbeans.desktop
echo 'Terminal=false' >> /usr/share/applications/netbeans.desktop
echo 'StartupNotify=true' >> /usr/share/applications/netbeans.desktop

#### VirtualBox
# Download and trust lucas' GPG key
wget -O - https://db.debian.org/fetchkey.cgi?fingerprint=FEDEC1CB337BCF509F43C2243914B532F4DFBE99 | apt-key add
# add the repository
echo 'deb https://people.debian.org/~lucas/virtualbox-buster/ ./' > /etc/apt/sources.list.d/virtualbox-unofficial.list
# Update and install virtualbox
apt update
apt install -y virtualbox
# Start virtualbox manually (I'm not sure why this is needed)
systemctl start virtualbox

#### Openboard
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub ch.openboard.OpenBoard
sudo cp openboard.png /usr/share/pixmaps/
echo '[Desktop Entry]' > /usr/share/applications/openboard.desktop
echo 'Name=OpenBoard' >> /usr/share/applications/openboard.desktop
echo 'Comment=OpenBoard' >> /usr/share/applications/openboard.desktop
echo 'Type=Application' >> /usr/share/applications/openboard.desktop
echo 'Encoding=UTF-8' >> /usr/share/applications/openboard.desktop
echo 'Exec=/usr/bin/flatpak run ch.openboard.OpenBoard' >> /usr/share/applications/openboard.desktop
echo 'Icon=/usr/share/pixmaps/openboard.png' >> /usr/share/applications/openboard.desktop
echo 'Categories=GNOME;Application;Education;' >> /usr/share/applications/openboard.desktop
echo 'Terminal=false' >> /usr/share/applications/openboard.desktop
echo 'StartupNotify=true' >> /usr/share/applications/openboard.desktop


#### Linux Live Kit
sudo apt-get install -y squashfs-tools
sudo apt-get install -y genisoimage 
sudo apt-get install -y zip 
sudo apt-get install -y aufs-dkms 
sudo apt-get install -y dkms
sudo mkdir /a
git clone https://github.com/Tomas-M/linux-live
sudo  sed -i 's/LIVEKITNAME="linux"/LIVEKITNAME="mediakit"/g' linux-live/config
sudo  sed -i 's|LIVEKITDATA=/tmp|LIVEKITDATA=/a|/g' linux-live/config

#### dvd support
#sudo apt-get install -y libdvd-pkg libdvdnav4
#sudo dpkg-reconfigure libdvd-pkg

#### instal guacamole clientless remote desktop
#sudo apt-get purge -y realvnc*
#sudo apt-get install -y libcairo2-dev
#sudo apt-get install -y libjpeg62-turbo-dev
#sudo apt-get install -y libpng12-dev
#sudo apt-get install -y libossp-uuid-dev
#sudo apt-get install -y libavcodec-dev libavutil-dev libswscale-dev
#sudo apt-get install -y libpango1.0-dev
#sudo apt-get install -y libssh2-1-dev
#sudo apt-get install -y libtelnet-dev
#sudo apt-get install -y libvncserver-dev
#sudo apt-get install -y libpulse-dev
#sudo apt-get install -y libssl-dev
#sudo apt-get install -y libvorbis-dev
#sudo apt-get install -y libwebp-dev
#sudo apt-get install -y jetty9
#sudo apt-get install -y x11vnc

#tar xzf guacamole-server-0.9.14.tar.gz
#cd guacamole-server-0.9.14
#./configure --with-init-dir=/etc/init.d
#make
#sudo make install
#sudo update-rc.d guacd defaults
#sudo ldconfig
#cd ..

#sudo cp -R sources/etc/guacamole /etc/
#sudo chmod -R 755 /etc/guacamole
#sudo cp sources/home/mk/.config/autostart/x11vnc.desktop /home/mk/.config/autostart/
#sudo chmod 777 /home/mk/.config/autostart/x11vnc.desktop
#sudo cp sources/var/lib/jetty9/webapps/guacamole.war /var/lib/jetty9/webapps/
#sudo cp sources/var/lib/jetty9/webapps/root/index.html /var/lib/jetty9/webapps/root/
