#!/bin/sh

export HOST_IP=`hostname -I | cut -d' ' -f1`

ogrinfo PG:"host=$HOST_IP port=25434 user='geoadm' password='password' dbname='routedb'" -sql @setup/sql/build-net.sql

ogrinfo PG:"host=$HOST_IP port=25434 user='geoadm' password='password' dbname='routedb'" -sql @setup/sql/cost.sql
