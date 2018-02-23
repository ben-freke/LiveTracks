<?php


class tracks extends Phalcon\Mvc\Model
{
    public $id;
    public $long;
    public $lat;
    public $elevation;
    public $speed;
    public $timestamp;

    public function initialize()
    {
    }
    public function beforeSave()
    {
    }
    public function afterFetch()
    {
        $this->long = floatval($this->long);
        $this->lat = floatval($this->lat);
    }

}