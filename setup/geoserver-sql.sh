#!/bin/sh

export host_ip=`hostname -I | cut -d' ' -f1`

ogrinfo PG:"host=$host_ip port=25434 user='geoadm' password='password' dbname='routedb'" -sql @setup/sql/build-net.sql

ogrinfo PG:"host=$host_ip port=25434 user='geoadm' password='password' dbname='routedb'" -sql @setup/sql/cost.sql
