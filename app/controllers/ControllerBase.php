<?php

class ControllerBase extends \Phalcon\Mvc\Controller
{

    public function getConf($variable)
    {
        if ($variable == null)
        {
            $vars = config::find();
            foreach ($vars as $var)
            {
                $this->view->setVar($var->variable, $var->value);
            }
            return true;
        } else {
            $var = config::findFirst(array(
                "conditions" => "variable = :varVal:",
                "bind" => array("varVal" => $variable)
            ));
            if ($var) return $var->value;
            else return false;
        }
    }

    public function getDistance(
        $latitudeFrom, $longitudeFrom, $latitudeTo, $longitudeTo, $earthRadius = 6371)
    {
        // convert from degrees to radians
        $latFrom = deg2rad($latitudeFrom);
        $lonFrom = deg2rad($longitudeFrom);
        $latTo = deg2rad($latitudeTo);
        $lonTo = deg2rad($longitudeTo);

        $latDelta = $latTo - $latFrom;
        $lonDelta = $lonTo - $lonFrom;

        $angle = 2 * asin(sqrt(pow(sin($latDelta / 2), 2) +
                cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)));
        return $angle * $earthRadius;
    }

}