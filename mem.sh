#!/bin/bash
function memUsage {
	top -bn1 | sed -n 4p | awk '{ print int( $6 / $4 * 100) }'
}
