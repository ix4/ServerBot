#!/bin/bash

function cpuUsage {
	ps -A -o pcpu | tail -n+2 | paste -sd+ | bc | awk '{print int($1)}'
}

function cpuHighest {
	ps -eo pid,cmd,%cpu --sort=-%cpu | head -2 | tail -n 1
}
