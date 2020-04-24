#!/bin/sh

export host_ip=`hostname -I | cut -d' ' -f1`

ogrinfo PG:"host=$host_ip port=25434 user='geoadm' password='password' dbname='routedb'" -sql @setup/sql/drop-tables.sql

ogrinfo PG:"host=$host_ip port=25434 user='geoadm' password='password' dbname='routedb'" -sql "CREATE EXTENSION pgrouting;"

wget -P data https://geo.statcan.gc.ca/nrn_rrn/pe/NRN_RRN_PE_18_0_GPKG.zip

unzip data/NRN_RRN_PE_18_0_GPKG.zip -d data

ogr2ogr -f PostgreSQL PG:"host=$host_ip dbname=routedb port=25434 user=geoadm password=password" \
  data/NRN_RRN_PE_18_0_GPKG/NRN_PE_18_0_GPKG/NRN_PE_18_0.gpkg \
  -sql "SELECT * FROM NRN_PE_18_0_ROADSEG" \
  -lco GEOMETRY_NAME=the_geom \
  -lco FID=id \
  -lco PRECISION=no \
  -nln edges \
  -t_srs "EPSG:4326" \
  -overwrite
