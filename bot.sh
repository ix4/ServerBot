#!/bin/bash
# the main bot script

# change dir
cd "$( dirname "${BASH_SOURCE[0]}" )"
echo "pwd: "
pwd

. config.sh
#. func.sh
msg="a"
ident="" # variable to identify changes in the problems

#hdd usage
. hdd.sh
used=$(hddUsage)
if [ "$used" -gt "$hddlimit" ]; then
	echo "HDD warn!"
	hddTop=$(hddTop)
	printf -v msg '%b\n\nwarnung server used %b%% of the storage\n%b' "${msg}" "$used" "$hddTop"
	ident="$ident:hdd"
fi
unset -f hddTop
unset -f hddUsage

#services
. services.sh
notrunning=$(checkServices "$services")
if [ "$notrunning" != "" ]; then
	echo "Serive warn!"
	printf -v msg '%b\n\nwarnung the following services are not running\n%b' "${msg}" "$notrunning"
	ident="$ident:$notrunning"
fi
unset -f checkServices

#cpu usage
. cpu.sh
cpu=$(cpuUsage)
if [ "$cpu" -gt "$cpulimit" ]; then
	echo "cpu limit!"
	proc=$(cpuTop)
	printf -v msg '%b\n\nwarnung CPU Usage is high %b%%\n%b' "${msg}" "$cpu" "$proc"
	ident="$ident:cpu"
fi
unset -f cpuUsage
unset -f cpuTop

#mem usage
. mem.sh
mem=$(memUsage)
if [ "$mem" -gt "$memlimit" ]; then
	echo "mem limit!"
	proc=$(memTop)
	printf -v msg '%b\n\nwarnung Memory Usage is high %b%%\n%b' "${msg}" "$mem" "$proc"
	ident="$ident:mem"
fi
unset -f memUsage
unset -f memTop

#CheckCerts
. cert.sh
checkCert "/etc/letsencrypt/live/mrbesen.de/cert.pem"
if [ "$?" -gt "0" ]; then
	echo "cert expired!"
	printf -v msg '%b\n\nwarnung cert expires soon' "${msg}"
	ident="$ident:cert"
fi
unset -f checkCert

. func.sh
if [[ "${#msg}" -gt "1" ]]; then
	#remove prepend
	msg=$(echo "$msg" | tail -n +3)
	send "$ident" "$msg"
else
	resetFile
fi
