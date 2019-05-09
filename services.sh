#!/bin/bash

function checkServices {
  IFS=',' read -r -a array <<< "$1"
  result=""
  for service in "${array[@]}"
  do
    res=$(systemctl is-active "$service")

    if [ "$res" != "active" ]; then
        result="$result $service"
    fi
  done
  echo $result
}

