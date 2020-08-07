#!/bin/bash -e

DIR=

if [ -f "/var/www/html/youtube-ads-list.txt" ]
then
	EXIST_LIST=$(cat /var/www/html/youtube-ads-list.txt)
fi

# update dns list
NEW_LIST="$(python ${DIR}/get_yt_dns.py | grep ^r | awk '{print $1}' | sort -nr | uniq)"
NEW_LIST="${NEW_LIST} $(grep r*.googlevideo.com /var/log/pihole.log | awk '{print $6}'| grep ^r | sort -nr | uniq)"
NEW_LIST="${NEW_LIST} $(echo "gstaticadssl.l.google.com")"

FINAL_LIST="$(echo ${EXIST_LIST} ${NEW_LIST} | sort -nr | uniq)"

echo "" > /var/www/html/youtube-ads-list.txt

for ADDR in ${FINAL_LIST} 
do
	echo "${ADDR}" >> /var/www/html/youtube-ads-list.txt
done

# update gravity
pihole -g