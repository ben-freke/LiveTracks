<?php

class TracksController extends ControllerBase
{

    public function indexAction()
    {
    }

    public function liveAction()
    {

        $latestTrack = tracks::find(array(
            "order" => "timestamp DESC",
            "limit" => "2"
        ));
       return json_encode($latestTrack);
    }

    public function generateAction()
    {
        $lat = 51.1;
        $long = -2.1;
        while (true)
        {
            $track = new tracks();
            $track->lat = $lat;
            $track->long = $long;
            $track->elevation = 1;
            $track->speed = 1;
            echo "Updating Lat and Long: ". $lat . " " . $long;
            $track->save();
            $lat = $lat + 0.1;
            $long = $long - 0.1;
            sleep(3);
        }
    }

}

