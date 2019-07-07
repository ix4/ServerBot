#!/bin/bash
#1. arg = text
send() {
	echo "Sending $1 to ${userid}"
	curl --data "chat_id=${userid}&text=$1" -s "https://api.telegram.org/bot${token}/sendMessage" > /dev/null
}
