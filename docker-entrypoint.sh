#!/bin/bash

set -e

function create_myconfig() {
    if [ ! -d ${MY_CONFIG} ]; then
        echo 'No my/config detected, creating one at: '${MY_CONFIG}
        hpi config create
    fi
}

create_myconfig

if [ ! -d /data/promnesia ]; then
  echo 'No config.py detected, creating new one. Please edit it and try again'
  python -m promnesia config create 
  exit -1
fi

if [ ! -f /data/promnesia.sqlite ]; then
  echo 'No database detected, creating new one...'
  python -m promnesia index 
fi

if [ "$1" = 'promnesia' ]; then
  exec python -m "$@"
fi

exec "$@"
