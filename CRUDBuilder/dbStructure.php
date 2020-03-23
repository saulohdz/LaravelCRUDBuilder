<?php
/**
 * Created by PhpStorm.
 * User: Saulo
 * Date: 22/10/2018
 * Time: 10:59 PM
 */
require "db.php";
class dbStructure extends db
{
  private $DB;

  private function srchTblKey($tbl){
    $ntables = count($this->DB->Tables);
    $j=0;
     while ($this->DB->Tables[$j]->TableName != $tbl && $j < $ntables){
         $j++;
     }
     if ($j > $ntables){
      return null;
     }
     else{
       return $j;
     }
  }

  public function __construct($dbStructure){
      $this->DB = $dbStructure;
      $dbconf=parse_ini_file(".env");
  }

  public function loadStructure($fname){
      $this->DB = json_decode(file_get_contents($fname));
  }

  public function createDbStructure($dbStructure){
      $this->DB = $dbStructure;
  }

  public function getTableProperties($tblName){
      $inx = $this->srchTblKey($tblName);
      return $this->DB->Tables[$inx];
  }

  public function setTableProperties($tblName,$properties){
        $inx = $this->srchTblKey($tblName);
        $this->DB->Tables[$inx]=$properties;
  }

  public function saveDbStrucuture($fname){
      $hndl = fopen($fname,"w");
      fputs($hndl,$this->DB);
      fclose($hndl);
  }
}
