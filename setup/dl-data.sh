#!/bin/bash

export HOST_IP=`hostname -I | cut -d' ' -f1`

PR_CODE="$1"

ogrinfo PG:"host=$HOST_IP port=25434 user='geoadm' password='password' dbname='routedb'" -sql @setup/sql/drop-tables.sql

if [ -z $PR_CODE ]; then
  echo "Parameter for provincial code is empty."
  exit 1
elif [ "$1" = 'ab' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=ebfbc7d8-e6a0-42ab-ad9e-1077221214d9' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_AB_*.zip -d data
  export LAYER=`ls data/NRN_AB* | cut -c6-16`
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
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
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
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
  export LAYER=`ls data/NRN_MB* | cut -c6-16`
  if [ ${#LAYER} -eq 11 ]; then export LAYER=`ls data/NRN_MB* | cut -c6-15`; fi
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
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
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_RRN_NB*/NRN_NB_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'nl' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=56c8b232-bf88-4e51-b650-860dfcb86e9f' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_NL_*.zip -d data
  export LAYER=`ls data/NRN_NL* | cut -c6-16`
  if [ ${#LAYER} -eq 11 ]; then export LAYER=`ls data/NRN_NL* | cut -c6-15`; fi
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_NL_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite


elif [ "$1" = 'ns' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=caba16f1-0dd8-4db1-813b-c7bdd67122ef' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_NS_*.zip -d data
  export LAYER=`ls data/NRN_NS* | cut -c6-16`
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_NS_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'nt' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=e81802cf-9bad-47b8-8d45-591921316c66' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_NT_*.zip -d data
  export LAYER=`ls data/NRN_NT* | cut -c6-16`
  if [ ${#LAYER} -eq 11 ]; then export LAYER=`ls data/NRN_NT* | cut -c6-15`; fi
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_NT_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'nu' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=7810494c-5fed-4a10-849d-413833a36ab1' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_NU_*.zip -d data
  export LAYER=`ls data/NRN_NU* | cut -c6-16`
  if [ ${#LAYER} -eq 11 ]; then export LAYER=`ls data/NRN_NU* | cut -c6-15`; fi
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_NU_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'on' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=b87ae33c-2339-4edd-9ef3-6581b6341742' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_ON_*.zip -d data
  export LAYER=`ls data/NRN_ON* | cut -c6-16`
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_ON_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'pe' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=4c1ae636-5c7c-41ab-a943-1f82ae3faf89' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_PE_*.zip -d data
  export LAYER=`ls data/NRN_RRN_PE*/NRN_PE* | cut -c1-11`
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_RRN_PE*/NRN_PE*/NRN_PE_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'qc' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=f79e8e77-093c-4cbc-ac40-47b0ea0ade59' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_QC_*.zip -d data
  export LAYER=`ls data/NRN_QC* | cut -c6-16`
  if [ ${#LAYER} -eq 11 ]; then export LAYER=`ls data/NRN_QC* | cut -c6-15`; fi
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_QC_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'sk' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=23ba8fb5-41f9-47d8-8763-6f69ec2f55cc' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_SK_*.zip -d data
  export LAYER=`ls data/NRN_RRN_SK*/NRN_SK* | cut -c1-11`
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_RRN_SK*/NRN_SK*/NRN_SK_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite

elif [ "$1" = 'yk' ]; then
  export DL_URL=`curl -s 'https://open.canada.ca/data/api/action/package_show?id=2e72388e-4815-44c0-ae92-ce252a712365' | \
  python3 -c "import sys, json; print(json.load(sys.stdin)['result']['resources'][0]['url'])"`
  wget -P data $DL_URL
  unzip data/NRN_RRN_YK_*.zip -d data
  export LAYER=`ls data/NRN_RRN_YK*/NRN_YK* | cut -c1-11`
  ogr2ogr -f PostgreSQL PG:"host=$HOST_IP dbname=routedb port=25434 user=geoadm password=password" \
    -lco GEOMETRY_NAME=the_geom \
    -lco FID=id \
    -lco PRECISION=no \
    -nln edges \
    -t_srs "EPSG:4326" \
    data/NRN_RRN_YK*/NRN_YK*/NRN_YT_*.gpkg \
    $LAYER"_ROADSEG" \
    -overwrite
fi
