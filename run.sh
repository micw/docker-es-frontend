#!/bin/bash

set -e

mkdir -p /run/nginx

if [ -z "${NAMESERVER_IP}" ]; then
 export NAMESERVER_IP=$( grep /etc/resolv.conf -e "^nameserver[[:space:]]" | awk '{ print $2 }' | head -n 1 )
 if [ -z "${NAMESERVER_IP}" ]; then
  echo "Unable to extract nameserver from /etc/resolv.conf"
  exit 1
  fi
fi

/update_config.py /etc/nginx/nginx.conf

htpasswd -bc /etc/nginx/htpasswd "${AUTH_USER:-admin}" "${AUTH_PASS:-password}"

nginx -g "daemon off;"
