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
	chmod +x ./update_yt_list.sh
	CRON_SAVE=$(crontab -l)
	if [ "${CRON_SAVE}" != "no crontab for ${USER}" ]
	then
		echo "${CRON_SAVE}" >> ./newcron
	fi
	echo "*/15 * * * * bash ${DIR}/update_yt_list.sh" >> ./newcron
	crontab ./newcron
	sed -i 's|DIR=.*|DIR=${DIR}|g' ./update_yt_list.sh
}

function install_list() {
	echo "add http://${DOMAIN}:${PORT}/youtube-ads-list.txt to your block list"
}

install_dep
install_list
install_cron
