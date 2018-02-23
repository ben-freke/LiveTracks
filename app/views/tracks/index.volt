<!DOCTYPE html>
<html>
<head>
    <script
            src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
    <style>
        #map {
            height: 420px;
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
    var numDeltas = 100;
    var delay = 30; //milliseconds
    var i = 0;
    var deltaLat;
    var deltaLng;
    var markerPos;

    function initMap(start) {
        firstLoad = false;
        var startLoc = {lat: start[0], lng: start[1]};
        map = new google.maps.Map(document.getElementById('map'), {
            zoom: 9,
            center: startLoc
        });
        marker = new google.maps.Marker({
            position: startLoc,
            map: map
        });
    }

    function update()
    {
        console.log("Running Update")
        $.getJSON("/tracks/live", function(json) {
           if (firstLoad){
               position = [
                   [json[0]['lat'], json[0]['long']],
                   [json[1]['lat'], json[1]['long']]
               ];
               initMap(position[0]);
               transition(position[1], position[0]);
           } else {
               if (position[0][0] == json[0]['lat'] && position[0][1] == json[0]['long'])
               {
                    console.log("No Update");
                    setTimeout(update,3000);
               } else {
                   position = null;
                   position = [
                       [json[0]['lat'], json[0]['long']],
                       [json[1]['lat'], json[1]['long']]
                   ];
                   transition(position[1], position[0]);
               }
           }
        });
    }

    function transition(previous, latest){
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
        if(i!=numDeltas){
            i++;
            setTimeout(moveMarker, delay);
        } else update();
    }

</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAXTvxZcMOTgyyGF1NfGzKGn2iJuufIyic&callback=update">
</script>
</body>
</html>