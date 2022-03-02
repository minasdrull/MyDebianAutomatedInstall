#!/bin/bash

#systemd-machine-id-setup
cp /root/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
cp /root/interfaces /etc/network/interfaces
#
#export DEBIAN_FRONTEND=noninteractive
#apt install -q -y keyboard-configuration console-setup
#apt install keyboard-configuration console-setup
#debconf-set-selections < /root/MyDebianAutomatedInstall/selections.conf
#dpkg-reconfigure keyboard-configuration -f noninteractive
#if [ -f /etc/machine-id ]; then
#systemctl --force reboot
#fi