#!/bin/bash
fname="lastmsg.bot"

#1. arg= ident, 2. arg = text
send() {
	#check file
	mapfile -t file < $fname
	fid=${file[0]}
	msgid=${file[1]}
	count=${file[2]}
	params="chat_id=${userid}&text=$2"
	#echo "read: fid: ${fid}, msgid: ${msgid}, count: ${count}"

	if [ "$fid" == "$1" ]; then
		#update only
		method="editMessageText"
		date=$(date '+%F %H:%M')
		params="message_id=${msgid}&${params}"
		count=$((count+1))
		printf -v params "%b\n\n(%b x wiederholt am %b)" "${params}" "${count}" "${date}"
	else
		method="sendMessage"
		count="0"
	fi

	#echo "Sending $2 to ${userid}"

	#request
        raw=$(curl --data "${params}" "https://api.telegram.org/bot${token}/${method}" 2> /dev/null)

	#parse response
	#echo "recieved: $raw"
	msgid=$(python3 -c "import sys, json; print(json.loads('$raw'.replace('\n',''))['result']['message_id'])")
	#echo "msgid: ${msgid}, count: ${count}"

	#write to file
	echo "$1" > $fname #ident
	echo "${msgid}" >> $fname #msgid
	echo "${count}" >> $fname #count
}

#used to rset the file, when nothing is sent
resetFile() {
	echo "..." > $fname #ident -> never match
	echo "-100" >> $fname #msgid
	echo "-1000" >> $fname #count
}
