#!/bin/bash
function memUsage {
	top -bn1 | sed -n 4p | awk '{ print int( $6 / $4 * 100) }'
}

function memTop {
	ps -eo pid,cmd,%mem --sort=-%mem | head -2 | tail -n 1 | sed 's: :%20:g; s:/:%2F:g'
}
