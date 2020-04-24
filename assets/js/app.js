var geoserverUrl = "http://localhost:8600/geoserver";
var selectedPoint = null;

var source = null;
var target = null;

// initialize our map
var map = L.map("map", {
	center: [46.24320196, -63.13481060],
	zoom: 15 //set the zoom level
});

//add openstreet map baselayer to the map
var OSM = L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1Ijoia2VudGphY29icyIsImEiOiJjaWVuMnFhc28wNTFhc2trbTM5dnEzMXZ4In0.HSUSlMda2NRz4MCBY2JnxQ', {
		maxZoom: 18,
		attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
			'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
			'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
		id: 'mapbox/streets-v11',
		tileSize: 512,
		zoomOffset: -1
	}).addTo(map);

// empty geojson layer for the shortes path result
var pathLayer = L.geoJSON(null);

// Custom marker for source
var sourceIcon = L.icon({
	iconUrl: 'assets/images/source.png',
	iconSize: [25, 41],
	iconAnchor: [10, 41]
});

// Custom marker for target
var targetIcon = L.icon({
	iconUrl: 'assets/images/target.png',
	iconSize: [25, 41],
	iconAnchor: [10, 41]
})

// draggable marker for starting point. Note the marker is initialized with an initial starting position
var sourceMarker = L.marker([46.24509122, -63.14270243], {
	icon: sourceIcon,
	draggable: true
})
	.on("dragend", function(e) {
		selectedPoint = e.target.getLatLng();
		getVertex(selectedPoint);
		getRoute();
	})
	.addTo(map);

// draggbale marker for destination point.Note the marker is initialized with an initial destination positon
var targetMarker = L.marker([46.23690394, -63.13068258], {
	icon: targetIcon,
	draggable: true
})
	.on("dragend", function(e) {
		selectedPoint = e.target.getLatLng();
		getVertex(selectedPoint);
		getRoute();
	})
	.addTo(map);

// function to get nearest vertex to the passed point
function getVertex(selectedPoint) {
	var url = geoserverUrl + '/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=routing:nearest_vertex&viewparams=x:' + selectedPoint.lng + ';y:' + selectedPoint.lat + ';&outputFormat=application/json';
	$.ajax({
		url: url,
		async: false,
		success: function(data) {
			loadVertex(
				data,
				selectedPoint.toString() === sourceMarker.getLatLng().toString()
			);
		}
	});
}

// function to update the source and target nodes as returned from geoserver for later querying
function loadVertex(response, isSource) {
	var features = response.features;
	map.removeLayer(pathLayer);
	if (isSource) {
		source = features[0].properties.id;
	} else {
		target = features[0].properties.id;
	}
}

// function to get the shortest path from the give source and target nodes
function getRoute() {
	var url = geoserverUrl + '/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=routing:shortest_path&viewparams=source:' + source + ';target:' + target + ';&outputFormat=application/json';

	$.getJSON(url, function(data) {
		map.removeLayer(pathLayer);
		pathLayer = L.geoJSON(data);
		map.addLayer(pathLayer);
	});
}

getVertex(sourceMarker.getLatLng());
getVertex(targetMarker.getLatLng());
getRoute();
