<?php

class TracksController extends ControllerBase
{

    public function initialize()
    {
        $this->getConf(null);
    }

    public function indexAction()
    {

    }

    public function liveAction($number)
    {
        if (is_numeric($number) && $number < 10)
        {
            $latestTrack = tracks::find(array(
                "order" => "timestamp DESC",
                "limit" => $number
            ));
            return json_encode($latestTrack);
        } else
            echo "Incorrect Params.";
        return null;
    }

    public function populateAction()
    {
        if (file_exists('E:\User Data\PhpstormProjects\LiveTracker\app\controllers\CalaisToRome.xml')) {
            echo "in file";
            $xml = simplexml_load_file('E:\User Data\PhpstormProjects\LiveTracker\app\controllers\CalaisToRome.xml');
            //print_r($xml);
            foreach ($xml as $data)
            {
                $track = new testdata();
                $track->lat = $data['lat'];
                $track->long = $data['lon'];
                $track->elevation = 1;
                $track->speed = 1;
                $track->used = 0;
                $track->save();
            }
        } else {
            exit('Failed to open XML.');
        }
    }

    public function testcalcAction()
    {
        echo $this->getDistance(50.5948, -3.91055, 50.5952, -3.90977);
    }

    public function generateAction()
    {
        $latestTrack = testdata::findFirst(array(
            "order" => "id ASC",
            "limit" => "2",
            "used = 0"
        ));

        $previousTrack = tracks::findFirst(array(
            "order" => "timestamp DESC"
        ));

        $track = new tracks();

        $track->lat = $latestTrack->lat;
        $track->long = $latestTrack->long;
        $track->elevation = 1;
        $track->speed = 1;
        $track->distance = ($previousTrack->distance + $this->getDistance(
            $previousTrack->lat, $previousTrack->long, $latestTrack->lat, $latestTrack->long));
        $track->save();

        $latestTrack->used = 1;
        $latestTrack->save();

        header("Refresh:3");
    }

    public function gettracksAction()
    {
        $json = file_get_contents('http://www.followmee.com/api/tracks.aspx?key=125fece2028a447fd97aa099e998ef0e%20&username=benfreke&output=json&function=currentfordevice&deviceid=' . $this->getConf("PHONE_ID"));
        $obj = json_decode($json, true);
        $previousTrack = tracks::findFirst(array(
            "order" => "timestamp DESC"
        ));

        $track = new tracks();
        $track->lat = $obj["Data"][0]["Latitude"];
        $track->long = $obj["Data"][0]["Longitude"];
        $track->elevation = $obj["Data"][0]["Altitude(m)"];
        $track->speed = $obj["Data"][0]["Speed(mph)"];
        $track->distance = ($previousTrack->distance + $this->getDistance(
                $previousTrack->lat, $previousTrack->long, $track->lat, $track->long));

        if ($previousTrack->long == $track->long || $previousTrack->lat == $track->lat) echo "same";
        else $track->save();

        //$track->save();
        header("Refresh:3");

    }



}

