sudo apt-get update
sudo rpi-update
sudo apt-get dist-upgrade


#Install apps
sudo apt-get install  samba=2:3.6.6-6+deb7u5 \
                      samba-common-bin=2:3.6.6-6+deb7u5 \
                      nginx=1.2.1-2.2+wheezy3 \
                      libxml2-dev=2.8.0+dfsg1-7+wheezy3  \
                      mysql-server=5.5.41-0+wheezy1 \
                      mysql-client=5.5.41-0+wheezy1 \
                      php5=5.4.36-0+deb7u3 \
                      php5-common=5.4.36-0+deb7u3 \
                      php5-cgi=5.4.36-0+deb7u3 \
                      php5-mysql=5.4.36-0+deb7u3 \
                      php5-fpm=5.4.36-0+deb7u3 \
                      php5-mcrypt=5.4.36-0+deb7u3 \
                      php5-gd=5.4.36-0+deb7u3 \
                      ffmpeg=6:0.8.16-1+rpi1 \
                      zip=3.0-6 \
                      imagemagick=8:6.7.7.10-5+deb7u3 \
                      hostapd=1:1.0-3+deb7u1 \
                      udhcpd=1:1.20.0-7


#Update hostname
sudo cp /etc/hosts /etc/hosts.bak
sudo cp ./hostfiles/hosts /etc/hosts
sudo cp /etc/hostname /etc/hostname.bak
sudo cp ./hostfiles/hostname /etc/hostname
sudo /etc/init.d/hostname.sh


#Samba config
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
sudo cp ./samba/smb.conf /etc/samba/smb.conf
sudo cp /etc/samba/dhcp.conf /etc/samba/dhcp.conf.bak
#sudo cp ./samba/dhcp.conf /etc/samba/dhcp.conf #This file no longer exists in the repo?
sudo /etc/samba/gdbcommands /etc/samba/gdbcommands.bak #Doesn't exist by default, but try to copy it anyways.
sudo cp ./samba/gdbcommands /etc/samba/gdbcommands


#Nginx config
sudo cp /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default.bak
sudo cp ./nginx/sites-enabled/default /etc/nginx/sites-enabled/default

#Install base www files
sudo cp -r ./www/* /usr/share/nginx/www/

#Configure _h5ai
sudo mkdir /usr/share/nginx/www/_h5ai
sudo chmod 777 -R /usr/share/nginx/www/_h5ai/cache/

#Load the nginx config files
#(after this you should be able to visit the web server and see content)
sudo nginx -s reload

#Sphider
sudo chmod 777 -R /usr/share/nginx/www/rsphider
echo "CREATE DATABASE sphider_plus;" |  mysql -u root -prachellovespie
sudo chmod 777 /usr/share/nginx/www/rsphider/admin/log


#Downlaod all the content
sudo chmod +x ./scripts/encontent.sh
./scripts/encontent.sh

#Create wifi hotspot
sudo cp /etc/udhcpd.conf /etc/udhcpd.conf.bak
sudo cp ./hotspot/udhcpd.conf /etc/udhcpd.conf

sudo cp /etc/default/udhcpd /etc/default/udhcpd.bak
sudo cp ./hotspot/udhcpd /etc/default/udhcpd

sudo cp /etc/default/hostapd /etc/default/hostapd.bak
sudo cp ./hotspot/hostapd /etc/default/hostapd

sudo cp /etc/network/interfaces /etc/network/interfaces.bak
sudo cp ./hotspot/interfaces /etc/network/interfaces

sudo cp /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.bak
sudo cp ./hotspot/hostapd.conf /etc/hostapd/hostapd.conf

sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sudo cp ./hotspot/sysctl.conf /etc/sysctl.conf
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
sudo ifconfig wlan0 10.10.10.10
sudo service hostapd start
sudo service udhcpd start
sudo update-rc.d hostapd enable
sudo update-rc.d udhcpd enable

##redo wifi enable for good measure
#sudo ifconfig wlan0 10.10.10.10
#sudo service hostapd start
#sudo service udhcpd start
#sudo update-rc.d hostapd enable
#sudo update-rc.d udhcpd enable


#webshutdown
sudo chmod +x ./scripts/ifupdown.sh
./scripts/ifupdown.sh


# Don't think this is needed...might be overwriting the latest drivers...
##put realtek drivers in place if needed
#sudo cp ./drivers/hostapd_RTL8188CUS /home/pi/hostapd_RTL
#sudo cp ./drivers/realtek.sh /home/pi/Desktop/realtek.sh
#sudo cp ./drivers/hostapd_realtek.conf /home/pi/hostapd_realtek.conf
#sudo chmod +x /home/pi/Desktop/realtek.sh