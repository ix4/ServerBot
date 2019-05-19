#!/bin/bash
#services that should be running
services="nginx,mysql"

#cpu usage limit (not divided by core count)
cpulimit="150"

#telegram api-token
token="123456:ABCDEFGH"
#telegram user to notify
userid="123456"

#harddrive usage percentage
hddlimit="50"

#harddrive
hdd="/dev/sda1"

memlimit="90"

certlimit="1 week"
