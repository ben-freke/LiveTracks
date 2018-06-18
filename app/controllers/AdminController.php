<?php

class AdminController extends ControllerBase
{

    public function initialize(){
        $user = users::findFirst(array(
            "conditions" => "id = :idVal:",
            "bind" => array("idVal" => $this->session->get("userid"))
        ));
        if ($user)
        {
            $username = $user->username;
            $this->view->setVar("username", $username);
            if ($user->level == 1) $this->view->setVar("admin", true);
        } else if ($_SERVER['REQUEST_URI'] != "/admin") {
            $response = new \Phalcon\Http\Response();
            $response->redirect("/admin", true);
            $response->send();
        }
        $request = new \Phalcon\Http\Request();
        $this->view->setVar("msg", $request->getQuery('msg'));
    }

    public function indexAction()
    {
        \Phalcon\Tag::setTitle('Login');
        $response = new \Phalcon\Http\Response();
        if ($this->session->has("userid")) {
            $response->redirect("/admin/dashboard/", true);

        }
        $input = file_get_contents("php://input");
        $request = new \Phalcon\Http\Request();
        if ($request->isPost())
        {
            $user = users::findFirst(array(
                "conditions" => "username = :username: AND password = :passVal:",
                "bind" => array("username" =>  $request->get("username"), "passVal" => base64_encode(hash('md5', $request->get("password"))))
            ));
            if ($user){
                date_default_timezone_set('Europe/London');
                $date = new DateTime();
                $date->format('Y-m-d H:i:s');
                $user->lastLogin = $date->format('Y-m-d H:i:s');
                $user->save();
                $this->session->set("userid", $user->id);
                $response->redirect("/admin/dashboard/", true);
            } else {
                $response->redirect("/admin/", true);
            }
        }
        $response->send();
    }

    public function dashboardAction()
    {
        \Phalcon\Tag::setTitle('Dashboard');
    }

    public function configAction()
    {
        $vars = config::find();
        $request = new \Phalcon\Http\Request();
        if ($request->isPost()){
            $event = new events();
            $event->name = $request->get("name");
            $event->location = $request->get("location");
            $event->time = date("Y-m-d H:i:s", strtotime($request->get("datetime")));
            $event->points = $request->get("points");
            if ($event->save())
            {
                $response = new \Phalcon\Http\Response();
                $response->redirect("/control/addevent?msg=1", true);
                $response->send();
            } else {
                $response = new \Phalcon\Http\Response();
                $response->redirect("/control/addevent?msg=2", true);
                $response->send();
            }
        }
        \Phalcon\Tag::setTitle('Site Configuration');
        $vars = config::find();
        $this->view->setVar("configurables", $vars);




    }

    public function logoutAction()
    {
        $response = new \Phalcon\Http\Response();
        $this->session->destroy();
        $response->redirect("/admin", true);
        $response->send();
    }
}

