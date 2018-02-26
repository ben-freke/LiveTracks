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
            "limit" => "3"
        ));
       return json_encode($latestTrack);
    }

    public function populateAction()
    {
        if (file_exists('E:\User Data\PhpstormProjects\LiveTracker\app\controllers\CalaisToRome.xml')) {
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

    public function generateAction()
    {
        $latestTrack = testdata::findFirst(array(
            "order" => "id ASC",
            "limit" => "2",
            "used = 0"
        ));
        $track = new tracks();

        $track->lat = $latestTrack->lat;
        $track->long = $latestTrack->long;
        $track->elevation = 1;
        $track->speed = 1;
        $track->save();

        $latestTrack->used = 1;
        $latestTrack->save();

        header("Refresh:3");
    }



}

