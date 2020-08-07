#!/bin/bash -e


# update dns list
python /etc/dnsdumpster/dnsdumpster/API_example.py | grep ^r | awk '{print $1}' | sort -nr | uniq > /var/www/html/youtube-ads-list.txt
grep r*.googlevideo.com /var/log/pihole.log | awk '{print $6}'| grep ^r | sort -nr | uniq >> /var/www/html/youtube-ads-list.txt

# update gravity
pihole -g