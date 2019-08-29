#!/bin/bash
function hddUsage {
	df --output=pcent $hdd | tail -1 | grep -Po "(\\d+)" --color=never
}

function hddTop {
	du -hd 3 / --exclude="/proc" | sort -hr | grep -E "/.*/.*/" | head -n 3 | sed -e 's/\t/%20/g; s:/:%2F:g; a%0A' | sed -e '1i \%0A' | tr -d '\n'
}
