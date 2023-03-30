#!/bin/bash

if [ ! -f "/etc/nginx/conf.d/default.conf" ]; then
  echo "Initializing NGINX/OpenResty conf.d and html directories."
  mkdir -p /etc/nginx/conf.d /usr/local/openresty/nginx/html
  cp -a /usr/local/openresty/nginx/dist/conf.d/* /etc/nginx/conf.d
  cp -a /usr/local/openresty/nginx/dist/html/* /usr/local/openresty/nginx/html
fi

rm -f /usr/local/openresty/nginx/logs/nginx.pid

/usr/local/openresty/bin/openresty -v
/usr/local/openresty/bin/openresty -g 'daemon off;'
