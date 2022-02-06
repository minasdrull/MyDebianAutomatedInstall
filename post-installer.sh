#!/bin/bash

printf "Hello, I'm %s.\n" $USER > /root/config.log

###########################################
################# Network #################
###########################################

printf "Configuring wpa_supplicant\n" >> /root/config.log

WIFI_SSID=$(echo "NussPalast")
echo "${WIFI_SSID}" >> /root/config.log

WIFI_PASSPHRASE=$(echo "LuemmelLuemmel83..")
echo "${WIFI_PASSPHRASE}" >> /root/config.log

WIFI_PSK=$(wpa_passphrase 'NussPalast' 'LuemmelLuemmel83..' | grep psk= | sed -n '2 p')
echo "${WIFI_PSK}" >> /root/config.log

cat > /etc/wpa_supplicant/wpa_supplicant.conf <<EOF
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=DE

network={
	priority=100
	scan_ssid=1
	proto=WPA2
	pairwise=CCMP
	group=CCMP
  #eap=TLS
  key_mgmt=WPA-PSK
  ssid=$WIFI_SSID
  $WIFI_PSK
}
EOF

DEFAULT_WIFI_INTERFACE=$(ip route | grep default | grep -oE '\bw\S*')
echo "${DEFAULT_WIFI_INTERFACE}" >> /root/config.log

mv /etc/network/interfaces /etc/network/interfaces.bk
cat > /etc/network/interfaces <<EOF
auto lo
iface lo inet loopback

auto $DEFAULT_WIFI_INTERFACE
allow-hotplug $DEFAULT_WIFI_INTERFACE
iface $DEFAULT_WIFI_INTERFACE inet dhcp
      wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
EOF

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
