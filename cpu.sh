#!/bin/bash

function cpuUsage {
	ps -A -o pcpu | tail -n+2 | paste -sd+ | bc | awk '{print int($1)}'
}

function cpuTop {
	ps -eo pid,cmd,%cpu --sort=-%cpu | head -2 | tail -n 1 | sed 's: :%20:g; s:/:%2F:g'
}
