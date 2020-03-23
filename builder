#!/usr/bin/env php
<?php
//
include  "CRUDBuilder/readStructure.php";
define('APP_PATH','app/');
define('RESOURCES_PATH','resources/');
define('CONTROLLER_PATH',APP_PATH.'Http/Controllers/');
define('VIEWS_PATH',RESOURCES_PATH.'views/');
define('ROUTES_PATH','routes/');

//Seccion de Variables
$jsonConfig=null;


$parameters=array();
foreach($argv as $arg){
  if (strpos($arg, "=")){
   $parameters[]=explode("=",$arg);
  }
    else{
     $parameters[]=$arg;
    }
}


cls();
logo();
$Comandos=array();
function parse($parameters){
  global $Comandos;
  foreach ($parameters as $param) {
    if (is_array($param) ){
      //$subCommand=explode("=",$param);
      $id=$param[0];
      $val=explode(",",$param[1]);
      $Comandos[$id]=$val;
        //print_r($id);
        //print_r($val);
    }
  else{
      $Comandos[$param];
      echo "\n Comando :".$param;
  }
  }
}

function cls()
{
    print("\033[2J\033[;H");
}

function Logo(){
echo "\n";
echo "\n██╗  ██╗██████╗  ██████╗ ███████╗ ██████╗ ██╗     ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗███████╗";
echo "\n██║  ██║██╔══██╗██╔════╝ ██╔════╝██╔═══██╗██║     ██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝";
echo "\n███████║██████╔╝██║  ███╗███████╗██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║███████╗";
echo "\n██╔══██║██╔══██╗██║   ██║╚════██║██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║";
echo "\n██║  ██║██║  ██║╚██████╔╝███████║╚██████╔╝███████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║███████║";
echo "\n╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝";
echo "\n";
echo "\n";
echo "\n LARAVEL 7.0";
echo "\n   ____ ____  _   _ ____                                    _             ";
echo "\n  / ___|  _ \| | | |  _ \    __ _  ___ _ __   ___ _ __ __ _| |_ ___  _ __ ";
echo "\n | |   | |_) | | | | | | |  / _` |/ _ \ '_ \ / _ \ '__/ _` | __/ _ \| '__|";
echo "\n | |___|  _ <| |_| | |_| | | (_| |  __/ | | |  __/ | | (_| | || (_) | |   ";
echo "\n  \____|_| \_\\\\___/|____/   \__, |\___|_| |_|\___|_|  \__,_|\__\___/|_|   ";
echo "\n                            |___/                                         ";
echo "\n";
echo "\n ";

}

function loadJsonConfig($filename){
  /*
  echo "\nCargar archivo JSON con configuracion ? (s,N)";
  $loadjsonfile = stream_get_line(STDIN, 1024, PHP_EOL);
  if (strtoupper($loadjsonfile)=='S'){
    echo "\nTeclea la ubicación del archivo JSON unto con el nombre :";
    $dir=readline();
    echo "\n Leyendo Archivo JSON desde $dir ";
    if (file_exists($dir)){
      $jsonConfig=file_get_contents($dir);
       }
      else{
      echo "\nEl archivo no existe o no esta en la ubicacion";
      exit(1);
      }
  }
  */
    if (file_exists($dir)){
      $jsonConfig=file_get_contents($dir);
       }
      else{
        echo "\nEl archivo no existe o no esta en la ubicacion";
        exit(1);
      }

}

function GenRoutesWEB($ModelName){
  $code = "\n // RUTAS WEB DEL MODELO ".$ModelName;
  $code .= "\nRoute::get('/".$ModelName."','".ucfirst(str_replace("_","",$ModelName))."Controller@index');";
  $code .= "\nRoute::post('/".$ModelName."','".ucfirst(str_replace("_","",$ModelName))."Controller@store');";
  $code .= "\nRoute::get('/".ucfirst(str_replace("_","",$ModelName))."/create','".ucfirst(str_replace("_","",$ModelName))."Controller@create');";
  $code .= "\nRoute::put('/".ucfirst(str_replace("_","",$ModelName))."/edit/{id}','".ucfirst(str_replace("_","",$ModelName))."Controller@update');";
  $code .= "\nRoute::delete('/".ucfirst(str_replace("_","",$ModelName))."/delete/{id}','".ucfirst(str_replace("_","",$ModelName))."Controller@destroy');";
  file_put_contents(ROUTES_PATH."web.php", $code, FILE_APPEND | LOCK_EX);

}

function GenControler($ControllerName){
 $code = "\n<?php";
 $code .= "\n";
 $code .="namespace App\Http\Controllers;\n";
 $code .="\n";
 $code .="use App\\".ucfirst(str_replace("_","",$ControllerName)).";\n";
 $code .="use Illuminate\Http\Request;\n";
 $code .="\n";
 $code .="class ".ucfirst(str_replace("_","",$ControllerName))."Controller extends Controller\n";
 $code .="{\n";
 $code .="   /**\n";
 $code .="    * Display a listing of the resource.\n";
 $code .="    *\n";
 $code .="    * @return \Illuminate\Http\Response\n";
 $code .="    */\n";
 $code .="   public function index()\n";
 $code .="   {\n";
 $code .="    \$".ucfirst(str_replace("_","",$ControllerName))."s = ".ucfirst(str_replace("_","",$ControllerName))."::paginate(10);\n";
 $code .="       return wiew('".$ControllerName.".index')->with(['".ucfirst(str_replace("_","",$ControllerName))."s',\$".ucfirst(str_replace("_","",$ControllerName))."s]);\n";
 $code .="   }\n";
 $code .="\n";
 $code .="   /**\n";
 $code .="    * Show the form for creating a new resource.\n";
 $code .="    *\n";
 $code .="    * @return \Illuminate\Http\Response\n";
 $code .="    */\n";
 $code .="   public function create()\n";
 $code .="   {\n";
 $code .="       \n";
 $code .="   }\n";
 $code .="\n";
 $code .="   /**\n";
 $code .="    * Store a newly created resource in storage.\n";
 $code .="    *\n";
 $code .="    * @param  \Illuminate\Http\Request  \$request\n";
 $code .="    * @return \Illuminate\Http\Response\n";
 $code .="    */\n";
 $code .="   public function store(Request \$request)\n";
 $code .="   {\n";
 $code .="       //\n";
 $code .="   }\n";
 $code .="\n";
 $code .="   /**\n";
 $code .="    * Display the specified resource.\n";
 $code .="    *\n";
 $code .="    * @param  \App\ ".str_replace("_","",$ControllerName)."\n";
 $code .="    * @return \Illuminate\Http\Response\n";
 $code .="    */\n";
 $code .="   public function show(\$id)\n";
 $code .="   {\n";
 $code .="       //\n";
 $code .="   }\n";
 $code .="\n";
 $code .="   /**\n";
 $code .="    * Show the form for editing the specified resource.\n";
 $code .="    *\n";
 $code .="    * @param  \App\ ".str_replace("_","",$ControllerName).'  \n';
 $code .="    * @return \Illuminate\Http\Response\n";
 $code .="    */\n";
 $code .="   public function edit(\$id)\n";
 $code .="   {\n";
 $code .="       //\n";
 $code .="   }\n";
 $code .="\n";
 $code .="   /**\n";
 $code .="    * Update the specified resource in storage.\n";
 $code .="    *\n";
 $code .="    * @param  \Illuminate\Http\Request  \$request\n";
 $code .="    * @param  \App\ ".str_replace("_","",$ControllerName)."\n";
 $code .="    * @return \Illuminate\Http\Response\n";
 $code .="    */\n";
 $code .="   public function update(Request \$request, \$id)\n";
 $code .="   {\n";
 $code .="       //\n";
 $code .="   }\n";
 $code .="\n";
 $code .="   /**\n";
 $code .="    * Remove the specified resource from storage.\n";
 $code .="    *\n";
 $code .="    * @param  \App\ ".str_replace("_","",$ControllerName)."\n";
 $code .="    * @return \Illuminate\Http\Response\n";
 $code .="    */\n";
 $code .="   public function destroy(\$id)\n";
 $code .="   {\n";
 $code .="       //\n";
 $code .="   }\n";
 $code .="}\n";
 $code .="  \n";
 return $code;
}

function genModel($ModelName)
{
    $code ="\n<?php";
    $code .="\n";
    $code .="\nnamespace App;";
    $code .="\n";
    $code .="\nuse Illuminate\Database\Eloquent\Model;";
    $code .="\n";
    $code .="\nclass " . ucfirst(str_replace("_","",$ModelName)) . " extends Model";
    $code .="\n{";
    $code .="\n    protected \$table='".$ModelName."';";
    $code .="\n}";
    $code .="\n}";
    return $code;
}

function GenViewIndex($ModelName,$fields){
    $code  ="\n <?php";
    $code .="\n @extends('layouts.admin')";
    $code .="\n @section('contenido')\n";
    $code .="\n <table class=\"table table-bordered table-striped table-sm\">";
    $code .="\n        <thead>";
    $code .="\n        <tr>";
    $code .="\n            <th><i class=\"fas fa-toolbox\"></i></th>";
    foreach ($fields as $fld) {
        $code .= "\n            <th>" . $fld->FieldName . "</th>";
    }
    $code .="\n        </tr>";
    $code .="\n      </thead>";
    $code .="\n        <tbody>";
    $code .="\n    @foreach(\$".ucfirst(str_replace("_","",$ModelName))." as \$row)";
    $code .="\n            <tr>";
    $code .="\n                <td>";
    $code .="\n                    <a href=\"/encuesta/edit/{{\$row->id}}\" title=\"Editar ".str_replace("_","",$ModelName)."\" class=\"btn btn-xs btn-outline-primary\"><i class=\"fas fa-edit\"></i></a>";
    $code .="\n                    <a href=\"#\" class=\"btn btn-xs btn-outline-danger\" title=\"Borrar ".$ModelName."\" onclick=\"delete".str_replace("_","",$ModelName)."({{\$row->id}})\"><i class=\"fas fa-trash-alt\"></i></a>";
    $code .="\n                </td>";
    foreach ($fields as $fld) {
        $code .="\n                <td>{{\$row->".$fld->FieldName."}}</td>";
    }
    $code .="\n           </tr>";
    $code .="\n    @endforeach";
    $code .="\n        </tbody>";
    $code .="\n    </table>";
    $code .="\n    <script>";
    $code .="\nfunction delete".ucfirst(str_replace("_","",$ModelName))."(id){";
    $code .="\n            Swal.fire({";
    $code .="\n                title: 'Seguro de borrar encuesta?',";
    $code .="\n                text: 'No podrá revertir eso!',";
    $code .="\n                icon: 'warning',";
    $code .="\n                showCancelButton: true,";
    $code .="\n                confirmButtonColor: '#3085d6',";
    $code .="\n                cancelButtonColor: '#d33',";
    $code .="\n                confirmButtonText: 'Si, borrarla!',";
    $code .="\n                cancelButtonText: 'Cancelar'";
    $code .="\n            }).then((result) => {";
    $code .="\n                if (result.value) {";
    $code .="\n                    \$.post('/".str_replace("_","",$ModelName)."/delete/'+id,{\"_token\": \$('meta[name=\"csrf_token\"]').attr('content'),\"_method\":\"delete\"},function(){";
    $code .="\n                        Swal.fire(";
    $code .="\n                            'Borrado!',";
    $code .="\n                            'Encuesta borrada.',";
    $code .="\n                            'success'";
    $code .="\n                        )";
    $code .="\n                    })";
    $code .="\n                }";
    $code .="\n            })";
    $code .="\n        }";
    $code .="\n    </script>";
    $code .="\n    @endsection";
    $code .="\n}";
    return $code;
}

function GenViewEdit($ModelName,$fields){
$code  = "\n<?php";
$code .="\n@extends('layout.admin')";
$code .="\n@section('contenido')";
$code .="\n<div class=\"row\">";
$code .="\n<div class=\"col-md-12 margin-tb\">";
$code .="\n<div class=\"pull-left\">";
$code .="\n<h2>Editar ".$ModelName."</h2>";
$code .="\n</div>";
$code .="\n<div class=\"pull-right\">";
$code .="\n<a class=\"btn btn-primary\" href=\"{{ route('".$ModelName.".index') }}\"> Regresar</a>";
$code .="\n</div>";
$code .="\n</div>";
$code .="\n</div>";
$code .="\n@if (\$errors->any())";
$code .="\n<div class=\"alert alert-danger\">";
$code .="\n<strong>Whoops!</strong> Hay error en loa entrada<br><br>";
$code .="\n<ul>";
$code .="\n    @foreach (\$errors->all() as \$error)";
$code .="\n<li>\{\{ \$error \}\}</li>";
$code .="\n    @endforeach";
$code .="\n</ul>";
$code .="\n</div>";
$code .="\n@endif";
$code .="\n<form action=\"{{ route('".$ModelName.".update',\$".ucfirst(str_replace("_","",$ModelName))."->id) }}\" method=\"POST\">";
$code .="\n@csrf";
$code .="\n@method('PUT')";
$code .="\n<div class=\"row\">";
foreach($fields as $fld) {
    //if ($fld->FormType="Text")
    {
        $code .= "\n<div class=\"form-group\">";
        $code .= "\n<label for=\"".$fld->FieldName."\" class=\"col-sm-4 control-label\">" . $fld->FieldName . "</label>";
        $code .= "\n<div class=\"col-sm-2\">";
        $code .= "\n<input type=\"text\" name=\"blog_title\" value=\"{{ \$" . ucfirst(str_replace("_","",$ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"Name\">";
        $code .= "\n</div>";
        $code .="\n</div>";
    }
}

$code .="\n<button type=\"submit\" class=\"btn btn-primary\">Submit</button>";
$code .="\n</div>";
$code .="\n</div>";
$code .="\n</form>";
$code .="\n@endsection";
return  $code;
}



function sign(){
echo "\n---------------------------------------------------------------------";
echo "\n┌─┐┌─┐┬ ┬┬  ┌─┐ ┬ ┬┌─┐┬─┐┌┐┌┌─┐┌┐┌┌┬┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐┬┬   ┌─┐┌─┐┌┬┐";
echo "\n└─┐├─┤│ ││  │ │ ├─┤├┤ ├┬┘│││├─┤│││ ││├┤ ┌─┘│└┘│ ┬│││├─┤││   │  │ ││││";
echo "\n└─┘┴ ┴└─┘┴─┘└─┘o┴ ┴└─┘┴└─┘└┘┴ ┴┘└┘─┴┘└─┘└─┘└──└─┘┴ ┴┴ ┴┴┴─┘o└─┘└─┘┴ ┴";
echo "\n---------------------------------------------------------------------";
echo "\n";
picture();
}

function picture(){
echo "\n                                @@@@&&@&@&&&%*";
echo "\n                            %@@@&&@@@@&@@@@@@@@@&";
echo "\n                          &@@@&&@@@@@@@@@@@@@@@@@@@&";
echo "\n                        &@&@&@@@@@@@@@@@@@@@@@@@@@@@@#";
echo "\n                      *@@&@&&&&%%#####%%#%#%%%&&&&@@@@&";
echo "\n                     ,&@&@&&##(((((((((########%%%&&&@@&";
echo "\n                     /@&%%###((################%%%%&@@@@%  ";
echo "\n                    .&&&%%####((((/((((((((###%%%%%%&@@@&.";
echo "\n                     &&&%&##&&@&@&&&&#((#&&&%%#%%&&&%%@@% ";
echo "\n                     /&&&((%#%%&%&&%###(#%&&/#@#&&%%%%%@(";
echo "\n                     *&&#(###############%&%%#%%%%%%%%%&%@";
echo "\n                    ,((%#(#(((((((((((((##%%########%%%&%&";
echo "\n                     (/%#(((((((((##(((/(%##&#(######%%#@";
echo "\n                      ((#(((((((##((###%%&&%#######%#%%%#";
echo "\n                      (((((((((%%%&%%%##&@@&&%####%%%%%";
echo "\n                       .((((((((%&&#(**/**/#@@&%###%%%%%";
echo "\n                        ((((###%%((((((####%%%%%##%%%%%";
echo "\n                         (##(#####(((%&@&&###%%%%%%%%%";
echo "\n                          /####%%%#%#%@@%&%%&&&%%%%%#";
echo "\n                          ../(##&&%&&&&&@&&@&&%%&%%(/";
echo "\n                  ,,,...,... ../###%&&&@&&&&&&%%///**,";
echo "\n          .,,,,......,.... .. ...../###%%%%(/****,**,*////*.";
echo "\n.,.........,,.......... .. .. .. *%%%%%#,.,**,**,,**/**********,";
echo "\n.....,,..... ...,... ..,.. .. ..*%&#%%(%%(%%%*,,.,**,/*,,,,,,,,,,,,,,,,,";
echo "\n............... . .... ..... */*%%&%%%#%%#%&&&&/,,,,*,,.,.,,.,,,,,,,,,,,,,*,*";
echo "\n . .....,... .... .. .....,......%&&%%%%%%&&&%,.,,,,.,,.,,,,.,,,,,,,,,.,,,,.*,**";
echo "\n.. .... .... ....... . .. .....,,.%&&%%%%%%&%,,,,,,,.,,.,.,,.,,,,.,.,,.,,,,.,.**";
echo "\n.  . .. .... . .. ....... ........,%&%%%%%(&..........,.,.,,.,.,,.,.,,.,..,,,.,,";
echo "\n. .. .. . .. . ..... . .. ........./&%%(%%%/......,.....,.,,.,.,,.,.,,.,..,*,.,.";
echo "\n                        █▀ ▄▀█ █░█ █░░ █▀█ █░█ █▀▄ ▀█                            ";
echo "\n                        ▄█ █▀█ █▄█ █▄▄ █▄█ █▀█ █▄▀ █▄                            ";
echo "\n";
}

function help(){
    echo "\n Builder for Laravel 7.0 by Saulo Hernandez O.";
    echo "\n ------------------------------------------------";
    echo "\n Command :  php builder |parameter #1 parameter #2 parameter #3|";
    echo "\n Paramaters : ";
    echo "\n        configfile=file.json file with the structure en database";
    echo "\n        tables=| All | table 1,table 2,...,table n|  Tables what you want generate";
    echo "\n        make=|controller|,|model|,|view|,route| generate Controllers, Models, View and/or routes of tables\n";
}


function ENV_Parser($fileContent){
   $Content = explode("\n",$fileContent);
   $ENV=array();
   foreach($Content as $con){
     $ENV[substr($con,0,strpos($con,"="))]=substr($con,strpos($con,"=")+1); 
   }
   return $ENV;
}

//$Comandos["gen"]=explode(",","Models,Controller,Views");
//print_r($parameters);
unset($parameters[0]);
parse($parameters);
//print_r($Comandos);
if (count($Comandos)==0){
  help();
  sign();
  exit(2);
}
elseif(isset($Comandos["configfile"][0])){
  echo "\n ".$Comandos["configfile"][0];
   $jsonConfig=json_decode(file_get_contents($Comandos["configfile"][0],FILE_USE_INCLUDE_PATH));
}
else{
     $dbconf = ENV_Parser(file_get_contents(".env"));
    echo "\n No se encontro archivo de configuracion de la estructura de la base de datos....";
    echo "\n Generando estructura automaticamente de la Base de datos ".$dbconf["DB_DATABASE"]." en ".dbconf["DB_HOST"];
    echo "\n Leyendo informacion de el archico .env ....";
    $db     = new readStructure();
    $db->setDb($dbconf["DB_DATABASE"]);
    $db->setSrv($dbconf["DB_HOST"]);
    $db->setUsr($dbconf["DB_USERNAME"]);
    $db->setPass($dbconf["DB_PASSWORD"]);
    $jsonConfig = json_decode($db->readStructure());
    //print_r($jsonConfig);
}

  echo "\n Comenzando el proceso de Generación de codigo.....";
   sleep(3);
   foreach($jsonConfig->Tables as $tbl){
    sleep(2);
    foreach ($Comandos["make"] as $mk) {
      if (in_array($tbl->TableName,$Comandos["tables"]) and strtoupper($Comandos["tables"][0])!='ALL'){
        if (strtoupper($mk)=='CONTROLLER'){
           echo "\n Generando ".ucfirst($mk)." de la Tabla ".$tbl->TableName;
           $data = GenControler($tbl->TableName);
           $myfile = fopen("app/Http/Controllers/".ucfirst(str_replace("_","",$tbl->TableName)).'Controller.php', "w") or die("Unable to open file!");
          fwrite($myfile, $data);
          fclose($myfile);
        }
        if (strtoupper($mk)=='MODEL'){
           echo "\n Generando ".ucfirst($mk)." de la Tabla ".$tbl->TableName;
           $data = GenModel($tbl->TableName);
           $myfile = fopen("app/".ucfirst(str_replace("_","",$tbl->TableName)).'.php', "w") or die("Unable to open file!");
          fwrite($myfile, $data);
          fclose($myfile);
        }
       if (strtoupper($mk)=='VIEW'){
                echo "\n Generando ".ROUTEst($mk)." de la Tabla ".$tbl->TableName;

                mkdir('resources/views/'.$tbl->TableName);
                $data = GenViewIndex($tbl->TableName,$tbl->fields);

                $myfile = fopen('resources/views/'.str_replace("_","",$tbl->TableName).'/'.str_replace("_","",$tbl->TableName).'.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
            }
        if (strtoupper($mk)=='ROUTE'){
          GenRoutesWEB($tbl->TableName);
          echo "\n Agregando Routas del Modelo ".$tbl->TableName;
      }
    }
  else{
        if (strtoupper($mk)=='CONTROLLER'){
           echo "\n Generando ".ucfirst($mk)." de la Tabla ".$tbl->TableName;
           $data = GenControler($tbl->TableName);
           $myfile = fopen("app/Http/Controllers/".ucfirst(str_replace("_","",$tbl->TableName)).'Controller.php', "w") or die("Unable to open file!");
          fwrite($myfile, $data);
          fclose($myfile);
        }
        if (strtoupper($mk)=='MODEL'){
           echo "\n Generando ".ucfirst($mk)." de la Tabla ".$tbl->TableName;
           $data = GenModel($tbl->TableName);
           $myfile = fopen("app/".ucfirst(str_replace("_","",$tbl->TableName)).'.php', "w") or die("Unable to open file!");
          fwrite($myfile, $data);
          fclose($myfile);
        }
       if (strtoupper($mk)=='VIEW'){
                echo "\n Generando ".ucfirst($mk)." de la Tabla ".$tbl->TableName;
                if (!file_exists('resources/views/'.str_replace("_","",$tbl->TableName))){
                 mkdir('resources/views/'.str_replace("_","",$tbl->TableName));
               }
                $data = GenViewIndex($tbl->TableName,$tbl->fields);

                $myfile = fopen('resources/views/'.str_replace("_","",$tbl->TableName).'/'.str_replace("_","",$tbl->TableName).'.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
            }
        if (strtoupper($mk)=='ROUTE'){
          GenRoutesWEB($tbl->TableName);
          echo "\n Agregando Routas del Modelo ".$tbl->TableName;
      }            

  }
  
    }
  
}

sign();