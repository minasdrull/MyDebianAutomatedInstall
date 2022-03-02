#!/bin/bash

#systemd-machine-id-setup
cp /root/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
cp /root/interfaces /etc/network/interfaces
#if [ -f /etc/machine-id ]; then
#systemctl --force reboot
#fi