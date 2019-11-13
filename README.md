# mediakit_x86 (still experimental)
## digitalisation of schools - simple, independent, reliable, economical 
![mediakit](http://mediakit.education/images/PenDisplay_Nuc2.jpg)

convert almost every x86 computer into a "mediakit" by starting a shellskript after a fresh debian install...
This is what you get:
- Selfhealing account (all changes done by user mk are deleted at startup)
- Many useful programs for schools (Openboard, Geogebra, Netbeans with Java support, python pip, Virtual-Box, VLC-Player etc.)
- Up- and Download Nodejs-Server
- Takeaway system (Export whole system on any external media by full configured <a href=https://www.linux-live.org/>Linux-Live-Kit</a>) 

see also: http://mediakit.education/x86.php or https://github.com/codekoch/mediakit_RaspberryPi
## Getting Started
- Install a new debian system (testet with <a href=https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current-live/amd64/iso-hybrid/>debian 10.1.0-amd64-xfce+nonfree.iso</a>)
- (optional) make your own changes to the fresh installed system
## Installing
- Install git
> sudo apt-get install git
- Clone this repository
> git clone https://github.com/codekoch/mediakit_x86
- Start the install shellscript as root 
> cd mediakit_x86

> su

> ./install.sh
- Take a coffee (Installation will take some time...)
- Restart to autologin into the new account
> ./sudo shutdown -r now
- Choose default panel when asked for
- Customize everything according to your needs
- Open a terminal and save the current account settings
> su

> sudo /etc/init.d/resethomedir.sh save
- Have fun with your new mediakit 
## Hints
- All changes done by user mk are deleted at startup
- If you want to keep some changes save the account settings again as described above in the last step of installation
- Use Node-File-Manager to start a server, which can be reached by any device in the same network. 
- To build a Takeaway System:
    - >su
    - >mount /dev/{yourdevice} /a
    - >/usr/bin/buildLinuxLive.sh
