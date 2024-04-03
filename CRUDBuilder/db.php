<?php

/**
 * Created by PhpStorm.
 * User: Saulo
 * Date: 22/10/2018
 * Time: 11:29 PM
 */

class db
{
	protected $encryption = "md5";
    protected $type = "mysql";
	protected $srv = "localhost";
	protected $port = 3306;
	protected $usr = "root";
	protected $pass = "";
	protected $db = "saludiglesia";
	private $conn;

	function setSrv($srv)
	{
		$this->srv = $srv;
	}

	function setUsr($usr)
	{
		$this->usr = $usr;
	}

	function setPass($pass)
	{
		$this->pass = $pass;
	}

	function setDb($db)
	{
		$this->db = $db;
	}

	function getEncryption()
	{
		return $this->encryption;
	}

	function getPort()
	{
		return $this->port;
	}

	function setEncryption($encryption)
	{
		$this->encryption = $encryption;
	}

	function setPort($port)
	{
		$this->port = $port;
	}

	function getDb()
	{
		return $this->db;
	}

	function getUsr()
	{
		return $this->usr;
	}

	function getPass()
	{
		return $this->pass;
	}

	function getSrv()
	{
		return $this->srv;
	}

	private function connect()
	{
		$this->conn = mysqli_connect($this->srv, $this->usr, $this->pass, $this->db);
	}
	/**
	 * @return mixed
	 */
	public function getConn()
	{
		if (!isset($this->conn)) {
			$this->connect();
			return $this->conn;
		} else {
			return $this->conn;
		}
	}

	public function execute($sql)
	{
		return mysqli_query($this->conn, $sql);
	}
}
