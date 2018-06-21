<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
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
<div class="container-large-desktop">
    <div class="row">
        <div class="col-md-9">
            <div id="map"></div>
        </div>
        <div class="col-md-3">
            <table class="table table-dark">
                <tbody>
                <tr>
                    <td><b>Last Update</b></td>
                    <td id="update">0 mins</td>
                </tr>
                <tr>
                    <td><b>Speed</b></td>
                    <td id="speed">0 mph</td>
                </tr>
                <tr>
                    <td><b>Distance</b></td>
                    <td id="travelled">0.00 km</td>
                </tr>
                <tr>
                    <td><b>Remaining</b></td>
                    <td id="remaining">0.00 km</td>
                </tr>
                <tr>
                    <td><b>Completed</b></td>
                    <td id="percentage">0.00%</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input id="follow" type="checkbox" onclick="followChange();" checked><span style="font-family: 'Open Sans', sans-serif;"> Follow With Map</span></input>
                    </td>
                </tr>
                </tbody>
            </table>
            <p id="travelled"></p>
        </div>
    </div>
</div>
<script>

    var map = undefined;
    var marker = undefined;
    var trackLine = undefined;
    var position;
    var positions;
    var firstLoad = true;
    var numDeltas;
    var markerPos;
    var updateFlag = true;
    var pollDelay = 5000;
    var totalDistance = 2735;
    var travelledDistance = 0;
    var follow = true;
    var trackCoordinates = [];
    var mapinit = false;

    function main()
    {
        if (firstLoad){
            firstLoad = false;
            getData();
            setTimeout(main, pollDelay);
        } else {
            setTimeout(main, pollDelay);
            drawMarker();
            drawTracks();
            updateDistance();
        }
    }

    function drawMarker()
    {
        var latlng = new google.maps.LatLng(positions[0]['lat'], positions[0]['long']);
        marker.setPosition(latlng);
        if (follow) map.setCenter(marker.getPosition());
    }

    function drawTracks()
    {
        trackCoordinates = [];
        for (var i = 0; i < positions.length; i++) trackCoordinates.push({lat: positions[i]['lat'], lng: positions[i]['long']})
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

    function initMap()
    {
        mapinit = true;
        var startLoc = {lat: positions[0]['lat'], lng: positions[0]['long']};
        map = new google.maps.Map(document.getElementById('map'), {
            zoom: 10,
            center: startLoc
        });
        marker = new google.maps.Marker({
            position: startLoc,
            map: map,
            icon: '/img/mapicon.png'
        });
        drawTracks();
        updateDistance();

    }

    async function getData()
    {
        $.getJSON("/tracks/live/0", function(json) {
            positions = json;
            if (!mapinit) initMap();
            setTimeout(getData, pollDelay);
        });

    }

    function updateDistance()
    {
        var updateSpan = document.getElementById('update');
        var date1 = new Date(positions[0]['timestamp']);
        var date2 = new Date(Date.now());
        var timeDiff = Math.abs(date2.getTime() - date1.getTime());
        var diffHrs = Math.ceil(timeDiff / (60 * 1000));
        var lastSpeedSpan = document.getElementById('speed');
        var travelledSpan = document.getElementById('travelled');
        var remainingSpan = document.getElementById('remaining');
        var percentageSpan = document.getElementById('percentage');
        var remaining = totalDistance - positions[0]['distance'];
        var percentage = (positions[0]['distance'] / totalDistance) * 100;
        travelledSpan.innerHTML = parseFloat(positions[0]['distance']).toFixed((2)) + " km";
        remainingSpan.innerHTML = parseFloat(remaining).toFixed((2)) + " km";
        percentageSpan.innerHTML = parseFloat(percentage).toFixed((2)) + "%";
        updateSpan.innerHTML = diffHrs + " mins";
        lastSpeedSpan.innerHTML = positions[0]['speed'] + " mph";

    }
</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key={{ GOOGLE_MAPS_API_KEY }}&callback=main">
</script>
</body>
</html>