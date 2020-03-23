<?php
/**
 * Created by PhpStorm.
 * User: Saulo
 * Date: 24/10/2018
 * Time: 03:40 PM
 */

class Model extends dbStructure
{
    private $fields = array();

    public function __set($name,$val)
    {
        if (isset($this->fields[$name])) {
            $this->fields=$val;
        }
        else{
            throw new Exception("$name dow not exists");
        }
    }
    public function __get($name)
    {
        if(isset($this->fields[$name]))
            return $this->fields[$name];
        else
            throw new Exception("$name dow not exists");
    }
}
