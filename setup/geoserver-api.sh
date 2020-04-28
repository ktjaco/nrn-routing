#!/bin/sh

export HOST_IP=`hostname -I | cut -d' ' -f1`

curl -v -u admin:password -POST -H "Content-type: text/xml" \
  -d @setup/xml/workspace.xml \
  http://$HOST_IP:8600/geoserver/rest/workspaces

sed -i 's|<entry key="host">localhost</entry>|<entry key="host">'$HOST_IP'</entry>|' setup/xml/datastore.xml

curl -v -u admin:password -POST -H "Content-type: text/xml" \
  -d @setup/xml/datastore.xml \
  http://$HOST_IP:8600/geoserver/rest/workspaces/routing/datastores

curl -v -u admin:password -POST -H "Content-type: text/json" \
  -d @setup/json/edges.json \
  http://$HOST_IP:8600/geoserver/rest/workspaces/routing/datastores/routedb/featuretypes

curl -v -u admin:password -POST -H "Content-type: text/json" \
  -d @setup/json/edges_noded.json \
  http://$HOST_IP:8600/geoserver/rest/workspaces/routing/datastores/routedb/featuretypes

curl -v -u admin:password -POST -H "Content-type: text/json" \
  -d @setup/json/edges_noded_vertices_pgr.json \
  http://$HOST_IP:8600/geoserver/rest/workspaces/routing/datastores/routedb/featuretypes

curl -v -u admin:password -POST -H "Content-type: text/json" \
  -d @setup/json/nearest_vertex.json \
  http://$HOST_IP:8600/geoserver/rest/workspaces/routing/datastores/routedb/featuretypes

curl -v -u admin:password -POST -H "Content-type: text/json" \
  -d @setup/json/shortest_path.json \
  http://$HOST_IP:8600/geoserver/rest/workspaces/routing/datastores/routedb/featuretypes
