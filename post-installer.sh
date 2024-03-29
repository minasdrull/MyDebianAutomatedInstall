#!/bin/bash

printf "Hello, I'm %s.\n" $USER > /root/config.log

# Small Change Test

###########################################
################# Network #################
###########################################

printf "Configuring wpa_supplicant\n" >> /root/config.log

printf "Identify standard interface\n" >> /root/config.log
printf "WIFI_INTERFACE=" >> /root/config.log
WIFI_INTERFACE=$(ip route | grep default | grep -oE '\bw\S*')
echo "${WIFI_INTERFACE}" >> /root/config.log

printf "WIFI_SSID5GHZ=" >> /root/config.log
WIFI_SSID5GHZ=$(echo "NussPalastCloud5G")
echo "${WIFI_SSID5GHZ}" >> /root/config.log

printf "WIFI_PASSPHRASE5GHZ=" >> /root/config.log
WIFI_PASSPHRASE5GHZ=$(echo "LuemmelLuemmel83..")
echo "${WIFI_PASSPHRASE5GHZ}" >> /root/config.log

printf "WIFI_PSK5GHZ=" >> /root/config.log
WIFI_PSK5GHZ=$(wpa_passphrase $WIFI_SSID5GHZ $WIFI_PASSPHRASE5GHZ | grep 'psk=' | sed -n '2 p' | sed -e s/psk=//g | tr -d " \t\n\r")
echo "${WIFI_PSK5GHZ}" >> /root/config.log

printf "WIFI_SSID2GHZ=" >> /root/config.log
WIFI_SSID2GHZ=$(echo "NussPalastCloud2G")
echo "${WIFI_SSID2GHZ}" >> /root/config.log

printf "WIFI_PASSPHRASE2GHZ=" >> /root/config.log
WIFI_PASSPHRASE2GHZ=$(echo "LuemmelLuemmel83..")
echo "${WIFI_PASSPHRASE2GHZ}" >> /root/config.log

printf "WIFI_PSK2GHZ=" >> /root/config.log
WIFI_PSK2GHZ=$(wpa_passphrase $WIFI_SSID2GHZ $WIFI_PASSPHRASE2GHZ | grep 'psk=' | sed -n '2 p' | sed -e s/psk=//g | tr -d " \t\n\r")
echo "${WIFI_PSK2GHZ}" >> /root/config.log

touch /root/wpa_supplicant.conf
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" >> /root/wpa_supplicant.conf
echo "update_config=1" >> /root/wpa_supplicant.conf
echo "country=DE" >> /root/wpa_supplicant.conf
echo "" >> /root/wpa_supplicant.conf
echo "network={" >> /root/wpa_supplicant.conf
echo "	priority=100" >> /root/wpa_supplicant.conf
echo "	scan_ssid=1" >> /root/wpa_supplicant.conf
echo "	proto=WPA2" >> /root/wpa_supplicant.conf
echo "	pairwise=CCMP" >> /root/wpa_supplicant.conf
echo "	group=CCMP" >> /root/wpa_supplicant.conf
echo "	#eap=TLS" >> /root/wpa_supplicant.conf
echo "	key_mgmt=WPA-PSK" >> /root/wpa_supplicant.conf
#echo "	ssid=\"$WIFI_SSID5GHZ\"" >> /root/wpa_supplicant.conf
echo "	ssid=\"${WIFI_SSID5GHZ}\"" >> /root/wpa_supplicant.conf
#echo "	psk=$WIFI_PSK5GHZ" >> /root/wpa_supplicant.conf
echo "	psk=${WIFI_PSK5GHZ}" >> /root/wpa_supplicant.conf
echo "}" >> /root/wpa_supplicant.conf
echo "network={" >> /root/wpa_supplicant.conf
echo "	priority=90" >> /root/wpa_supplicant.conf
echo "	scan_ssid=1" >> /root/wpa_supplicant.conf
echo "	proto=WPA2" >> /root/wpa_supplicant.conf
echo "	pairwise=CCMP" >> /root/wpa_supplicant.conf
echo "	group=CCMP" >> /root/wpa_supplicant.conf
echo "	#eap=TLS" >> /root/wpa_supplicant.conf
echo "	key_mgmt=WPA-PSK" >> /root/wpa_supplicant.conf
#echo "	ssid=\"$WIFI_SSID2GHZ\"" >> /root/wpa_supplicant.conf
echo "	ssid=\"${WIFI_SSID2GHZ}\"" >> /root/wpa_supplicant.conf
#echo "	psk=$WIFI_PSK2GHZ" >> /root/wpa_supplicant.conf
echo "	psk=${WIFI_PSK2GHZ}" >> /root/wpa_supplicant.conf
echo "}" >> /root/wpa_supplicant.conf

cp /etc/network/interfaces /root/interfaces

sed '/'"$WIFI_INTERFACE"'/ ,/^$/d' -i /root/interfaces
echo "# The primary wifi network interface" >> /root/interfaces
echo "auto $WIFI_INTERFACE" >> /root/interfaces
echo "allow-hotplug $WIFI_INTERFACE" >> /root/interfaces
echo "iface $WIFI_INTERFACE inet dhcp" >> /root/interfaces
echo "	wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" >> /root/interfaces

#mv /etc/network/interfaces /etc/network/interfaces.bk
#cp /root/wpa_supplicant.conf /target/etc/wpa_supplicant/wpa_supplicant.conf
#cp /root/interfaces /target/etc/network/interfaces

###########################################
################ Variables ################
###########################################
#HOSTNAME='working'
#USERNAME='danielhand'
#IPADDRESS='10.0.5.5'
#NETMASK='255.255.240.0'
#GATEWAY='10.0.0.1'
#NAMESERVER='10.0.1.3 10.0.1.4'
#PACKAGES='htop nano sudo python-minimal vim rsync dnsutils less ntp'

###########################################
################# Updates #################
###########################################
#apt update && apt upgrade -y
#apt -y dist-upgrade

###########################################
################## Apps ###################
###########################################
#apt-get install $PACKAGES -y

###########################################
################## SSH ####################
###########################################

# Add SSH Key for default user
#mkdir /home/$USERNAME/.ssh/
#cat > /home/$USERNAME/.ssh/authorized_keys <<EOF
#SSH-KEY HERE
#EOF
#chmod 700 /home/$USERNAME/.ssh
#chmod 600 /home/$USERNAME/.ssh/authorized_keys
#chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
# Add SSH Key for root user
#mkdir /root/.ssh/
#cat > /root/.ssh/authorized_keys <<EOF
#SSH-KEY HERE
#EOF
#chmod 700 /root/.ssh
#chmod 600 /root/.ssh/authorized_keys
#chown -R root:root /root/.ssh

# Edit /etc/ssh/sshd_config
#sed -i '/^PermitRootLogin/s/prohibit-password/yes/' /etc/ssh/sshd_config
#sed -i -e 's/#PasswordAuthentication/PasswordAuthentication/g' /etc/ssh/sshd_config

###########################################
############# Change Hostname #############
###########################################
#hostn=$(cat /etc/hostname)
#sudo sed -i "s/$hostn/$HOSTNAME/g" /etc/hosts
#sudo sed -i "s/$hostn/$HOSTNAME/g" /etc/hostname
#sudo reboot
