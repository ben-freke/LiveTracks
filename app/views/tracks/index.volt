<!DOCTYPE html>
<html>
<head>
    <script
            src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
    <style>

        #map {
            height: 100vh;
            width: 100%;
        }
    </style>
</head>
<body>
<div id="map"></div>
<script>

    var map = undefined;
    var marker = undefined;
    var position;
    var firstLoad = true;
    var numDeltas = 30;
    var delay = 100; //milliseconds
    var i = 0;
    var deltaLat;
    var deltaLng;
    var markerPos;
    var updateFlag = true;
    var commsCounter = 10;

    function main()
    {
        if (firstLoad){
            $.getJSON("/tracks/live", function(json) {
                position = [
                    [json[0]['lat'], json[0]['long']],
                    [json[1]['lat'], json[1]['long']],
                    [json[2]['lat'], json[2]['long']]
                ];
                initMap(position[0]);
                getData();
                main();
            });
        } else {
            if (!updateFlag) {
                setTimeout(main, 3000);
            } else {
                transition(position[1], position[0]);
            }
        }
    }

    function initMap(start) {
        firstLoad = false;
        var startLoc = {lat: start[0], lng: start[1]};
        map = new google.maps.Map(document.getElementById('map'), {
            zoom: 16,
            center: startLoc
        });
        marker = new google.maps.Marker({
            position: startLoc,
            map: map
        });
    }

    async function getData()
    {
        console.log("in async");
        $.getJSON("/tracks/live", function(json) {
            if (position[0][0] == json[0]['lat'] && position[0][1] == json[0]['long']) {
                commsCounter--;
                if (commsCounter == 0) commsAlert();
            } else {
                commsCounter++;
                position = [
                    [json[0]['lat'], json[0]['long']],
                    [json[1]['lat'], json[1]['long']],
                ];
            }
        });
        setTimeout(getData, 3000);
    }

    function commsAlert()
    {
        alert("There has been no GPS Update from the team for 30 seconds. Tracking will resume automatically when communication returns.")
    }

    function transition(previous, latest){
        //getData();
        i = 0;
        deltaLat = (latest[0] - previous[0])/numDeltas;
        deltaLng = (latest[1] - previous[1])/numDeltas;
        markerPos = previous;
        moveMarker();
    }

    function moveMarker(){
        markerPos[0] += deltaLat;
        markerPos[1] += deltaLng;
        var latlng = new google.maps.LatLng(markerPos[0], markerPos[1]);
        marker.setPosition(latlng);
        map.setCenter(marker.getPosition());

        if(i!=numDeltas){
            i++;
            setTimeout(moveMarker, delay);
        } else main();
    }

</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAXTvxZcMOTgyyGF1NfGzKGn2iJuufIyic&callback=main">
</script>
</body>
</html>