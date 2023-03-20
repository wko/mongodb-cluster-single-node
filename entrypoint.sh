#!/usr/bin/env bash

/setup.sh &

tail -f $MONGO_BASE_DIR/log/db27017.log &

supervisord -c /etc/supervisor/supervisord.conf -n


