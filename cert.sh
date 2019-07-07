#!/bin/bash
function checkCert {
	valid=$(openssl x509 -enddate -noout -in "$1" | cut -b 10-)
	valids=$(date -d "${valid}" +%s)
	limit=$(date -d "+${certlimit}" +%s)

	#echo "valid $valid, valids: ${valids}, limit: $limit, certlimit: $certlimit"
	if [ "${valids}" -lt "${limit}" ]; then
		return 1
	fi
	return 0
}
