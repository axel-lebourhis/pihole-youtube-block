#!/bin/bash -e

DIR=$(pwd)
DOMAIN=${1}
PORT=${2}

function install_dep() {
	apt-get install -y python-pip
	pip install --upgrade pip
	pip install dnsdumpster
}

function install_cron() {
	# clean repo
	rm -f ./newcron
	# set update script executable
	chmod +x ./update_yt_list.sh

	# check current crontab
	CRON_SAVE=$(crontab -l)
	if [ "${CRON_SAVE}" != "no crontab for ${USER}" ]
	then
		echo "${CRON_SAVE}" >> ./newcron
	fi

	# check if crontab already installed
	CRON_EXISTS=$(crontab -l | grep update_yt_list.sh)
	if [ "${CRON_EXISTS}" != "" ]
	then
		echo "*/15 * * * * bash ${DIR}/update_yt_list.sh" >> ./newcron
		crontab ./newcron
	else
		echo "cron already set up"
	fi

	# set current pwd in update script
	sed -i "s|DIR=.*|DIR=${DIR}|g" ./update_yt_list.sh
}

function install_list() {
	echo "add http://${DOMAIN}:${PORT}/youtube-ads-list.txt to your block list"
}

install_dep
install_list
install_cron
