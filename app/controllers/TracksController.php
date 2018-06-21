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
        if (is_numeric($number) && $number > 0)
        {
            $latestTrack = tracks::find(array(
                "order" => "timestamp DESC",
                "limit" => $number
            ));
            return json_encode($latestTrack);
        } elseif ($number == 0) {
            $latestTrack = tracks::find(array(
                "order" => "timestamp DESC"));
            return json_encode($latestTrack);
        } else echo "Incorrect Params.";
        return null;
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
    }



}

