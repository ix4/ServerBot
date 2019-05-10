#!/bin/bash
# the main bot script

. config.sh
. func.sh

#hdd usage
used=$(df --output=pcent $hdd | tail -1 | grep -Po "(\\d+)" --color=never)
if [ "$used" -gt "$hddlimit" ]; then
	echo "warn!"
	send "warnung%20server%20used%20$used%25%20of%20the%20storage!"
fi

#services
. services.sh
notrunning=$(checkServices "$services")
if [ "$notrunning" != "" ]; then
	echo "Serive warn!"
	send "warnung%20the%20following%20services%20are%20not%20running%20$notrunning"
fi

#cpu usage
. cpu.sh
cpu=$(cpuUsage)
if [ "$cpu" -gt "$cpulimit" ]; then
	echo "cpu limit!"
 	send "warnung%20CPU%20Usage%20is%20high%20$cpu"
fi

#mem usage
. mem.sh
mem=$(memUsage)
if [ "$mem" -gt "$memlimit" ]; then
	echo "mem limit!"
	send "warnung%20Memory%20Usage%20is%20high%20$mem%25"
fi

