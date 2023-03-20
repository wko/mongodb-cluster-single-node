#!/usr/bin/env bash

PORT=$1

mkdir -p $MONGO_BASE_DIR/log $MONGO_BASE_DIR/data/db$PORT


mongod --replSet dbrs --bind_ip_all --port $PORT --dbpath $MONGO_BASE_DIR/data/db$PORT --logpath $MONGO_BASE_DIR/log/db$PORT.log
