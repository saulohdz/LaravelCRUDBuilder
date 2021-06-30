<?php

/**
 * Created by PhpStorm.
 * User: Saulo
 * Date: 22/10/2018
 * Time: 11:27 PM
 */
require "dbStructure.php";
require "Model.php";
class readStructure extends dbStructure
{

    private function get_set_values($table, $field)
    {
        if (preg_match('/`/', $table) || preg_match('/\'/', $field)) {
            return false;
        }
        //echo "\n SHOW COLUMNS FROM ".$table." LIKE '".$field."'";
        $column = mysqli_fetch_array($this->execute("SHOW COLUMNS FROM " . $table . " LIKE '" . $field . "'"));
        if (!preg_match('/^enum|set/', $column['Type'])) {
            return false;
        }
        $vals = preg_replace('/(?:^enum|set)|\(|\)/', '', $column['Type']);
        $values = explode(',', $vals);
        if (!sizeof($values)) {
            return false;
        }
        for ($i = 0; $i < sizeof($values); $i++) {
            $values[$i] = preg_replace('/^\'|\'$/', '', $values[$i]);
        }
        return $values;
    }


    public function readStructure($tables)
    {
        $this->getConn();
        $Tbllist = $this->execute("show full tables where Table_Type != 'VIEW'");
        $strResponse = "{\"Database\":\"" . $this->getDb() . "\",\"DatabaseType\":\"MySql\",\"host\":\"" . $this->srv . "\",\"dbuser\":\"" . $this->usr . "\",\"dbpassword\":\"" . $this->pass . "\",\"Tables\":[";
        $c = 1;
        while ($filatables = mysqli_fetch_array($Tbllist)) {
            if ($c == 0) {
                $strResponse .= "},";
            }
            if (in_array($filatables[0], $tables) || count($tables) == 0) {
                $strResponse .= "{\"TableName\":\"" . $filatables[0] . "\",";
                $fldsqry = $this->execute("SELECT * FROM " . $filatables[0]);
                $fields = mysqli_fetch_fields($fldsqry);
                $strResponse .= "\"config\": {\n";
                $strResponse .= "\"editPage\": \"upd_" . $filatables[0] . ".php\"\n,";
                $strResponse .= "\"newPage\": \"add_" . $filatables[0] . ".php\"\n,";
                $strResponse .= "\"viewPage\": \"view_" . $filatables[0] . ".php\"\n,";
                $strResponse .= "\"functionEdit\":\"\",\n";
                $strResponse .= "\"functionDelete\":\"\",\n";
                $strResponse .= "\"functionView\":\"\",\n";
                $strResponse .= "\"PrimaryKey\": \"" . $fields[0]->name . "\",\n";
                $strResponse .= "\"buttons\": {\n";
                $strResponse .= "\"Add\": true, \"Delete\": true, \"Edit\": true, \"View\": true}\n";
                $strResponse .= "}\n";
                $strResponse .= ",\"fields\":[";
                $c2 = 0;
                foreach ($fields as $valor) {
                    $c2++;
                    switch ($valor->type) {
                        case 3:
                            $frmType = "Text";
                            break; //INT
                        case 253:
                            $frmType = "Text";
                            break; //Varchar
                        case 10:
                            $frmType = "Date";
                            break; //Date
                        case 246:
                            $frmType = "Money";
                            break; //Decimal(12,2)
                        case 1:
                            $frmType = "Text";
                            break; //tinyInt
                        case 8:
                            $frmType = "Text";
                            break; //BIGINT
                        case 7:
                            $frmType = "DateTime";
                            break; //DateTime
                        case 4:
                            $frmType = "Float";
                            break; //Double
                        default:
                            $frmType = "Text";
                            break; //Varchar
                    }
                    $PK = (($valor->flags & 2) == 2 ? true : false);
                    $AI = (($valor->flags & 512) == 512 ? true : false);
                    $strResponse .= "{\"FieldName\":\"" . $valor->name . "\"\n";
                    $strResponse .= ",\"TableName\":\"" . $valor->table . "\"\n";
                    $strResponse .= ",\"LongMax\":\"" . $valor->max_length . "\"\n";
                    $strResponse .= ",\"Long\":\"" . $valor->length . "\"\n";
                    $strResponse .= ",\"NumberCharSet\":\"" . $valor->charsetnr . "\"\n";
                    $strResponse .= ",\"Flags\":\"" . $valor->flags . "\"\n";
                    $strResponse .= ",\"FormType\":\"" . $frmType . "\"\n";
                    $strResponse .= ",\"SubType\":\"\"\n";
                    $strResponse .= ",\"MultipleValues\":false\n";
                    $strResponse .= ",\"PackType\":\"\"\n";
                    $strResponse .= ",\"Label\":\"" . $valor->name . "\"\n";
                    $strResponse .= ",\"PK\":\"" . $PK . "\"\n";
                    $strResponse .= ",\"AI\":\"" . $AI . "\"\n";
                    $strResponse .= ",\"TableRel\":\"\"\n";
                    $strResponse .= ",\"FieldRel\":\"\"\n";
                    $strResponse .= ",\"FieldDisplay\":\"\"\n";
                    $strResponse .= ",\"ChildTable\":\"\"\n";
                    $strResponse .= ",\"IdParent\":\"\"\n";
                    $strResponse .= ",\"Events\":[]\n";
                    $strResponse .= ",\"ChildDisplay\":\"\"\n";
                    $strResponse .= ",\"UseCombo\":\"\"\n";
                    $strResponse .= ",\"Validation\":\"\"\n";
                    $strResponse .= ",\"ShowInList\":true\n";
                    $strResponse .= ",\"ShowInEdit\":" . ($AI ? "false" : "true") . "\n";
                    $strResponse .= ",\"ShowInCreate\":" . ($AI ? "false" : "true") . "\n";
                    $strResponse .= ",\"ShowInDetails\":\"\"\n";
                    $strResponse .= ",\"ReadOnly\":\"\"\n";
                    $strResponse .= ",\"Hidden\":false\n";
                    $strResponse .= ",\"Format\":\"\"\n";
                    $strResponse .= ",\"Width\":\"\"\n";
                    $strResponse .= ",\"Height\":\"\"\n";
                    if ($valor->type == 254) {
                        $enum = array();
                        $Vals = $this->get_set_values($filatables[0], $valor->name);
                        //echo "\n ".$filatables[0]." -> ".$valor->name;

                        if ($Vals) {
                            for ($i = 0; $i < count($Vals); $i++) {
                                $enum[] = array("Label" => $Vals[$i], "Value" => $Vals[$i]);
                            }
                            print_r($Vals);
                            $strResponse .= ",\"Values\":" . json_encode($enum) . "\n";
                        } else {
                            $strResponse .= ",\"Values\":[]\n";
                        }
                    } else {
                        $strResponse .= ",\"Values\":[]\n";
                    }
                    $strResponse .= ",\"ViewIcon\":\"\"\n";
                    $strResponse .= ",\"IconValues\":\"\"\n";
                    $strResponse .= ",\"FieldDbType\":\"" . $valor->type . "\"}";
                    if ($c2 != count($fields)) {
                        $strResponse .= ",";
                    }
                }
                $strResponse .= "]";
                $c = 0;
            }
        }

        $strResponse .= "}]}";
        return $strResponse;
    }



    public function __construct()
    {
        //parent::__construct($this::readStructure());
        //$this::saveDbStrucuture("dbStructure.json");
    }

    /*
//$db  = new readStructure();
$db2 = new dbStructure("");
$db2->loadStructure("dbStructure.json");
$tbl = $db2->getTableProperties("clientes");
$myclass = new Model();
foreach($tbl->fields as $fld){
    echo "<br>[".$fld->FieldName."]";
    $myclass->$fld->$f=$v;
    foreach($fld as $f=>$v) {
        echo "<br> &nbsp;&nbsp;─>$f :" . $v;
        $myclass->$fld->$f = $v;
    }
*/
}
