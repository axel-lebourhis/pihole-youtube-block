#!/bin/bash -e

DIR=

echo "" > ./tmp_list.txt

if [ -f "/var/www/html/youtube-ads-list.txt" ]
then
	cat /var/www/html/youtube-ads-list.txt >> ./tmp_list.txt
fi

# update dns list
python ${DIR}/get_yt_dns.py | grep ^r | awk '{print $1}' | sort -nr | uniq >> ./tmp_list.txt
grep r*.googlevideo.com /var/log/pihole.log | awk '{print $6}'| grep ^r | sort -nr | uniq >> ./tmp_list.txt
echo "gstaticadssl.l.google.com" >> ./tmp_list.txt

# write new list
echo "" > /var/www/html/youtube-ads-list.txt
cat ./tmp_list.txt | sort -nr | uniq >> /var/www/html/youtube-ads-list.txt

rm ./tmp_list.txt

# update gravity
pihole -g