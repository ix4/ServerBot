#!/bin/bash
# the main bot script

. func.sh

#hdd usage
used=$(df --output=pcent /dev/sda3 | tail -1 | grep -Po "(\\d+)" --color=never)
if [ "$used" -gt 50 ]; then
	echo "warn!"
	send "warnung%20server%20used%20$used%25%20of%20the%20storage!"
fi

#services
. services.sh
notrunning=$(checkServices "nginx,mysql")
if [ "$notrunning" != "" ]; then
	echo "Serive warn!"
	send "warnung%20the%20following%20services%20are%20not%20running%20$notrunning"
fi
