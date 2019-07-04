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
sudo echo 'autologin-user=mk' >> /etc/lightdm/lightdm.conf.d/90-autologin.conf
sudo echo 'autologin-user-timeout=0' >> /etc/lightdm/lightdm.conf.d/90-autologin.conf

#### 
# Aufruf des cleanup-script nach dem Booten, damit 
# keine untergeschobenen Dateien überdauern.
# Aufruf des cleanup-script nach dem Login bzw. Logout
#for i in PostSession PostLogin; do
#  backup /etc/gdm/$i/Default
#cat <<-EOFC >/etc/gdm/$i/Default
#	#!/bin/sh

#	test "\$USER" = "mk" && /usr/local/bin/cleanup.sh \$0
#EOFC
#  # oben erzeugte Script die richtigen Rechte zuweisen
#  chmod 755 /etc/gdm/$i/Default
#done


backup /etc/rc.local
cat <<-EOFD >/etc/rc.local
	#!/bin/sh

	/usr/local/bin/cleanup.sh \$0
EOFD

# cleanup-script erzeugen, welches ...
#   1. .keinpasswort_rw reinigt und 
#   2. das virtuelles Windows unveränderbar macht.
backup /usr/local/bin/cleanup.sh
cat <<-\$EOFE >/usr/local/bin/cleanup.sh
	#!/bin/sh

	# cleanup-script soll nur weiterlaufen, wenn
	# keinpasswort durch aufs geschützt wird.
	immutable=`mount -l -t aufs |grep 'none on /home/mk type aufs (rw,br:/home/.mk_rw:/home/mk)'`
	test -n "$immutable" || exit 0;

	# Lösch-Funktion, welcher zusätzliche find-Argumente übergeben werden können
	loeschen (){
	  # Verwaltungs-Objekte von aufs
	  no_aufs="! -name .wh..wh.aufs ! -name .wh..wh.orph ! -name .wh..wh.plnk"
	  # Zusätliches find-Argument speichern
	  zusatz="$1"
	  # Wird dieses Script als root ausgeführt, kann das folgende "rm -rf" sehr gefährlich werden --
	  # insbesondere zu Testzwecken auf einem normalen Arbeitsrechner. Mit der folgenden Kombination
	  # ist sichergestellt, dass wirklich nur der Inhalt von .keinpasswort_rw gelöscht wird.
	  cd /home/.mk_rw && find . -maxdepth 1 -mindepth 1 $no_aufs $zusatz -print0|xargs -0 rm -rf
	}

	case "$1" in
	  /etc/gdm/PostLogin/Default)
	    # Inhalt von .keinpasswort_rw beim Login löschen. Das .pulse-Verzeichnis muss stehen
	    # bleiben, da es sonst bei direkter Neuanmeldung zu Sound-Problemen kommen kann.
	    loeschen "! -name .pulse"
	    ;;
	  /etc/gdm/PostSession/Default)
	    # Inhalt von .keinpasswort_rw beim Logout verzögert löschen.
	    (sleep 3; loeschen "! -name .pulse") &
	    ;;
	  /etc/rc.local)
	    # Inhalt von .keinpasswort_rw beim Booten löschen, damit keine untergeschobenen
	    # Dateien einen Neustart überdauern. Sowohl das .pulse-Verzeichnis als auch
	    # Shell-Logins könnten sonst als Schwachstelle ausgenutzt werden.
	    loeschen
	    ;;
	  *)
	    # Nichts tun
	    ;;
	esac
	exit 0
$EOFE

# oben erzeugte Script die richtigen Rechte zuweisen
chmod 755 /usr/local/bin/cleanup.sh

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

