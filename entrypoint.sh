#!/bin/bash

# check that SP_HOSTNAME and APPSERVERS has been set
if [ "x$SP_HOSTNAME" = "x" ] || [ "x$APPSERVERS" = "x" ]; then
  echo -e  "\e[91mYou must set SP_HOSTNAME and APPSERVERS environment variables\e[39m"
  exit 1
fi


# check ssl cert or gennerate.
SSL_PATH=${SSL_PATH:-/app/ssl}
SSL_CERT="$SSL_PATH/$SP_HOSTNAME.crt"
SSL_KEY="$SSL_PATH/$SP_HOSTNAME.key"
if [ ! -f "$SSL_CERT" ]; then
  echo -e "\e[91mMissing SSL certificate and key at '$SSL_CERT' and '$SSL_KEY'\e[39m"
  exit 1
fi

# setup conf file
ACP_BACKENDS=$(for h in $APPSERVERS; do
                echo "  server $h:8443;"
              done)

sed -e "s|ACP_BACKENDS|${ACP_BACKENDS//$'\n'/\\n}|" \
     -e "s/SP_HOSTNAME/$SP_HOSTNAME/" \
     -e "s|SSL_CERT|$SSL_CERT|" \
     -e "s|SSL_KEY|$SSL_KEY|" \
     /app/nginx/ac.conf.tmpl  > /etc/nginx/conf.d/ac.conf

nginx -g "daemon off;"