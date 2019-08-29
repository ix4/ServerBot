#!/bin/bash

#notify on reboot

# change dir
cd "$( dirname "${BASH_SOURCE[0]}" )"
echo "pwd: "
pwd

. config.sh
. func.sh
send "Server%20started."
