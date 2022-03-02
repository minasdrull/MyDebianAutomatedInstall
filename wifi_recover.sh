# inspired by https://www.andreagrandi.it/tag/debian.html
# executed by crontab every 5 min > entry */5 * * * * /root/wifi_recover.sh
# use https://crontab.guru

#echo "`date` Sript executed" >> wifi_log.txt

DEFAULT_ROUTE=$(ip route | grep default | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
echo "${DEFAULT_ROUTE}"

#DEFAULT_ROUTE='192.168.178.1'
ping -q -c1 $DEFAULT_ROUTE >> /dev/null
if [ "$?" -ne "0" ]; then
echo "`date` WIFI DOWN" >> wifi_log.txt
systemctl restart networking.service
sleep 5s
#        ifdown wlan0
#        rmmod 8192cu
#        modprobe 8192cu
#        ifup wlan0
echo "`date` WIFI UP" >> wifi_log.txt
fi