#!/bin/bash

function cpuUsage {
	ps -A -o pcpu | tail -n+2 | paste -sd+ | bc | awk '{print int($1)}'
}
