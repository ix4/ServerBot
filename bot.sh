#!/bin/bash
# the main bot script

#hdd usage
used=$(df --output=pcent /dev/sda3 | tail -1 | grep -Po "(\\d+)" --color=never)
if [ "$used" -gt 50 ]; then
	. func.sh
	echo "warn!"
	send "warnung%20server%20used%20$used%25%20of%20the%20storage!"
fi
