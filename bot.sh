#!/bin/bash
# the main bot script

# change dir
cd "$( dirname "${BASH_SOURCE[0]}" )"
echo "pwd: "
pwd

. config.sh
. func.sh

#hdd usage
. hdd.sh
used=$(hddUsage)
if [ "$used" -gt "$hddlimit" ]; then
	echo "warn!"
	hddTop=$(hddTop)
	send "warnung server used $used% of the storage $hddTop"
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
	proc=$(cpuTop)
	send "warnung%20CPU%20Usage%20is%20high%20$cpu%25%0A$proc"
fi

#mem usage
. mem.sh
mem=$(memUsage)
if [ "$mem" -gt "$memlimit" ]; then
	echo "mem limit!"
	proc=$(memTop)
	send "warnung%20Memory%20Usage%20is%20high%20$mem%25%0A$proc"
fi

#CheckCerts
. cert.sh
checkCert "/etc/letsencrypt/live/mrbesen.de/cert.pem"
if [ "$?" -gt "0" ]; then
	echo "cert expired!"
	send "warnung%20cert%20expires%20soon"
fi
