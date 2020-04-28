#!/bin/sh

## Downloads data for Prince Edward Island.
./setup/dl-data.sh $1

# SQL setup to build the network and costs.
./setup/geoserver-sql.sh

# curl requests that interact with the GeoServer RESTful API.
./setup/geoserver-api.sh
