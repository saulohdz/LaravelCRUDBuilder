#!/usr/bin/env php
<?php
$dir = '';
include "CRUDBuilder/readStructure.php";
const   APP_PATH = 'app/',
APP_MODELS = APP_PATH . '/Models/',
RESOURCES_PATH = 'resources/',
CONTROLLER_PATH = APP_PATH . 'Http/Controllers/',
VIEWS_PATH = RESOURCES_PATH . 'views/',
ROUTES_PATH = 'routes/';

//Seccion de Variables
$jsonConfig = null;


$parameters = array();
foreach ($argv as $arg) {
    if (strpos($arg, ":")) {
        $parameters[] = explode(":", $arg);
    } else {
        $parameters[] = $arg;
    }
}
//print_r($parameters);

cls();
logo();
$Comandos = array();
$camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
function auto_increment($dbtype){
    switch ($dbtype) {
        case 'mysql':return ' bigint PRIMARY KEY AUTO_INCREMENT ';
        case 'pgsql':return ' bigserial primary key';
        default :
          return ' AUTO_INCREMENT ';
    }
}
function parse($parameters)
{
    global $Comandos;
    foreach ($parameters as $param) {
        if (is_array($param)) {
            //$subCommand=explode("=",$param);
            $id = $param[0];
            $val = explode(",", $param[1]);
            $Comandos[strtoupper($id)] = $val;
            //print_r($id);
            //print_r($val);
        } else {
            $Comandos[$param];
            echo "\n Comando :" . $param;
        }
    }
}

function formatPrint(array $format = [], string $text = '')
{
    $codes = [
        'bold' => 1,
        'italic' => 3, 'underline' => 4, 'strikethrough' => 9,
        'black' => 30, 'red' => 31, 'green' => 32, 'yellow' => 33, 'blue' => 34, 'magenta' => 35, 'cyan' => 36, 'white' => 37,
        'blackbg' => 40, 'redbg' => 41, 'greenbg' => 42, 'yellowbg' => 44, 'bluebg' => 44, 'magentabg' => 45, 'cyanbg' => 46, 'lightgreybg' => 47
    ];
    $formatMap = array_map(function ($v) use ($codes) {
        return $codes[$v];
    }, $format);
    echo "\e[" . implode(';', $formatMap) . 'm' . $text . "\e[0m";
}

function formatPrintLn(array $format = [], string $text = '')
{
    formatPrint($format, $text);
    echo "\r\n";
}


function cls()
{
    print("\033[2J\033[;H");
}

function Logo()
{
    echo "\n";
    echo "\n\e[33m██╗  ██╗██████╗  ██████╗ ███████╗ ██████╗ ██╗     ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗███████╗";
    echo "\n\e[33m██║  ██║██╔══██╗██╔════╝ ██╔════╝██╔═══██╗██║     ██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝";
    echo "\n\e[33m███████║██████╔╝██║  ███╗███████╗██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║███████╗";
    echo "\n\e[33m██╔══██║██╔══██╗██║   ██║╚════██║██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║";
    echo "\n\e[33m██║  ██║██║  ██║╚██████╔╝███████║╚██████╔╝███████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║███████║";
    echo "\n\e[33m╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝";
    echo "\n";
    echo "\n";
    echo "\n\e[34m LARAVEL 7.0";
    echo "\n\e[34m   ____ ____  _   _ ____                                    _             ";
    echo "\n\e[34m  / ___|  _ \| | | |  _ \    __ _  ___ _ __   ___ _ __ __ _| |_ ___  _ __ ";
    echo "\n\e[34m | |   | |_) | | | | | | |  / _` |/ _ \ '_ \ / _ \ '__/ _` | __/ _ \| '__|";
    echo "\n\e[34m | |___|  _ <| |_| | |_| | | (_| |  __/ | | |  __/ | | (_| | || (_) | |   ";
    echo "\n\e[34m  \____|_| \_\\\\___/|____/   \__, |\___|_| |_|\___|_|  \__,_|\__\___/|_|   ";
    echo "\n\e[34m                            |___/                                         ";
    echo "\n";
    echo "\n[30m";
}

function LogoInFile()
{
    $code = "\n";
    $code .= "\n██╗  ██╗██████╗  ██████╗ ███████╗ ██████╗ ██╗     ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗███████╗";
    $code .= "\n██║  ██║██╔══██╗██╔════╝ ██╔════╝██╔═══██╗██║     ██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝";
    $code .= "\n███████║██████╔╝██║  ███╗███████╗██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║███████╗";
    $code .= "\n██╔══██║██╔══██╗██║   ██║╚════██║██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║";
    $code .= "\n██║  ██║██║  ██║╚██████╔╝███████║╚██████╔╝███████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║███████║";
    $code .= "\n╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝";
    $code .= "\n";
    $code .= "\n";
    $code .= "\n LARAVEL 10.0";
    $code .= "\n   ____ ____  _   _ ____                                    _             ";
    $code .= "\n  / ___|  _ \| | | |  _ \    __ _  ___ _ __   ___ _ __ __ _| |_ ___  _ __ ";
    $code .= "\n | |   | |_) | | | | | | |  / _` |/ _ \ '_ \ / _ \ '__/ _` | __/ _ \| '__|";
    $code .= "\n | |___|  _ <| |_| | |_| | | (_| |  __/ | | |  __/ | | (_| | || (_) | |   ";
    $code .= "\n  \____|_| \_\\\\___/|____/   \__, |\___|_| |_|\___|_|  \__,_|\__\___/|_|   ";
    $code .= "\n                            |___/                                         ";
    $code .= "\n";
    $code .= "\n ";
    return $code;
}

function loadJsonConfig($filename)
{

    //echo "\nCargar archivo JSON con configuracion ? (s,N)";
    //$loadjsonfile = stream_get_line(STDIN, 1024, PHP_EOL);
    //if (strtoupper($loadjsonfile)=='S'){
    //  echo "\nTeclea la ubicación del archivo JSON unto con el nombre :";
    //  $dir=readline();
    //  echo "\n Leyendo Archivo JSON desde $dir ";
    // if (file_exists($dir)){
    //    $jsonConfig=file_get_contents($dir);
    //     }
    //    else{
    //    echo "\nEl archivo no existe o no esta en la ubicacion";
    //    exit(1);
    //    }
    //}

    if (file_exists($dir)) {
        $jsonConfig = file_get_contents($dir);
    } else {
        echo "\nEl archivo no existe o no esta en la ubicación";
        exit(1);
    }
}

function GenRoutesWEB($ModelName)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
    $code = "\n";//use App\\Http\\Controllers\\" . $camelCaseName . "Controller;";
    $code .= "\n // RUTAS WEB DEL MODELO " . $ModelName;
    $code .= "\nRoute::get('/" . $camelCaseName . "',[App\\Http\\Controllers\\" . $camelCaseName . "Controller::class,'index'])->name('" . $ModelName . ".index');";
    $code .= "\nRoute::post('/" . $camelCaseName . "/create',[App\\Http\\Controllers\\" . $camelCaseName . "Controller::class,'store'])->name('" . $ModelName . ".store');";
    $code .= "\nRoute::get('/" . $camelCaseName . "/create',[App\\Http\\Controllers\\" . $camelCaseName . "Controller::class,'create'])->name('" . $ModelName . ".create');";
    $code .= "\nRoute::get('/" . $camelCaseName . "/edit/{id}',[App\\Http\\Controllers\\" . $camelCaseName . "Controller::class,'edit'])->name('" . $ModelName . ".edit');";
    $code .= "\nRoute::get('/" . $camelCaseName . "/{id}',[App\\Http\\Controllers\\" . $camelCaseName . "Controller::class,'show'])->name('" . $ModelName . ".show');";
    $code .= "\nRoute::patch('/" . $camelCaseName . "/edit/{id}',[App\\Http\\Controllers\\" . $camelCaseName . "Controller::class,'update'])->name('" . $ModelName . ".update');";
    $code .= "\nRoute::delete('/" . $camelCaseName . "/delete/{id}',[App\\Http\\Controllers\\" . $camelCaseName . "Controller::class,'destroy'])->name('" . $ModelName . ".destroy');";
    file_put_contents(ROUTES_PATH . "webroutes.php", $code, FILE_APPEND | LOCK_EX);
}

function GenController($ControllerName, $fields)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ControllerName)));
    
    $code = "<?php";
    $code .= "\n";
    $code .= "namespace App\Http\Controllers;\n";
    $code .= "\n";
    $code .= "\n use Illuminate\Support\Facades\Validator;";
    $code .= "\n use Illuminate\Http\Request;";
    $code .= "\n use App\\Models\\" . $camelCaseName. ";";
    $Models = array();
    foreach ($fields as $fld) {
        if (!in_array($fld->TableRel, $Models)) {
            if ($fld->FormType == 'Relation') {
                $Models[] = $fld->TableRel;
                //if ($fld->TableRel != ucfirst(str_replace("_", "", $ControllerName))) {

                    $code .= "\n use App\\Models\\" . ucfirst(str_replace("_", " ", $fld->TableRel)) . ";";
                //}
            }
        }
    }
    $code .= "\n use Illuminate\Http\Request;";
    $code .= "\n";
    $code .= "\nclass " . $camelCaseName. "Controller extends Controller";
    $code .= "\n{";
    $code .= "\n   /**";
    $code .= "\n    * Display a listing of the resource.";
    $code .= "\n    *";
    $code .= "\n    * @return \Illuminate\Http\Response";
    $code .= "\n    */\n";
    $code .= "\n   public function index()";
    $code .= "\n   {";
    $code .= "\n    \$" . $ControllerName . " = " . ucfirst($camelCaseName) . "::paginate(10);";
    $code .= "\n       return view('" . $camelCaseName . ".index')->with(['" . $camelCaseName. "List'=>\$" . $ControllerName . ",'Title'=>'Lista de " . $ControllerName . "s','ActiveMenu'=>'" . $ControllerName . "s']);";
    $code .= "\n   }";
    $code .= "\n";
    $code .= "\n   /**";
    $code .= "\n    * Show the form for creating a new resource.";
    $code .= "\n    *\n";
    $code .= "\n    * @return \Illuminate\Http\Response";
    $code .= "\n    */";
    $code .= "\n   public function create()";
    $code .= "\n   {";
    $with = "";
    $Models = array();
    foreach ($fields as $fld) {
        if (!in_array($fld->TableRel, $Models)) {
            if ($fld->FormType === 'Relation') {
                $Models[] = $fld->TableRel;
                $code .= "\n    \$" . ucfirst(str_replace("_", "", $fld->TableRel)) . "s = " . ucfirst(str_replace("_", "", $fld->TableRel)) . "::all();";
                $with .= ",'" . ucfirst(str_replace("_", "", $fld->TableRel)) . "List'=>\$" . ucfirst(str_replace("_", "", $fld->TableRel)) . "s";
            }
        }
    }

    $code .= "\n     return view('" . $camelCaseName . ".create')->with([" . (substr($with, 1) != "" ? substr($with, 1) . "," : "") . "'Title'=>'Lista de " . $ControllerName . "','ActiveMenu'=>'" . $ControllerName . "']);";
    $code .= "\n   }";
    $code .= "\n";
    $code .= "\n   /**";
    $code .= "\n    * Store a newly created resource in storage.";
    $code .= "\n    *\n";
    $code .= "\n    * @param  \Illuminate\Http\Request  \$request";
    $code .= "\n    * @return \Illuminate\Http\Response";
    $code .= "\n    */";
    $code .= "\n   public function store(Request \$request)";
    $code .= "\n   {";
    //$code .= "\n    \$" . $ControllerName . " = " . ucfirst($camelCaseName.) . "::create(\$request->all());";
    $code .= "\n  \$validator = Validator::make(\$request->all(), [";
    $validation = "";
    foreach ($fields as $fld) {
        if ($fld->ShowInCreate) {
            if (isset($fld->Validation) && $fld->Validation != "") {
                if ($validation == "") {
                    $validation .= "\n       '" . $fld->FieldName . "' => '" . $fld->Validation . "'";
                } else {
                    $validation .= "\n       ,'" . $fld->FieldName . "' => '" . $fld->Validation . "'";
                }
            }
        }
    }
    $code .= $validation;
    $code .= "\n   ]);";
    $code .= "\n if (\$validator->fails()) {";
    $code .= "\n  return back()";
    $code .= "\n     ->withErrors(\$validator)";
    $code .= "\n     ->withInput(\$request->input());";
    $code .= "\n}";
    $code .= "\n   \$" . $ControllerName . " = new " . ucfirst($camelCaseName) . ";";
    foreach ($fields as $fld) {
        if ($fld->ShowInCreate) {
            $code .= "\n     \$" . $ControllerName . "->" . $fld->FieldName . " = \$request->" . $fld->FieldName . ";";
        }
    }
    $code .= "\n    \$" . $ControllerName . "->save();";
    $code .= "\n   return redirect('/admin/" . $ControllerName . "');";
    $code .= "\n   }";
    $code .= "\n   ";
    $code .= "\n";
    //Gen Show by id
    $code .= "\n   /**";
    $code .= "\n    * Display the specified resource.";
    $code .= "\n    *";
    $code .= "\n    * @param  \App\ " . $camelCaseName . "";
    $code .= "\n    * @return \Illuminate\Http\Response";
    $code .= "\n    */";
    $code .= "\n   public function show(\$id)";
    $code .= "\n   {";
    $code .= "\n      if (\$id!='All') {";
    $code .= "\n        \$" . $ControllerName . " = " . ucfirst($camelCaseName) . "::find(\$id);";
    $code .= "\n      }";
    $code .= "\n      else{";
    $code .= "\n        \$" . $ControllerName . " = " . ucfirst($camelCaseName) . "::All();";
    $code .= "\n      }";
    $code .= "\n      return $" . $ControllerName . ";";
    $code .= "\n    }";
    $code .= "\n";
    $code .= "\n";
    $code .= "\n   /**";
    $code .= "\n    * Show the form for editing the specified resource.";
    $code .= "\n    *";
    $code .= "\n    * @param  \App\ " . $camelCaseName;
    $code .= "\n    * @return \Illuminate\Http\Response";
    $code .= "\n    */";
    $code .= "\n   public function edit(\$id)";
    $code .= "\n   {";
    $with = "";
    $Models = [];
    foreach ($fields as $fld) {
        if (!in_array($fld->TableRel, $Models)) {
            if ($fld->FormType === 'Relation') {
                $Models[] = $fld->TableRel;
                $code .= "\n    \$" . ucfirst(str_replace("_", "", $fld->TableRel)) . " = " . ucfirst(str_replace("_", "", $fld->TableRel)) . "::all();";
                $with .= ",'" . ucfirst(str_replace("_", "", $fld->TableRel)) . "List'=>\$" . ucfirst(str_replace("_", "", $fld->TableRel)) . "";
            }
        }
    }
    $code .= "\n     \$" . $camelCaseName. " = " . ucfirst($camelCaseName) . "::find(\$id);";
    $code .= "\n      return view('" . $ControllerName . ".edit')->with(['" . ucfirst($camelCaseName) . "'=>$" . $camelCaseName . $with . ",'Title'=>'Editar " . $ControllerName . "','ActiveMenu'=>'" . $ControllerName . "']);";
    $code .= "\n   }";
    $code .= "\n";
    $code .= "\n   /*";
    $code .= "\n    * Update the specified resource in storage";
    $code .= "\n    *";
    $code .= "\n    * @param  \Illuminate\Http\Request  \$request";
    $code .= "\n    * @param  \App\ " . $camelCaseName;
    $code .= "\n    * @return \Illuminate\Http\Response";
    $code .= "\n    */\n";
    $code .= "\n   public function update(Request \$request, \$id)";
    $code .= "\n   {";
    $code .= "\n  \$validator = Validator::make(\$request->all(), [";
    $validation = "";
    foreach ($fields as $fld) {
        if ($fld->ShowInCreate) {
            if (isset($fld->Validation) && $fld->Validation != "") {
                if ($validation == "") {
                    $validation .= "\n       '" . $fld->FieldName . "' => '" . $fld->Validation . "'";
                } else {
                    $validation .= "\n       ,'" . $fld->FieldName . "' => '" . $fld->Validation . "'";
                }
            }
        }
    }
    $code .= $validation;
    $code .= "\n   ]);";
    $code .= "\n   \$" . $ControllerName . " = " . ucfirst($camelCaseName) . "::find(\$id);";
    foreach ($fields as $fld) {
        if ($fld->ShowInEdit) {
            $code .= "\n     \$" . $ControllerName . "->" . $fld->FieldName . " = \$request->" . $fld->FieldName . ";";
        }
    }
    $code .= "\n if (\$validator->fails()) {";
    $code .= "\n  return back()";
    $code .= "\n     ->withErrors(\$validator->messages())";
    $code .= "\n     ->withInput(\$request->input());";
    $code .= "\n}";
    $code .= "\n    \$" . $ControllerName . "->update();";
    $code .= "\n   return redirect('/admin/" . $ControllerName . "');";
    $code .= "\n   }";
    $code .= "\n";
    $code .= "\n   /**";
    $code .= "\n    * Remove the specified resource from storage.";
    $code .= "\n    *\n";
    $code .= "\n    * @param  \App\models\\" . $camelCaseName;
    $code .= "\n    * @return \Illuminate\Http\Response\n";
    $code .= "\n    */";
    $code .= "\n   public function destroy(\$id)";
    $code .= "\n   {";
    $code .="\n      try {";    
    $code .= "\n      \$" . $camelCaseName . " = " . ucfirst($camelCaseName) . "::find(\$id);";
    $code .= "\n       \$" . $camelCaseName . "->delete();";
    $code .= "\n          return [\"Error \"=>0];";
    $code .= "\n       }catch(Exception \$e){";
    $code .= "\n           return [\"Error \"=>\$e->getCode(), \"Message\"=>\$e->getMessage()]; }";
    $code .= "\n       //return view('" . $camelCaseName.  ".index');";
    $code .= "\n   }";
    $code .= "\n}";
    $code .= "  \n";
    return $code;
}


function genModel($ModelName, $fields)
{
   // print_r ("FIELDS ".json_encode($fields));
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
    $code = "<?php";
    $code .= "\n";
    $code .= "\nnamespace App\Models;";
    $code .= "\n";
    $code .= "\nuse Illuminate\Database\Eloquent\Model;";
    $code .= "\n";
    $code .= "\nclass " . $camelCaseName . " extends Model";
    $code .= "\n{";
    $code .= "\n    protected \$table = '" . $ModelName . "';";
    $code .= "\n    protected \$primaryKey = '" . $fields[0]->FieldName . "';";
    $code .= "\n";
    $Models = array();
    foreach ($fields as $fld) {
        if (!in_array($fld->TableRel, $Models)) {
            //echo "entro 2 -> FOMTYPE =".$fld->FormType.' - is relation = '.$fld->FormType == 'Relation' || ($fld->FormType == 'List').' tableel fields not null = '.($fld->TableRel != '' && $fld->FieldRel != '' && $fld->FieldDisplay != '');
            if (($fld->FormType == 'Relation' || ($fld->FormType == 'List') && ($fld->TableRel != '' && $fld->FieldRel != '' && $fld->FieldDisplay != ''))) {
                //echo "entro 3";
                array_push($Models,$fld->TableRel);
                $code .= "\n public function REL_" . $fld->TableRel . "(){";
                $code .= "\n    return \$this->hasOne('\\App\\Models\\" . ucfirst(str_replace("_", "", $fld->TableRel)) . "','" . $fld->FieldRel . "','id');";
                $code .= "\n }\n\n";
            }
        }


    }
    $code .= "\n}";
    return $code;

}

function GenDeleteJS($ModelName)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName))); 
    $code = '\n  /* *************************************************/';
    $code .= '\n /* Funcion JS para Borrar el registro              */';
    $code .= '\n /* @parameter $id                                  */';
    $code .= '\n /* @return Error = array([\'Error\',\'Messages\']) */';
    $code .= '\n /* *************************************************/';
    $code .= '\n';
    $code .= "\nfunction delete_" . $camelCaseName . "(id){";
    $code .= "\n            Swal.fire({";
    $code .= "\n                title: 'Seguro de borrar " . $ModelName . "?',";
    $code .= "\n                text: 'No podrá revertir eso!',";
    $code .= "\n                icon: 'warning',";
    $code .= "\n                showCancelButton: true,";
    $code .= "\n                confirmButtonColor: '#3085d6',";
    $code .= "\n                cancelButtonColor: '#d33',";
    $code .= "\n                confirmButtonText: 'Si, borrarlo!',";
    $code .= "\n                cancelButtonText: 'Cancelar'";
    $code .= "\n            }).then((result) => {";
    $code .= "\n                if (result.value) {";
    $code .= "\n                    \$.post('/admin/" . $camelCaseName . "/delete/'+id,{\"_token\": \"{{@csrf_token()}}\",\"_method\":\"delete\"},function(){";
    $code .= "\n                        Swal.fire(";
    $code .= "\n                            'Borrado!',";
    $code .= "\n                            '" . $ModelName . " borrado.',";
    $code .= "\n                            'success'";
    $code .= "\n                        )";
    $code .= "\n                    })";
    $code .= "\n                }";
    $code .= "\n            })";
    $code .= "\n        }";

}

function GenEditJS($ModelName, $fields)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
    $code = '\n  /* *************************************************/';
    $code .= '\n /* Funcion JS para Editar un registro              */';
    $code .= '\n /* @parameter $id                                  */';
    $code .= '\n /* @return array  of ' . $ModelName . '                */';
    $code .= '\n /* *************************************************/';
    $code .= '\n';
    $code .= "\nfunction editar_" . $camelCaseName . "(id){";
    $code .= "\n                    \$.get('/admin/" . $camelCaseName . "/'+id,{},function(response){";
    foreach ($fields as $field) {
        $code .= "\n                         $(\"#" . $field . "_e\").val(response." . $field . ")";
    }
    $code .= "\n            })";
    $code .= "\n        }";
}


function GenViewIndex($ModelName, $fields)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
    $code = "";
    $code .= " @extends('layouts.admin')";
    $code .= "\n @section('contenido')\n";
    $code .= "<div class=\"row\"><button class=\"btn btn-success\" onclick=\"window.location.assign('/admin/" . $camelCaseName . "/create')\">Agregar</button></div>";
    $code .= "\n <table class=\"table table-bordered table-striped table-sm\">";
    $code .= "\n        <thead>";
    $code .= "\n        <tr id=\"row_{{ \$row->id }}\">";
    $code .= "\n            <th><i class=\"fas fa-toolbox\"></i></th>";
    foreach ($fields as $fld) {
        if ($fld->ShowInList) {
            $code .= "\n            <th>" . $fld->Label . "</th>";
        }
    }
    $code .= "\n        </tr>";
    $code .= "\n      </thead>";
    $code .= "\n        <tbody>";
    $code .= "\n    @foreach(\$" . $camelCaseName . "List as \$row)";
    $code .= "\n            <tr id=\"row_{{\$row->id}}\">";
    $code .= "\n                <td>";
    $code .= "\n                    <a href=\"/admin/" . $ModelName . "/edit/{{ \$row->id }}\" title=\"Editar " . $camelCaseName . "\" class=\"btn btn-xs btn-outline-primary\"><i class=\"fas fa-edit\"></i></a>";
    $code .= "\n                    <a href=\"#\" class=\"btn btn-xs btn-outline-danger\" title=\"Borrar " . $ModelName . "\" onclick=\"delete" . $camelCaseName . "({{ \$row->id }})\"><i class=\"fas fa-trash-alt\"></i></a>";
    $code .= "\n                </td>";
    foreach ($fields as $fld) {
        if ($fld->ShowInList) {
            if ($fld->FormType == 'Relation') {
                $code .= "\n                <td>{{ \$row->REL_" . $fld->TableRel . "->" . $fld->FieldDisplay . " }}</td>";
            } elseif ($fld->FormType == 'List' || $fld->FormType == 'Radio' || $fld->FormType == 'Check') {
                $code .= "\n@php";
                $code .= "\n \$Valores=json_decode('" . json_encode($fld->Values) . "');";
                $code .= "\n \$Icons=json_decode('" . json_encode($fld->IconValues) . "');";
                $code .= "\n foreach(\$Valores as \$i=>\$v){";
                $code .= "\n  if (\$v->Value==\$row->" . $fld->FieldName . "){";
                $code .= "\n    \$Etiqueta=\$v->Label;";
                $code .= "\n    \$Icon=\$Icons[\$i];";
                $code .= "\n    }";
                $code .= "\n  }";
                $code .= "\n @endphp";
                if ($fld->ViewIcon) {
                    $code .= "\n@php";
                    $code .= "\n foreach(\$Icons as \$I){";
                    $code .= "\n  if (\$I->Value==\$row->" . $fld->FieldName . "){";
                    $code .= "\n    \$Icon=\$I->Icon;";
                    $code .= "\n   }";
                    $code .= "\n }";
                    $code .= "\n @endphp";
                    $code .= "\n                <td>{{ \$Etiqueta }} <img src=\"{{ \$Icon }}\"></td>";
                } else {
                    $code .= "\n                <td>{{ \$Etiqueta }}</td>";
                }
            } else {
                $code .= "\n                <td>{{ \$row->" . $fld->FieldName . " }}</td>";
            }
        }
    }
    $code .= "\n           </tr>";
    $code .= "\n    @endforeach";
    $code .= "\n        </tbody>";
    $code .= "\n    </table>";
    $code .= "\n    <div class=\"row\">{{ \$" . $camelCaseName . "List->links() }}</div>";
    $code .= "\n    <script>";
    $code .= "\n";
    $code .= "\n    function delete" . $camelCaseName . "(id){";
    $code .= "\n            Swal.fire({";
    $code .= "\n                title: 'Seguro de borrar " . $ModelName . "?',";
    $code .= "\n                text: 'No podrá revertir eso!',";
    $code .= "\n                icon: 'warning',";
    $code .= "\n                showCancelButton: true,";
    $code .= "\n                confirmButtonColor: '#3085d6',";
    $code .= "\n                cancelButtonColor: '#d33',";
    $code .= "\n                confirmButtonText: 'Si, borrarlo!',";
    $code .= "\n                cancelButtonText: 'Cancelar'";
    $code .= "\n            }).then((result) => {";
    $code .= "\n                if (result.value) {";
    $code .= "\n                    \$.post('/admin/" . $camelCaseName . "/delete/'+id,{\"_token\":\"{{@csrf_token()}}\",\"_method\":\"delete\"},function(response){";
    $code .= "\n                      if (response.Error===0) { $(\"row_{{id}}\").remove()";
    $code .= "\n                        Swal.fire(";
    $code .= "\n                            'Borrado!',";
    $code .= "\n                            '" . $ModelName . " borrado.',";
    $code .= "\n                            'success'";
    $code .= "\n                        )} else{ Swal.fire('Ocurrio un error al borrar')";
    $code .= "\n                    })";
    $code .= "\n                }";
    $code .= "\n            })";
    $code .= "\n        }";
    $code .= "\n    </script>";
    $code .= "\n    @endsection";
    return $code;
}

function GenViewEdit($ModelName, $fields)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
    $jsCode = null;
    $code = "";
    $code .= "\n@extends('layouts.admin')";
    $code .= "\n@section('contenido')";
    $code .= "\n<div class=\"row\">";
    $code .= "\n<div class=\"col-md-12\">";
    $code .= "\n<div class=\"card\">";
    $code .= "\n<div class=\"card-header\">";
    $code .= "\n<h2 class=\"\">Editar " . $ModelName . "</h2>";
    $code .= "\n</div>";
    $code .= "\n<div class=\"pull-right\">";
    $code .= "\n@if (\$errors->any())";
    $code .= "\n<div class=\"alert alert-danger\">";
    $code .= "\n<strong>Whoops!</strong> Hay error en los datos de entrada<br><br>";
    //$code .= "\n<ul>";
    //$code .= "\n    @foreach (\$errors->all() as \$error)";
    //$code .= "\n<li>{{ \$error }}</li>";
    //$code .= "\n    @endforeach";
    //$code .= "\n</ul>";
    $code .= "\n</div>";
    $code .= "\n@endif";
    $code .= "\n<form class= \"form-horizontal\" action=\"{{ route('" . $ModelName . ".update',\$" . $camelCaseName . "->id) }}\" method=\"POST\" enctype=\"multipart/form-data\">";
    $code .= "\n@csrf";
    $code .= "\n@method('PATCH')";
    $code .= "\n<div class=\"card-body\">";
    foreach ($fields as $fld) {
        if (isset($fld->ShowInEdit) && $fld->ShowInEdit) {
            if ($fld->FormType == "Text" || $fld->FormType == "Money") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"text\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }

            if ($fld->FormType == "TextArea") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<textarea row=\"4\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}</textarea>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Image" || $fld->FormType == "File") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"file\"  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Password") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"password\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Email") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"email\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Date") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"date\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Number") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"number\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Radio") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "_" . $k . "\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . $camelCaseName . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Check") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"checkbox\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\"> {{ (" . $valor->Value . " == \$" . $camelCaseName . "->" . $fld->FieldName . "?'checked':'') }} " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Boolean") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"Radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . $camelCaseName . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Relation") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione una Opcion</option>";
                $code .= "\n @foreach(\$" . ucfirst(str_replace("_", "", $fld->TableRel)) . "List as \$row )";
                $code .= "\n <option value=\"{{ \$row->" . $fld->FieldRel . " }}\"  >{{ \$row->" . $fld->FieldDisplay . " }}</option>";
                $code .= "\n @endforeach";
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Years") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione un Año</option>";
                $years = explode(':', $fld->format);
                for ($y = $years[0]; $y < ($years[1] + 1); $y++) {
                    $code .= "\n <option value=\"$y\"  {{ ($y== \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }}>$y </option>";
                }
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Months") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione un Mes</option>";
                $meses = [1 => 'Enero', 2 => 'Febrero', 3 => 'Marzo', 4 => 'Abril', 5 => 'Mayo', 6 => 'Junio', 7 => 'Julio', 8 => 'Agosto', 9 => 'Septiembre', 10 => 'Octubre', 11 => 'Noviembre', 12 => 'Diciembre'];
                foreach ($meses as $mes => $mestext) {
                    $code .= "\n <option value=\"$mes\" {{ ($mes== \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }} >$mestext </option>";
                }
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "List") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione una Opcion</option>";
                foreach ($fld->Values as $valor) {
                    $code .= "\n <option value=\"$valor->Value\"  >$valor->Label </option>";
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";

                //{{ (\"$valor->Value\" == \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }}
            }
            //generate JavaScript Ajax Events
            if (count($fld->Events) > 0) {
                foreach ($fld->Events as $e) {
                    $jsCode .= "\n \$(\"#" . $fld->IdParent . "\").on(\"" . $e->event . "\",function(response){\n";
                    if ($e->fnc->operation == 'fillSelect') {
                        $jsCode .= "\n  \$.get(\"/admin/" . $camelCaseName . "/all\",{},function(response){";
                        $jsCode .= "\n   \$(\"#" . $fld->FieldName . "\").empty()";
                        $jsCode .= "\n   \$.each(response,function(inx,row){";
                        $jsCode .= "\n      \$(\"#" . $fld->FieldName . "\").append(\"<option value='\"+row." . $e->fnc->FieldValue . "'>\"+row." . $e->fnc->FieldLabel . "+\"</option>\")";
                        $jsCode .= "\n   })";
                        $jsCode .= "\n  })";
                        $jsCode .= "\n })";
                    }
                }
            } //
        }
    }

    $code .= "\n<a class=\"btn btn-secondary\" href=\"{{ route('" . $camelCaseName . ".index') }}\"> Regresar</a>";
    $code .= "\n<button type=\"submit\" class=\"btn btn-success\">Grabar</button>";
    $code .= "\n</div>";
    $code .= "\n</form>";
    $code .= "\n</div>";
    $code .= "\n</div>";
    $code .= "<script>\n\n" . $jsCode . "\n\n</script>";
    $code .= "\n@endsection";
    return $code;
}

function GenModalInit($modelName)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
    $code = "";
    $code .= "    <div class=\"modal fade\" id=\"modal_" . $camelCasename . "\" role=\"dialog\">";
    $code .= "    <div class=\"modal-dialog modal-lg\">";
    $code .= "      <div class=\"modal-content\">";
    $code .= "        <div class=\"modal-header\">;";
    $code .= "          <button type=\"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>";
    $code .= "          <h4 class=\"modal-title\">Editar " . $camelCaseName . "</h4>";
    $code .= "        </div>";
    $code .= "        <div class=\"modal-body\">";
    return $code;
}


function GenModalEnd($modelName)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
    $code = "";
    $code .= "    </div>";
    $code .= "        <div class=\"modal-footer\">";
    $code .= "          <button type=\"button\" class=\"btn btn-default btn-sm\" data-dismiss=\"modal\">Cerrar</button>";
    $code .= "          <button type=\"button\" class=\"btn btn-default btn-success btn-sm save-edit-" . $camelCaseName . "\" >Grabar</button>";
    $code .= "        </div>";
    $code .= "      </div>";
    $code .= "    </div>";
    $code .= "  </div>";
    $code .= "</div>";
    return $code;
}


function GenViewEditModal($ModelName, $fields)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
    $jsCode = null;
    $code = "";
    $code .= GenModalInit($ModelName);
    $code .= "\n<div class=\"row\">";
    $code .= "\n<div class=\"col-md-12\">";
    $code .= "\n<div class=\"card\">";
    $code .= "\n<div class=\"card-header\">";
    $code .= "\n<h2 class=\"\">Editar " . $ModelName . "</h2>";
    $code .= "\n</div>";
    $code .= "\n<div class=\"pull-right\">";
    $code .= "\n@if (\$errors->any())";
    $code .= "\n<div class=\"alert alert-danger\">";
    $code .= "\n<strong>Whoops!</strong> Hay error en los datos de entrada<br><br>";
    //$code .= "\n<ul>";
    //$code .= "\n    @foreach (\$errors->all() as \$error)";
    //$code .= "\n<li>{{ \$error }}</li>";
    //$code .= "\n    @endforeach";
    //$code .= "\n</ul>";
    $code .= "\n</div>";
    $code .= "\n@endif";
    $code .= "\n<form id=\"frmEdit" . $camelCaseName . "\" class= \"form-horizontal\" action=\"{{ route('" . $camelCaseName . ".update',\$" . $camelCaseName . "->id) }}\" method=\"POST\" enctype=\"multipart/form-data\">";
    $code .= "\n@csrf";
    $code .= "\n@method('PATCH')";
    $code .= "\n<div class=\"card-body\">";
    foreach ($fields as $fld) {
        if (isset($fld->ShowInEdit) && $fld->ShowInEdit) {
            if ($fld->FormType == "Text" || $fld->FormType == "Money") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"text\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "TextArea") {
                $code .= "\n<div class=\"form-group  col-md-4\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<textarea row=\"4\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}</textarea>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Image" || $fld->FormType == "File") {
                $code .= "\n<div class=\"form-group  col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"file\"  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Password") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"password\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Email") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"email\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Date") {
                $code .= "\n<div class=\"form-group col-md-2\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"date\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Number") {
                $code .= "\n<div class=\"form-group col-md-2\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"number\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Radio") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "_" . $k . "\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . $camelCaseName . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Check") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"checkbox\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\"> {{ (" . $valor->Value . " == \$" . $camelCaseName . "->" . $fld->FieldName . "?'checked':'') }} " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Boolean") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"Radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . $camelCaseName . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Relation") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione una Opcion</option>";
                $code .= "\n @foreach(\$" . ucfirst(str_replace("_", "", $fld->TableRel)) . "List as \$row )";
                $code .= "\n <option value=\"{{ \$row->" . $fld->FieldRel . " }}\" {{ (\$row->" . $fld->FieldRel . "== \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }} >{{ \$row->" . $fld->FieldDisplay . " }}</option>";
                $code .= "\n @endforeach";
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "List") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione una Opcion</option>";
                foreach ($fld->Values as $valor) {
                    $code .= "\n <option value=\"$valor->Value\" {{ (\"$valor->Value\" == \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }} >$valor->Label </option>";
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            //generate JavaScript Ajax Events
            /*
            if (count($fld->Events) > 0) {
                foreach ($fld->Events as $e) {
                    $jsCode .= "\n \$(\"#" . $fld->IdParent . "\").on(\"" . $e->event . "\",function(response){\n";
                    if ($e->fnc->operation == 'fillSelect') {
                        $jsCode .= "\n  \$.get(\"/admin/" . $ModelName . "/all\",{},function(response){";
                        $jsCode .= "\n   \$(\"#" . $fld->FieldName . "\").empty()";
                        $jsCode .= "\n   \$.each(response,function(inx,row){";
                        $jsCode .= "\n      \$(\"#" . $fld->FieldName . "\").append(\"<option value='\"+row." . $e->fnc->FieldValue . "'>\"+row." . $e->fnc->FieldLabel . "+\"</option>\")";
                        $jsCode .= "\n   })";
                        $jsCode .= "\n  })";
                        $jsCode .= "\n })";
                    }
                }
            } //
            */
        }
    }

    //$code .= "\n'<a class=\"btn btn-secondary\" href=\"{{ route('" . $ModelName . ".index') }}\"> Regresar</a>";
    //$code .= "\n<button type=\"submit\" class=\"btn btn-success\">Grabar</button>";
    $code .= "\n</div>";
    $code .= "\n</form>";
    $code .= "\n</div>";
    $code .= "\n</div>";
    //$code .= "<script>\n\n" . $jsCode . "\n\n</script>";
    $code .= GenModalEnd($ModelName);
    return $code;
}


function GenViewCreateModal($ModelName, $fields)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
    $jsCode = null;
    $code = "";
    $code .= GenModalInit($ModelName);
    $code .= "\n<div class=\"row\">";
    $code .= "\n<div class=\"col-md-12\">";
    $code .= "\n<div class=\"card\">";
    $code .= "\n<div class=\"card-header\">";
    $code .= "\n<h2 class=\"\">Editar " . $camelCaseName . "</h2>";
    $code .= "\n</div>";
    $code .= "\n<div class=\"pull-right\">";
    $code .= "\n@if (\$errors->any())";
    $code .= "\n<div class=\"alert alert-danger\">";
    $code .= "\n<strong>Whoops!</strong> Hay error en los datos de entrada<br><br>";
    //$code .= "\n<ul>";
    //$code .= "\n    @foreach (\$errors->all() as \$error)";
    //$code .= "\n<li>{{ \$error }}</li>";
    //$code .= "\n    @endforeach";
    //$code .= "\n</ul>";
    $code .= "\n</div>";
    $code .= "\n@endif";
    $code .= "\n<form id=\"frmEdit" . $camelCaseName . "\" class= \"form-horizontal\" action=\"{{ route('" . $camelCaseName . ".create',\$" . $camelCaseName . "->id) }}\" method=\"POST\" enctype=\"multipart/form-data\">";
    $code .= "\n@csrf";
    $code .= "\n@method('PATCH')";
    $code .= "\n<div class=\"card-body\">";
    foreach ($fields as $fld) {
        if (isset($fld->ShowInCreate) && $fld->ShowInCreate) {
            if ($fld->FormType == "Text" || $fld->FormType == "Money") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"text\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "TextArea") {
                $code .= "\n<div class=\"form-group  col-md-4\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<textarea row=\"4\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}</textarea>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Image" || $fld->FormType == "File") {
                $code .= "\n<div class=\"form-group  col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"file\"  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Password") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"password\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Email") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"email\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Date") {
                $code .= "\n<div class=\"form-group col-md-2\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"date\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Number") {
                $code .= "\n<div class=\"form-group col-md-2\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"number\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . $camelCaseName . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Radio") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "_" . $k . "\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . $camelCaseName . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Check") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"checkbox\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\"> {{ (" . $valor->Value . " == \$" . $camelCaseName . "->" . $fld->FieldName . "?'checked':'') }} " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Boolean") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"Radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . $camelCaseName . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Relation") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione una Opcion</option>";
                $code .= "\n @foreach(\$" . ucfirst(str_replace("_", "", $fld->TableRel)) . "List as \$row )";
                $code .= "\n <option value=\"{{ \$row->" . $fld->FieldRel . " }}\" {{ (\$row->" . $fld->FieldRel . "== \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }} >{{ \$row->" . $fld->FieldDisplay . " }}</option>";
                $code .= "\n @endforeach";
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "List") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione una Opcion</option>";
                foreach ($fld->Values as $valor) {
                    $code .= "\n <option value=\"$valor->Value\" {{ (\"$valor->Value\" == \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }} >$valor->Label </option>";
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            //generate JavaScript Ajax Events
            /*
            if (count($fld->Events) > 0) {
                foreach ($fld->Events as $e) {
                    $jsCode .= "\n \$(\"#" . $fld->IdParent . "\").on(\"" . $e->event . "\",function(response){\n";
                    if ($e->fnc->operation == 'fillSelect') {
                        $jsCode .= "\n  \$.get(\"/admin/" . $ModelName . "/all\",{},function(response){";
                        $jsCode .= "\n   \$(\"#" . $fld->FieldName . "\").empty()";
                        $jsCode .= "\n   \$.each(response,function(inx,row){";
                        $jsCode .= "\n      \$(\"#" . $fld->FieldName . "\").append(\"<option value='\"+row." . $e->fnc->FieldValue . "'>\"+row." . $e->fnc->FieldLabel . "+\"</option>\")";
                        $jsCode .= "\n   })";
                        $jsCode .= "\n  })";
                        $jsCode .= "\n })";
                    }
                }
            } //
            */
        }
    }

    //$code .= "\n'<a class=\"btn btn-secondary\" href=\"{{ route('" . $ModelName . ".index') }}\"> Regresar</a>";
    //$code .= "\n<button type=\"submit\" class=\"btn btn-success\">Grabar</button>";
    $code .= "\n</div>";
    $code .= "\n</form>";
    $code .= "\n</div>";
    $code .= "\n</div>";
    //$code .= "<script>\n\n" . $jsCode . "\n\n</script>";
    $code .= GenModalEnd($ModelName);
    return $code;
}

function GenDependentSelect($parent, $parentid, $child, $childid, $childDisplay, $event, $service, $params)
{
    $code = '';
    $code .= "$(\"#" . $parent . "\").on('" . $event . "',function(){";
    $code . "  $(\"" . $child . "\").empty()";
    $code . "  $.get('" . $service . $params . "',function(data){";
    $code . "    $(\"" . $child . "\").append('<option val=\"'.data." . $childid . "'\">'data." . $childDisplay . "'</option>')";
    $code .= " })";
    $code .= "})";
}

function GenFillTable($control, $table, $event, $service, $cols = array())
{
    $code = "";
    $code .= "$(\"#" . $control . "\").on('" . $event . "',function(){";
    $code .= "var filas='';";
    $code .= "  $.get('" . $service . "/'\'+$(this).val(),function(data){";
    $filas = '';
    foreach ($cols as $c) {
        $filas .= '<td>\'+' . $c . '+\'</td>';
    }
    $code . "    $(\"" . $table . " tbody\").append('<tr>" . $filas . "</tr>')";
    $code .= " })";
    $code .= "})";
}

function GenViewCreate($ModelName, $fields)
{
    $camelCaseName = str_replace(' ','',ucwords(str_replace('_', ' ', $ModelName)));
    $jsCode = '';
    $code = "";
    $code .= "\n@extends('layouts.admin')";
    $code .= "\n@section('contenido')";
    $code .= "\n<div class=\"row\">";
    $code .= "\n<div class=\"col-md-12\">";
    $code .= "\n<div class=\"card\">";
    $code .= "\n<div class=\"card-header\">";
    $code .= "\n<h2 class=\"\">Nuevo " . $camelCaseName . "</h2>";
    $code .= "\n</div>";
    $code .= "\n<div class=\"pull-right\">";
    $code .= "\n@if (\$errors->any())";
    $code .= "\n<div class=\"alert alert-danger\">";
    $code .= "\n<strong>Whoops!</strong> Hay error en los datos de entrada<br><br>";
    $code .= "\n</div>";
    $code .= "\n@endif";
    $code .= "\n<form class= \"form-horizontal\" action=\"{{ route('" . $camelCaseName . ".create') }}\" method=\"POST\" method=\"POST\" enctype=\"multipart/form-data\">";
    $code .= "\n@csrf";
    $code .= "\n<div class=\"card-body\">";
    foreach ($fields as $fld) {
        if (isset($fld->ShowInCreate) && $fld->ShowInCreate) {
            if ($fld->FormType == "Text" || $fld->FormType == "Money") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"text\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }

            if ($fld->FormType == "TextArea") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<textarea  row=\"4\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\"></textarea>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }

            if ($fld->FormType == "Password") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->FieldName . "</label>";
                $code .= "\n<input type=\"password\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Image" || $fld->FormType == "File") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"file\"  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Email") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"email\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Date") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"date\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Number") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"number\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Radio") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "_" . $k . "\" value=\"" . $valor->Value . "\" class=\"\" > " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Check") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"checkbox\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\"  > " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Boolean") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                foreach ($fld->Values as $valor) {
                    $code .= "\n<input type=\"radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\" > " . $valor->Label;
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Relation") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione una Opcion</option>";
                $code .= "\n @foreach(\$" . ucfirst(str_replace("_", "", $fld->TableRel)) . "List as \$row )";
                $code .= "\n <option value=\"{{ \$row->" . $fld->FieldRel . " }}\" {{ (\$row->" . $fld->FieldRel . "== \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }}>{{ \$row->" . $fld->FieldDisplay . " }}</option>";
                $code .= "\n @endforeach";
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "List") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\" >Seleccione una Opcion</option>";
                foreach ($fld->Values as $valor) {
                    $code .= "\n <option value=\"$valor->Value\" {{ (\$row->" . $fld->FieldRel . "== \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }} >$valor->Label</option>";
                    if ($fld->ViewIcon) {
                        $code .= "\n <img src=\"" . $fld->IconValues[$k]->Icon . "\">";
                    }
                    $k++;
                }
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Years") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione un Año</option>";
                $years = explode(':', $fld->format);
                for ($y = $years[0]; $y < ($years[1] + 1); $y++) {
                    $code .= "\n <option value=\"$y\"  {{ ($y== \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }}>$y </option>";
                }
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Months") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $k = 0;
                $code .= "\n<SELECT  name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" class=\"form-control\">";
                $code .= "\n <option value=\"\">Seleccione un Mes</option>";
                $meses = [1 => 'Enero', 2 => 'Febrero', 3 => 'Marzo', 4 => 'Abril', 5 => 'Mayo', 6 => 'Junio', 7 => 'Julio', 8 => 'Agosto', 9 => 'Septiembre', 10 => 'Octubre', 11 => 'Noviembre', 12 => 'Diciembre'];
                foreach ($meses as $mes => $mestext) {
                    $code .= "\n <option value=\"$mes\" {{ ($mes== \$" . $camelCaseName . "->" . $fld->FieldName . "?'selected':'') }} >$mestext </option>";
                }
                $code .= "\n</SELECT>";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }


            if (count($fld->Events) > 0) {
                foreach ($fld->Events as $e) {
                    $jsCode .= "\n \$(\"#" . $fld->IdParent . "\").on(\"" . $e->event . "\",function(response){\n";
                    if ($e->Function->ControlType == 'SELECT') {
                        $jsCode .= "\n \$" . $e->Function->Method . "(\"/admin/" . $e->Function->table . "/all\",{},function(response){";
                        $jsCode .= "\n  \$(\"#" . $e->Function->ControlName . "\").empty()";
                        $jsCode .= "\n  \$.each(response,function(inx,row){";
                        $jsCode .= PHP_EOL . '     \$(\"#' . $e->Function->ControlName . '\").append(\"<option value=\"+row.' . $e->Function->FieldValue . '+\">\"+row.' . $e->Function->FieldLabel . '+\"</option>\")';
                        $jsCode .= "\n  })";
                        $jsCode .= "\n})";
                        $jsCode .= "\n})";
                    }
                }
            } //
        }
    }

    $code .= "\n<a class=\"btn btn-secondary\" href=\"{{ route('" . $camelCaseName . ".index') }}\"> Regresar</a>";
    $code .= "\n<button type=\"submit\" class=\"btn btn-success\">Grabar</button>";
    $code .= "\n</div>";
    $code .= "\n</form>";
    $code .= "\n</div>";
    $code .= "\n</div>";
    $code .= "<script>\n\n" . $jsCode . "\n\n</script>";
    $code .= "\n@endsection";
    return $code;
}

function GenMigration($ModelName, $fields, $timestamps = true)
{
    $code = "";
    $code .= "<?php\n";
    $code .= "\n";
    $code .= "\n use Illuminate\Database\Migrations\Migration;";
    $code .= "\n use Illuminate\Database\Schema\Blueprint;";
    $code .= "\n use Illuminate\Support\Facades\Schema;";
    $code .= "\n";
    $code .= "\n  return new class extends Migration";
    $code .= "\n  {";
    $code .= "\n      /**";
    $code .= "\n       * Run the migrations.";
    $code .= "\n       *";
    $code .= "\n       * @return void";
    $code .= "\n       */";
    $code .= "\n      public function up():void";
    $code .= "\n      {";
    $code .= "\n          Schema::create('" . $ModelName . "', function (Blueprint \$table) {";
    foreach ($fields as $fld) {
        switch ($fld->FieldDbType) {
            case 8:
                $code .= "\n              \$table->bigIncrements('" . $fld->FieldName . "');";
                break;
            case 253:
                $code .= "\n              \$table->string('" . $fld->FieldName . "'," . $fld->Long . ");";
                break;
            case 3:
                $code .= "\n              \$table->integer('" . $fld->FieldName . "');";
                break;
            case 10:
                $code .= "\n              \$table->date('" . $fld->FieldName . "');";
                break;
            case 246:
                $code .= "\n              \$table->decimal('" . $fld->FieldName . "',10,2);";
                break;
            case 1:
                $code .= "\n              \$table->tinyInteger('" . $fld->FieldName . "');";
                break;
            case 252:
                $code .= "\n              \$table->text('" . $fld->FieldName . "');";
                break;
        }
    }
    if ($timestamps) {
        $code .= "\n              \$table->timestamps();";
    }
    $code .= "\n          });";
    $code .= "\n      }";
    $code .= "\n";
    $code .= "\n      /**";
    $code .= "\n       * Reverse the migrations.";
    $code .= "\n       *";
    $code .= "\n       * @return void";
    $code .= "\n       */";
    $code .= "\n      public function down():void";
    $code .= "\n      {";
    $code .= "\n          Schema::dropIfExists('" . $ModelName . "');";
    $code .= "\n      }";
    $code .= "\n  }";
    return $code;
}

function sign()
{
    echo "\n\e[93m---------------------------------------------------------------------";
    echo "\n\e[93m┌─┐┌─┐┬ ┬┬  ┌─┐ ┬ ┬┌─┐┬─┐┌┐┌┌─┐┌┐┌┌┬┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐┬┬   ┌─┐┌─┐┌┬┐";
    echo "\n\e[93m└─┐├─┤│ ││  │ │ ├─┤├┤ ├┬┘│││├─┤│││ ││├┤ ┌─┘│└┘│ ┬│││├─┤││   │  │ ││││";
    echo "\n\e[93m└─┘┴ ┴└─┘┴─┘└─┘o┴ ┴└─┘┴└─┘└┘┴ ┴┘└┘─┴┘└─┘└─┘└──└─┘┴ ┴┴ ┴┴┴─┘o└─┘└─┘┴ ┴";
    echo "\n\e[93m---------------------------------------------------------------------";
    echo "\n";
    //picture();
}

function picture()
{
    echo "\n\e[90m                                @@@@&&@&@&&&%*";
    echo "\n\e[90m                            %@@@&&@@@@&@@@@@@@@@&";
    echo "\n\e[90m                          &@@@&&@@@@@@@@@@@@@@@@@@@&";
    echo "\n\e[90m                        &@&@&@@@@@@@@@@@@@@@@@@@@@@@@#";
    echo "\n\e[90m                      *@@&@&&&&%%#####%%#%#%%%&&&&@@@@&";
    echo "\n\e[90m                     ,&@&@&&##(((((((((########%%%&&&@@&";
    echo "\n\e[90m                     /@&%%###((################%%%%&@@@@%";
    echo "\n\e[90m                    .&&&%%####((((/((((((((###%%%%%%&@@@&.";
    echo "\n\e[90m                     &&&%&##&&@&@&&&&#((#&&&%%#%%&&&%%@@%";
    echo "\n\e[90m                     /&&&((%#O&%&&%###(#%&&/#@#&O%%%%%@(";
    echo "\n\e[90m                     *&&#(###############%&%%#%%%%%%%%%&%@";
    echo "\n\e[90m                    ,((%#(#(((((((((((((##%%########%%%&%&";
    echo "\n\e[90m                     (/%#(((((((((##(((/(%##&#(######%%#@";
    echo "\n\e[90m                      ((#(((((((##((###%%&&%#######%#%%%#";
    echo "\n\e[90m                      (((((((((%%%&%%%##&@@&&%####%%%%%";
    echo "\n\e[90m                       .((((((((%&&#(**/**/#@@&%###%%%%%";
    echo "\n\e[90m                        ((((###%%((((((####%%%%%##%%%%%";
    echo "\n\e[90m                         (##(#####(((%&@&&###%%%%%%%%%";
    echo "\n\e[90m                          /####%%%#%#%@@%&%%&&&%%%%%#";
    echo "\n\e[90m                          ../(##&&%&&&&&@&&@&&%%&%%(/";
    echo "\n\e[90m                  ,,,...,... ../###%&&&@&&&&&&%%///**,";
    echo "\n\e[90m          .,,,,......,.... .. ...../###%%%%(/****,**,*////*.";
    echo "\n\e[90m.,.........,,.......... .. .. .. *%%%%%#,.,**,**,,**/**********,";
    echo "\n\e[90m.....,,..... ...,... ..,.. .. ..*%&#%%(%%(%%%*,,.,**,/*,,,,,,,,,,,,,,,,,";
    echo "\n\e[90m............... . .... ..... */*%%&%%%#%%#%&&&&/,,,,*,,.,.,,.,,,,,,,,,,,,,*,*";
    echo "\n\e[90m . .....,... .... .. .....,......%&&%%%%%%&&&%,.,,,,.,,.,,,,.,,,,,,,,,.,,,,.*,**";
    echo "\n\e[90m.. .... .... ....... . .. .....,,.%&&%%%%%%&%,,,,,,,.,,.,.,,.,,,,.,.,,.,,,,.,.**";
    echo "\n\e[90m.  . .. .... . .. ....... ........,%&%%%%%(&..........,.,.,,.,.,,.,.,,.,..,,,.,,";
    echo "\n\e[90m. .. .. . .. . ..... . .. ........./&%%(%%%/......,.....,.,,.,.,,.,.,,.,..,*,.,.";
    echo "\n\e[92m                        █▀ ▄▀█ █░█ █░░ █▀█ █░█ █▀▄ ▀█                            ";
    echo "\n\e[92m                        ▄█ █▀█ █▄█ █▄▄ █▄█ █▀█ █▄▀ █▄                            ";
    echo "\n\e[97m";
}

function help()
{
    echo "\n\e[97m Builder for Laravel 7.0 by Saulo Hernandez O.";
    echo "\n\e[97m ------------------------------------------------";
    echo "\n\e[97m Command :  php builder |parameter #1 parameter #2 parameter #3|";
    echo "\n\e[97m Paramaters : ";
    echo "\n\e[97m        GenStructure:file.json  -> genera el archivo JSON de la estructura de la BD, este comando se ejecuta solo, ";
    echo "\n\e[97m        no se puede ejecutar junto con otros comandos";
    echo "\n\e[97m        configfile:file.json file with the structure of database";
    echo "\n\e[97m        tables: All | tablename 1,tablename 2,...,tablename n|  Tables you want generate";
    echo "\n\e[97m        make:controller|,|model|,|view|,|migrations|,|route|   ---> generate Controllers, Models, View, Migrations and/or routes of tables\n";
}


function ENV_Parser($fileContent)
{
    $Content = explode("\n", $fileContent);
    $ENV = array();
    foreach ($Content as $con) {
        $ENV[substr($con, 0, strpos($con, "="))] = substr($con, strpos($con, "=") + 1);
    }
    return $ENV;
}

//$Comandos["gen"]=explode(",","Models,Controller,Views");
//print_r($parameters);
unset($parameters[0]);
parse($parameters);
print_r($parameters);
//exit(0);
if (count($Comandos) == 0) {
    help();
    sign();
    exit(0);
} elseif (isset($Comandos["CONFIGFILE"][0])) {
    echo "\n Archivo de Configuracion leyendose .... " . $Comandos["CONFIGFILE"][0];
    //print_r(file_get_contents($Comandos["CONFIGFILE"][0], FILE_USE_INCLUDE_PATH));exit(0);
    $jsonConfig = json_decode(file_get_contents($Comandos["CONFIGFILE"][0], FILE_USE_INCLUDE_PATH));
    //print_r($jsonConfig);exit(0);
} else {
    if ($Comandos['GENSTRUCTURE'] != "" || $Comandos['genStructure'] != "" || $Comandos['genstructure'] != "") {
        $dbconf = ENV_Parser(file_get_contents(".env"));
        $db = new readStructure();
        $db->setDb($dbconf["DB_DATABASE"]);
        $db->setSrv($dbconf["DB_HOST"]);
        $db->setUsr($dbconf["DB_USERNAME"]);
        $db->setPass($dbconf["DB_PASSWORD"]);
        echo "\n ** Generador de la Estructura de la BD JSON **";
        echo "\n Generando estructura automaticamente de la Base de datos " . $dbconf["DB_DATABASE"] . " en " . $dbconf["DB_HOST"];
        sleep(2);
        $jsonConfig = $db->readStructure(strtoupper($Comandos['TABLES'][0]) == 'ALL' ? array() : $Comandos['TABLES'],$dbconf["DB_CONNECTION"],$dbconf['DB_HOST'],$dbconf['DB_DATABASE'],$dbconf['DB_USERNAME'],$dbconf['DB_PASSWORD']);
        //print_r($jsonConfig);

        $myfile = fopen($Comandos["GENSTRUCTURE"][0], "w");
        fwrite($myfile, $jsonConfig);
        fclose($myfile);

        echo "\n Estructura de la BD generada satisfactoriamente en archivo " . $Comandos["GENSTRUCTURE"][0];
        sign();
        exit(0);
    }

    $dbconf = ENV_Parser(file_get_contents(".env"));
    echo "\n No se encontro archivo de configuracion de la estructura de la base de datos....";
    $db = new readStructure();
    $db->setDb($dbconf["DB_DATABASE"]);
    $db->setSrv($dbconf["DB_HOST"]);
    $db->setUsr($dbconf["DB_USERNAME"]);
    $db->setPass($dbconf["DB_PASSWORD"]);
    echo "\n Generando estructura automaticamente de la Base de datos " . $dbconf["DB_DATABASE"] . " en " . $dbconf["DB_HOST"];
    echo "\n Leyendo informacion de el archivo .env ....";
    $jsonConfig = json_decode($db->readStructure());
    print_r($jsonConfig);exit(0);
    fopen("app/Trais",'w');
    @copy("CRUDBuilder/CheckPermisoRol.php","app/Traits/CheckPermisoRol.php");
}
print_r($Comandos["MAKE"]);
//print_r($jsonConfig->Tables);exit(0);
echo "\n Comenzando el proceso de Generación de codigo.....";
sleep(1);
foreach ($jsonConfig->Tables as $tbl) {
    sleep(1);
    foreach ($Comandos["MAKE"] as $mk) {
        if (strtoupper($Comandos["TABLES"][0]) != 'ALL') {
            if (in_array($tbl->TableName, $Comandos["TABLES"])) {
                if (strtoupper($mk) == 'CONTROLLER') {
                    echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                    $data = GenController($TableName, $tbl->fields);
                    $myfile = fopen("app/Http/Controllers/" . preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper',$tbl->TableName) . 'Controller.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                }
                if (strtoupper($mk) == 'MODEL') {
                    echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                    $data = GenModel($tbl->TableName, $tbl->fields);
                    $myfile = fopen("app/Models/" . $camelCaseName . '.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                }
                if (strtoupper($mk) == 'MIGRATIONS') {
                    echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                    $data = GenMigration( $tbl->TableName, $tbl->fields);
                    $myfile = fopen("database/migrations/" . date('Y_m_d_His') . "_create_" . $tbl->TableName . '.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                }

                if (strtoupper($mk) == 'VIEW') {
                    echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                    if (!file_exists('resources/views/' . $camelCaseName)) {
                        mkdir('resources/views/' . $camelCaseName);
                    }

                    //INDEX
                    $data = GenViewIndex($TableName, $tbl->fields);
                    $myfile = fopen('resources/views/' . preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper',  $tbl->TableName) . '/index.blade.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                    //EDIT
                    $data = GenViewCreate($TableName, $tbl->fields);
                    $myfile = fopen('resources/views/' . $camelCaseName . '/create.blade.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                    //CREATE
                    $data = GenViewEdit($tbl->TableName, $tbl->fields);
                    $myfile = fopen('resources/views/' . $camelCaseName . '/edit.blade.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                }
                if (strtoupper($mk) == 'VIEW-MODAL') {
                    if (!file_exists('resources/views/' . $camelCaseName . '/modal')) {
                        @mkdir('resources/views/' . $camelCaseName . '/modal');
                    }


                    //EDIT MODAL
                    $data = GenViewEditModal($tbl->TableName, $tbl->fields);
                    $myfile = fopen('resources/views/' . $camelCaseName . '/modal/edit.blade.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                    //CREATE MODAL
                    $data = GenViewCreateModal($tbl->TableName, $tbl->fields);
                    $myfile = fopen('resources/views/' . $camelCaseName . '/modal/create.blade.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);


                }
                if (strtoupper($mk) == 'ROUTE' || strtoupper($mk) == 'ROUTES') {
                    GenRoutesWEB($TableName);
                    echo "\n Agregando Rutas del Modelo " . $tbl->TableName;
                }
            }
        } else {
            if (strtoupper($mk) == 'CONTROLLER') {
                echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                $data = GenController(preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper', $tbl->TableName), $tbl->fields);
                $myfile = fopen("app/Http/Controllers/" . preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper', $tbl->TableName) . 'Controller.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
            }
            if (strtoupper($mk) == 'MODEL') {
                echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                $data = GenModel(preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper', $tbl->TableName), $tbl->fields);
                $myfile = fopen("app/Models/" .  preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper', $tbl->TableName) . '.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
            }
            if (strtoupper($mk) == 'MIGRATIONS') {
                echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                $data = GenMigration($tbl->TableName, $tbl->fields);
                $myfile = fopen("database/migrations/create_" . $tbl->TableName . '.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
            }
            if (strtoupper($mk) == 'VIEW') {
                echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                if (!file_exists('resources/views/' . preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper',  $tbl->TableName))) {
                    mkdir('resources/views/' . str_replace("_", "", preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper', $tbl->TableName)));
                }
                //index
                $data = GenViewIndex($tbl->TableName, $tbl->fields);
                $myfile = fopen('resources/views/' . preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper', $tbl->TableName) . '/index.blade.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
                //EDIT
                $data = GenViewEdit($tbl->TableName, $tbl->fields);
                $myfile = fopen('resources/views/' . preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper',  $tbl->TableName) . '/edit.blade.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
                //CREATE
                $data = GenViewCreate($tbl->TableName, $tbl->fields);
                $myfile = fopen('resources/views/' . preg_replace_callback('/(?:^|_)([a-z])/', 'match_toupper',  $tbl->TableName) . '/create.blade.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
            }
            if (strtoupper($mk) == 'ROUTE' || strtoupper($mk) == 'ROUTES') {
                GenRoutesWEB($tbl->TableName);
                echo "\n Agregando Rutas del Modelo " . $tbl->TableName;
            }
        }
    }
}
echo "\n\e[97m * * * La Generación de Código terminó satisfactoriamente * * *";
$dbconf = ENV_Parser(file_get_contents(".env"));
$conn = new PDO($dbconf["DB_CONNECTION"].":host=".$dbconf["DB_HOST"].";port=".$dbconf["DB_PORT"].";dbname=".$dbconf["DB_DATABASE"]."; sslmode=".$dbconf["DB_SSLMODE"]."; user=".$dbconf["DB_USERNAME"].";password=".$dbconf["DB_PASSWORD"]);
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
echo "\n\e[97m Quieres crear las tablas de Roles, Permisos y permisos_roles ? (S/N)";
$respuesta = readline();
if(strtoupper($respuesta)=='S' || strtoupper($respuesta)=='SI' || strtoupper($respuesta)=='Y' || strtoupper($respuesta)=='YES'){
$stmt = $conn->prepare('CREATE TABLE permisos (
  id '.auto_increment($dbconf["DB_CONNECTION"]).',
  nombrePermiso varchar(400) NOT NULL,
  slug varchar(240) NOT NULL,
  id_parent int NOT NULL,
  isgroup tinyint NOT NULL,
  orden tinyint NOT NULL,
  route varchar(200)  DEFAULT NULL,
  icon varchar(160) DEFAULT NULL,
  image varchar(200) NULL,
  color varchar(80) DEFAULT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL,
  deleted_at timestamp NULL DEFAULT NULL
)');
$stmt->execute();
echo "\n\e[32m------- Se creo la TABLA permisos  -----------\e[0m";
$stmt = $conn->prepare('CREATE TABLE permisos_roles (
  id '.auto_increment($dbconf["DB_CONNECTION"]).',
  idRol int NOT NULL,
  isgroup tinyint NOT NULL,
  orden tinyint NOT NULL,
  idPermiso int NOT NULL,
  Listar tinyint NOT NULL,
  Ver tinyint NOT NULL,
  Agregar tinyint NOT NULL,
  Modificar tinyint NOT NULL,
  Borrar tinyint NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL,
  deleted_at timestamp NULL DEFAULT NULL
)');
$stmt->execute();
echo "\n\e[32m------- Se creo la TABLA permisos_roles  -----------\e[0m";
$stmt = $conn->prepare('CREATE TABLE roles (
  id '.auto_increment($dbconf["DB_CONNECTION"]).',
  nombreRol varchar(200) NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL
)');
$stmt->execute();
echo "\n\e[32m------- Se creo la TABLA roles  -----------\e[0m";
$stmt = $conn->prepare('ALTER TABLE users ADD COLUMN idRole bigint after id');
echo "\n\e[32m------- Se creo agrego el compo idRole a la TABLA users  -----------\e[0m";
$stmt->execute();

fopen("app/Trais",'w');
@copy("CRUDBuilder/CheckPermisoRol.php","app/Traits/CheckPermisoRol.php");
echo "\n\e[32m------- Se creo el Trait - CheckPermisoRol  -----------\e[0m";
}
echo "\n\e[32m------- Tablas Creadas Correctamente! -----------\e[0m";
echo "\n\e[32m----------------------------------------------------------- \e[0m";
echo "\n\e[97m Quieres crear un Usuario y asignarle un Rol y permisos de administrador ? (S/N)";
$respuesta = readline();
if(strtoupper($respuesta)=='S' || strtoupper($respuesta)=='SI' || strtoupper($respuesta)=='Y' || strtoupper($respuesta)=='YES'){
    $dbconf = ENV_Parser(file_get_contents(".env"));
    $conn = new PDO($dbconf["DB_CONNECTION"].":host=".$dbconf["DB_HOST"].";port=".$dbconf["DB_PORT"].";dbname=".$dbconf["DB_DATABASE"]."; sslmode=".$dbconf["DB_SSLMODE"]."; user=".$dbconf["DB_USERNAME"].";password=".$dbconf["DB_PASSWORD"]);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $stmt= $conn->prepare("INSERT INTO roles VALUES (1,'Administrador',NULL,NULL,NULL);");
    $stmt->execute();  
    $stmt= $conn->prepare("INSERT INTO users (id,name, email, password,idRole) VALUES (1,'admin','admin@admin.com','$2y$10$uXuLopShgZBrEDABnj/Ig.vpldT7oq8523.m0arWS8Afp5oPoC08O',1);");
    $stmt->execute();  
    echo "\n\e[97m Se creo el usuario admin@admin.com con el password : ..admin..  !! Copia estos datos de autenticación !! \e[0m";
    $stmt= $conn->prepare("INSERT INTO permisos (id, nombrePermiso,slug,id_parent,isgroup,orden,route,icon,image,color)  VALUES (1,'Catalogos','catalogos',NULL,1,1,'#','fas fa-circle',NULL,'FFFFFF');");
    $stmt->execute();  
    $stmt= $conn->prepare("INSERT INTO permisos (id, nombrePermiso,slug,id_parent,isgroup,orden,route,icon,image,color)  VALUES (2,'Usuarios','usuarios',NULL,1,1,'#','fas fa-circle',NULL,'FFFFFF');");
    $stmt->execute();  
    $stmt= $conn->prepare("INSERT INTO permisos (id, nombrePermiso,slug,id_parent,isgroup,orden,route,icon,image,color)  VALUES (3,'Permisos','permisos',NULL,1,1,'#','fas fa-circle',NULL,'FFFFFF');");
    $stmt->execute();  
    $stmt= $conn->prepare("INSERT INTO permisos (id, nombrePermiso,slug,id_parent,isgroup,orden,route,icon,image,color)  VALUES (4,'Roles','roles',NULL,1,1,'#','fas fa-circle',NULL,'FFFFFF');");
    $stmt->execute();  
    echo "\n\e[97m Se crearon los siguientes Accesos a Catalogos,Usuarios,Permisos,Roles";
    $stmt= $conn->prepare("INSERT INTO permisos_roles (id, idRol,idPermiso,isgroup,orden,Listar,Ver,Agregar,Modificar,Borrar)  VALUES (1,1,1,1,1,1,1,1,1,1),(2,1,2,1,2,0,1,1,1,1),(3,1,3,1,3,0,1,1,1,1),(4,1,4,1,4,0,1,1,1,1);");
    $stmt->execute();  
    //$stmt= $conn->prepare("INSERT INTO permisos_roles (id, idRol,idPermiso,isgroup,orden,Listar,Ver,Agregar,Modificar,Borrar)  VALUES (2,1,2,1,2,0,1,1,1,1);");
    //$stmt->execute();  
    //$stmt= $conn->prepare("INSERT INTO permisos_roles (id, idRol,idPermiso,isgroup,orden,Listar,Ver,Agregar,Modificar,Borrar)  VALUES (3,1,3,1,3,0,1,1,1,1);");
    //$stmt->execute();  
    //$stmt= $conn->prepare("INSERT INTO permisos_roles (id, idRol,idPermiso,isgroup,orden,Listar,Ver,Agregar,Modificar,Borrar)  VALUES (4,1,4,1,4,0,1,1,1,1);");
    //$stmt->execute();  
    echo "\n\e[97m Se asignaron los siguientes permisos (Listar,Ver,Agregar,Editar,Borrar) a los accesos: (Catalogos,Usuarios,Permisos,Roles) para el Rol de Administrador del usuario admin@admin.com";

}
sign();
