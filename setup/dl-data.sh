#!/bin/bash

export host_ip=`hostname -I | cut -d' ' -f1`

PR_CODE="$1"

ogrinfo PG:"host=$host_ip port=25434 user='geoadm' password='password' dbname='routedb'" -sql @setup/sql/drop-tables.sql

if [ -z $PR_CODE ]; then
  echo "Parameter for provincial code is empty."
  exit 1
elif [ "$1" = 'ab' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=ebfbc7d8-e6a0-42ab-ad9e-1077221214d9' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_AB_*.zip -d data
  export LAYER=`ls data/NRN_AB* | cut -c6-16`
  ogr2ogr -f PostgreSQL PG:"host=$host_ip dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_AB_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'bc' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=fd1edf8b-f06d-4074-a27d-3e2c36d905da' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_BC_*.zip -d data
  export LAYER=`ls data/NRN_BC* | cut -c6-16`
  ogr2ogr -f PostgreSQL PG:"host=$host_ip dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_BC_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'mb' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=08364fec-3770-44e7-b7cd-b4367e911a35' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_MB_*.zip -d data
  cd data
  export LAYER=`ls data/NRN_MB* | cut -c6-16`
  if [ ${#LAYER} -eq 11 ]; then export LAYER=`ls data/NRN_MB* | cut -c6-15`; fi
  ogr2ogr -f PostgreSQL PG:"host=$host_ip dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_MB_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'nb' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=1fa38552-f819-43ff-ac60-113bd10ddb49' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_NB_*.zip -d data
  export LAYER=`ls data/NRN_RRN_NB*/NRN_NB* | cut -c26-36`
  if [ ${#LAYER} -eq 11 ]; then export LAYER=`ls data/NRN_RRN_NB*/NRN_NB* | cut -c26-35`; fi
  ogr2ogr -f PostgreSQL PG:"host=$host_ip dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_RRN_NB*/NRN_NB_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'nl']; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=56c8b232-bf88-4e51-b650-860dfcb86e9f' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL


elif [ "$1" = 'ns']; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=caba16f1-0dd8-4db1-813b-c7bdd67122ef' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL


elif [ "$1" = 'nt']; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=e81802cf-9bad-47b8-8d45-591921316c66' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL


elif [ "$1" = 'nu']; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=7810494c-5fed-4a10-849d-413833a36ab1' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL


elif [ "$1" = 'on']; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=b87ae33c-2339-4edd-9ef3-6581b6341742' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL


elif [ "$1" = 'pe']; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=4c1ae636-5c7c-41ab-a943-1f82ae3faf89' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL


elif [ "$1" = 'qc']; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=f79e8e77-093c-4cbc-ac40-47b0ea0ade59' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL


elif [ "$1" = 'sk']; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=23ba8fb5-41f9-47d8-8763-6f69ec2f55cc' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL


elif [ "$1" = 'yt']; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=2e72388e-4815-44c0-ae92-ce252a712365' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
fi


# wget -P data https://geo.statcan.gc.ca/nrn_rrn/pe/NRN_RRN_PE_18_0_GPKG.zip
#
# unzip data/NRN_RRN_PE_18_0_GPKG.zip -d data
#
# ogr2ogr -f PostgreSQL PG:"host=$host_ip dbname=routedb port=25434 user=geoadm password=password" \
#   data/NRN_RRN_PE_18_0_GPKG/NRN_PE_18_0_GPKG/NRN_PE_18_0.gpkg \
#   -sql "SELECT * FROM NRN_PE_18_0_ROADSEG" \
#   -lco GEOMETRY_NAME=the_geom \
#   -lco FID=id \
#   -lco PRECISION=no \
#   -nln edges \
#   -t_srs "EPSG:4326" \
#   -overwrite
