<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <script
            src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
    <style>
        body {
            margin: 0;
            text-align: center;
        }
        #map {
            height: 90vh;
            width: 100vw;
        }
    </style>
</head>
<body>
<div id="map"></div>
<br>
<input id="follow" type="checkbox" onclick="followChange();" checked><span style="font-family: 'Open Sans', sans-serif;"> Follow With Map</span></input>
<script>

    var map = undefined;
    var marker = undefined;
    var trackLine = undefined;
    var position = [];
    var firstLoad = true;
    var numDeltas;
    var delay = 100; //milliseconds
    var i = 0;
    var deltaLat;
    var deltaLng;
    var markerPos;
    var updateFlag = true;
    var commsCounter = 10;
    var lastPos;
    var nextPos;
    var pollDelay = 5000;
    var totalDistance = 1731;
    var travelledDistance = 0;
    var follow = true;
    var trackCoordinates = [];

    function main()
    {
        if (firstLoad){
            numDeltas = pollDelay / 100;
            $.getJSON("/tracks/live/5", function(json) {
                position.push([json[4]['lat'], json[4]['long']]);
                position.push([json[3]['lat'], json[3]['long']]);
                position.push([json[2]['lat'], json[2]['long']]);
                position.push([json[1]['lat'], json[1]['long']]);
                position.push([json[0]['lat'], json[0]['long']]);
                initMap(position.shift());
                getData();
                main();
            });
        } else {
            if (position.length == 1) setTimeout(main, pollDelay);
            else {
                nextPos = position.shift();
                transition(lastPos, nextPos);
                lastPos = nextPos;

                //updateDistance(travelledDistance);
            }
        }
    }

    function drawTracks()
    {
        trackLine = new google.maps.Polyline({
            path: trackCoordinates,
            geodesic: true,
            strokeColor: '#FF0000',
            strokeOpacity: 1.0,
            strokeWeight: 2
        });
        trackLine.setMap(map);
    }

    function followChange()
    {
        if (document.getElementById("follow").checked) follow = true;
        else follow = false;
    }

    function initMap(start)
    {
        lastPos = start;
        firstLoad = false;
        var startLoc = {lat: start[0], lng: start[1]};
        map = new google.maps.Map(document.getElementById('map'), {
            zoom: 16,
            center: startLoc
        });
        marker = new google.maps.Marker({
            position: startLoc,
            map: map,
            icon: '/img/mapicon.png'
        });
    }

    async function getData()
    {
        $.getJSON("/tracks/live/1", function(json) {
            var data = position[0];
            //console.log("Counter = ", commsCounter, "Stack = ", position.length);
            if (data[0] == json[0]['lat'] && data[1] == json[0]['long']) {
                commsCounter = commsCounter - 1;
                if (commsCounter == 0) commsAlert();
            } else {
                commsCounter = 10;
                position.push([json[0]['lat'], json[0]['long']]);
                travelledDistance = json[0]['distance'];
            }
        });
        setTimeout(getData, pollDelay);
    }

    function commsAlert()
    {
        console.log("There has been no GPS Update from the team for 30 seconds. Tracking will resume automatically when communication returns.")
    }

    function transition(previous, latest)
    {
        trackCoordinates.push({lat: previous[0], lng: previous[1]});
        drawTracks();
        i = 0;
        deltaLat = (latest[0] - previous[0])/numDeltas;
        deltaLng = (latest[1] - previous[1])/numDeltas;
        markerPos = previous;
        if (deltaLat == 0 && deltaLng == 0) main();
        else moveMarker();
    }

    function moveMarker()
    {
        markerPos[0] += deltaLat;
        markerPos[1] += deltaLng;
        var latlng = new google.maps.LatLng(markerPos[0], markerPos[1]);
        marker.setPosition(latlng);
        if (follow) map.setCenter(marker.getPosition());

        if(i!=numDeltas){
            i++;
            setTimeout(moveMarker, delay);
        } else {
            main();
        }
    }

    function updateDistance(travelled)
    {
        var travelledSpan = document.getElementById('travelled');
        var remainingSpan = document.getElementById('remaining');
        var percentageSpan = document.getElementById('percentage');
        var remaining = totalDistance - travelled;
        var percentage = (travelled / totalDistance) * 100;
        travelledSpan.innerHTML = parseFloat(travelled).toFixed((2)) + " km";
        remainingSpan.innerHTML = parseFloat(remaining).toFixed((2)) + " km";
        percentageSpan.innerHTML = parseFloat(percentage).toFixed((2)) + "%";

    }
</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key={{ GOOGLE_MAPS_API_KEY }}&callback=main">
</script>
</body>
</html>