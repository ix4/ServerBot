#!/bin/bash
#1. arg = text
send() {
	echo "Sending $1 to ${userid}"
	curl -s "https://api.telegram.org/bot${token}/sendMessage?chat_id=${userid}&text=$1" > /dev/null
}
