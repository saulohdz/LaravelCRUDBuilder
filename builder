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
    $code .= "\n LARAVEL 8.0";
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
    $code = "\n";//use App\\Http\\Controllers\\" . ucfirst(str_replace("_", "", $ModelName)) . "Controller;";
    $code .= "\n // RUTAS WEB DEL MODELO " . $ModelName;
    $code .= "\nRoute::get('/" . str_replace("_", "", $ModelName) . "',[App\\Http\\Controllers\\" . ucfirst(str_replace("_", "", $ModelName)) . "Controller::class,'index'])->name('" . $ModelName . ".index');";
    $code .= "\nRoute::post('/" . str_replace("_", "", $ModelName) . "/create',[App\\Http\\Controllers\\" . ucfirst(str_replace("_", "", $ModelName)) . "Controller::class,'store'])->name('" . $ModelName . ".store');";
    $code .= "\nRoute::get('/" . str_replace("_", "", $ModelName) . "/create',[App\\Http\\Controllers\\" . ucfirst(str_replace("_", "", $ModelName)) . "Controller::class,'create'])->name('" . $ModelName . ".create');";
    $code .= "\nRoute::get('/" . str_replace("_", "", $ModelName) . "/edit/{id}',[App\\Http\\Controllers\\" . ucfirst(str_replace("_", "", $ModelName)) . "Controller::class,'edit'])->name('" . $ModelName . ".edit');";
    $code .= "\nRoute::get('/" . str_replace("_", "", $ModelName) . "/{id}',[App\\Http\\Controllers\\" . ucfirst(str_replace("_", "", $ModelName)) . "Controller::class,'show'])->name('" . $ModelName . ".show');";
    $code .= "\nRoute::patch('/" . str_replace("_", "", $ModelName) . "/edit/{id}',[App\\Http\\Controllers\\" . ucfirst(str_replace("_", "", $ModelName)) . "Controller::class,'update'])->name('" . $ModelName . ".update');";
    $code .= "\nRoute::delete('/" . str_replace("_", "", $ModelName) . "/delete/{id}',[App\\Http\\Controllers\\" . ucfirst(str_replace("_", "", $ModelName)) . "Controller::class,'destroy'])->name('" . $ModelName . ".destroy');";
    file_put_contents(ROUTES_PATH . "webroutes.php", $code, FILE_APPEND | LOCK_EX);
}

function GenController($ControllerName, $fields)
{
    $code = "<?php";
    $code .= "\n";
    $code .= "namespace App\Http\Controllers;\n";
    $code .= "\n";
    $code .= "\n use Illuminate\Support\Facades\Validator;";
    $code .= "\n use App\\" . ucfirst(str_replace("_", "", $ControllerName)) . ";";
    $Models = array();
    foreach ($fields as $fld) {
        if (!in_array($fld->TableRel, $Models)) {
            if ($fld->FormType == 'Relation') {
                $Models[] = $fld->TableRel;
                //if ($fld->TableRel != ucfirst(str_replace("_", "", $ControllerName))) {

                    $code .= "\n use App\\Models\\" . ucfirst(str_replace("_", "", $fld->TableRel)) . ";";
                //}
            }
        }
    }
    $code .= "\n use Illuminate\Http\Request;";
    $code .= "\n";
    $code .= "\nclass " . ucfirst(str_replace("_", "", $ControllerName)) . "Controller extends Controller";
    $code .= "\n{";
    $code .= "\n   /**";
    $code .= "\n    * Display a listing of the resource.";
    $code .= "\n    *";
    $code .= "\n    * @return \Illuminate\Http\Response";
    $code .= "\n    */\n";
    $code .= "\n   public function index()";
    $code .= "\n   {";
    $code .= "\n    \$" . ucfirst(str_replace("_", "", $ControllerName)) . " = " . ucfirst(str_replace("_", "", $ControllerName)) . "::paginate(10);";
    $code .= "\n       return view('" . str_replace("_", "", $ControllerName) . ".index')->with(['" . ucfirst(str_replace("_", "", $ControllerName)) . "List'=>\$" . ucfirst(str_replace("_", "", $ControllerName)) . ",'Title'=>'Lista de " . $ControllerName . "s','ActiveMenu'=>'" . $ControllerName . "s']);";
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

    $code .= "\n     return view('" . str_replace("_", "", $ControllerName) . ".create')->with([" . (substr($with, 1) != "" ? substr($with, 1) . "," : "") . "'Title'=>'Lista de " . $ControllerName . "','ActiveMenu'=>'" . $ControllerName . "']);";
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
    //$code .= "\n    \$" . $ControllerName . " = " . ucfirst(str_replace("_", "", $ControllerName)) . "::create(\$request->all());";
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
    $code .= "\n   \$" . $ControllerName . " = new " . ucfirst(str_replace("_", "", $ControllerName)) . ";";
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
    $code .= "\n    * @param  \App\ " . str_replace("_", "", $ControllerName) . "";
    $code .= "\n    * @return \Illuminate\Http\Response";
    $code .= "\n    */";
    $code .= "\n   public function show(\$id)";
    $code .= "\n   {";
    $code .= "\n      if (\$id!='All') {";
    $code .= "\n        \$" . $ControllerName . " = " . ucfirst(str_replace("_", "", $ControllerName)) . "::find(\$id);";
    $code .= "\n      }";
    $code .= "\n      else{";
    $code .= "\n        \$" . $ControllerName . " = " . ucfirst(str_replace("_", "", $ControllerName)) . "::All();";
    $code .= "\n      }";
    $code .= "\n      return $" . $ControllerName . ";";
    $code .= "\n    }";
    $code .= "\n";
    $code .= "\n";
    $code .= "\n   /**";
    $code .= "\n    * Show the form for editing the specified resource.";
    $code .= "\n    *";
    $code .= "\n    * @param  \App\ " . str_replace("_", "", $ControllerName);
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
    $code .= "\n     \$" . str_replace("_", "", $ControllerName) . " = " . ucfirst(str_replace("_", "", $ControllerName)) . "::find(\$id);";
    $code .= "\n      return view('" . $ControllerName . ".edit')->with(['" . ucfirst(str_replace("_", "", $ControllerName)) . "'=>$" . str_replace("_", "", $ControllerName) . $with . ",'Title'=>'Editar " . $ControllerName . "','ActiveMenu'=>'" . $ControllerName . "']);";
    $code .= "\n   }";
    $code .= "\n";
    $code .= "\n   /*";
    $code .= "\n    * Update the specified resource in storage";
    $code .= "\n    *";
    $code .= "\n    * @param  \Illuminate\Http\Request  \$request";
    $code .= "\n    * @param  \App\ " . str_replace("_", "", $ControllerName);
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
    $code .= "\n   \$" . $ControllerName . " = " . ucfirst(str_replace("_", "", $ControllerName)) . "::find(\$id);";
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
    $code .= "\n    * @param  \App\models\\" . str_replace("_", "", $ControllerName);
    $code .= "\n    * @return \Illuminate\Http\Response\n";
    $code .= "\n    */";
    $code .= "\n   public function destroy(\$id)";
    $code .= "\n   {";
    $code .= "\n      \$" . str_replace("_", "", $ControllerName) . " = " . ucfirst(str_replace("_", "", $ControllerName)) . "::find(\$id);";
    $code .= "\n       \$" . str_replace("_", "", $ControllerName) . "->delete();";
    $code .= "\n       return view('" . str_replace("_", "", $ControllerName) . ".index');";
    $code .= "\n   }";
    $code .= "\n}";
    $code .= "  \n";
    return $code;
}


function genModel($ModelName, $fields)
{
   // print_r ("FIELDS ".json_encode($fields));
    $code = "<?php";
    $code .= "\n";
    $code .= "\nnamespace App\Models;";
    $code .= "\n";
    $code .= "\nuse Illuminate\Database\Eloquent\Model;";
    $code .= "\n";
    $code .= "\nclass " . ucfirst(str_replace("_", "", $ModelName)) . " extends Model";
    $code .= "\n{";
    $code .= "\n    protected \$table = '" . $ModelName . "';";
    $code .= "\n    protected \$primaryKey = '" . $fields[0]->FieldName . "';";
    $code .= "\n";
    $Models = array();
    foreach ($fields as $fld) {
        print_r("Entro 1 ");
        if (!in_array($fld->TableRel, $Models)) {
            echo "entro 2 -> FOMTYPE =".$fld->FormType.' - is relation = '.$fld->FormType == 'Relation' || ($fld->FormType == 'List').' tableel fields not null = '.($fld->TableRel != '' && $fld->FieldRel != '' && $fld->FieldDisplay != '');
            if (($fld->FormType == 'Relation' || ($fld->FormType == 'List') && ($fld->TableRel != '' && $fld->FieldRel != '' && $fld->FieldDisplay != ''))) {
                echo "entro 3";
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
    $code = '\n  /* *************************************************/';
    $code .= '\n /* Funcion JS para Borrar el registro              */';
    $code .= '\n /* @parameter $id                                  */';
    $code .= '\n /* @return Error = array([\'Error\',\'Messages\']) */';
    $code .= '\n /* *************************************************/';
    $code .= '\n';
    $code .= "\nfunction delete_" . ucfirst(str_replace("_", "", $ModelName)) . "(id){";
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
    $code .= "\n                    \$.post('/admin/" . str_replace("_", "", $ModelName) . "/delete/'+id,{\"_token\": \"{{@csrf_token()}}\",\"_method\":\"delete\"},function(){";
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
    $code = '\n  /* *************************************************/';
    $code .= '\n /* Funcion JS para Editar un registro              */';
    $code .= '\n /* @parameter $id                                  */';
    $code .= '\n /* @return array  of ' . $ModelName . '                */';
    $code .= '\n /* *************************************************/';
    $code .= '\n';
    $code .= "\nfunction editar_" . ucfirst(str_replace("_", "", $ModelName)) . "(id){";
    $code .= "\n                    \$.get('/admin/" . str_replace("_", "", $ModelName) . "/'+id,{},function(response){";
    foreach ($fields as $field) {
        $code .= "\n                         $(\"#" . $field . "_e\").val(response." . $field . ")";
    }
    $code .= "\n            })";
    $code .= "\n        }";
}


function GenViewIndex($ModelName, $fields)
{
    $code = "";
    $code .= " @extends('layouts.admin')";
    $code .= "\n @section('contenido')\n";
    $code .= "<div class=\"row\"><button class=\"btn btn-success\" onclick=\"window.location.assign('/admin/" . str_replace("_", "", $ModelName) . "/create')\">Agregar</button></div>";
    $code .= "\n <table class=\"table table-bordered table-striped table-sm\">";
    $code .= "\n        <thead>";
    $code .= "\n        <tr>";
    $code .= "\n            <th><i class=\"fas fa-toolbox\"></i></th>";
    foreach ($fields as $fld) {
        if ($fld->ShowInList) {
            $code .= "\n            <th>" . $fld->Label . "</th>";
        }
    }
    $code .= "\n        </tr>";
    $code .= "\n      </thead>";
    $code .= "\n        <tbody>";
    $code .= "\n    @foreach(\$" . ucfirst(str_replace("_", "", $ModelName)) . "List as \$row)";
    $code .= "\n            <tr>";
    $code .= "\n                <td>";
    $code .= "\n                    <a href=\"/admin/" . $ModelName . "/edit/{{ \$row->id }}\" title=\"Editar " . str_replace("_", "", $ModelName) . "\" class=\"btn btn-xs btn-outline-primary\"><i class=\"fas fa-edit\"></i></a>";
    $code .= "\n                    <a href=\"#\" class=\"btn btn-xs btn-outline-danger\" title=\"Borrar " . $ModelName . "\" onclick=\"delete" . ucfirst(str_replace("_", "", $ModelName)) . "({{ \$row->id }})\"><i class=\"fas fa-trash-alt\"></i></a>";
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
    $code .= "\n    <div class=\"row\">{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "List->links() }}</div>";
    $code .= "\n    <script>";
    $code .= "\nfunction delete" . ucfirst(str_replace("_", "", $ModelName)) . "(id){";
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
    $code .= "\n                    \$.post('/admin/" . str_replace("_", "", $ModelName) . "/delete/'+id,{\"_token\": \"\{{@csrf_token()}}\",\"_method\":\"delete\"},function(){";
    $code .= "\n                        Swal.fire(";
    $code .= "\n                            'Borrado!',";
    $code .= "\n                            '" . $ModelName . " borrado.',";
    $code .= "\n                            'success'";
    $code .= "\n                        )";
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
    $code .= "\n<form class= \"form-horizontal\" action=\"{{ route('" . $ModelName . ".update',\$" . ucfirst(str_replace("_", "", $ModelName)) . "->id) }}\" method=\"POST\" enctype=\"multipart/form-data\">";
    $code .= "\n@csrf";
    $code .= "\n@method('PATCH')";
    $code .= "\n<div class=\"card-body\">";
    foreach ($fields as $fld) {
        if (isset($fld->ShowInEdit) && $fld->ShowInEdit) {
            if ($fld->FormType == "Text" || $fld->FormType == "Money") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"text\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }

            if ($fld->FormType == "TextArea") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<textarea row=\"4\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}</textarea>";
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
                $code .= "\n<input type=\"password\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Email") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"email\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Date") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"date\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Number") {
                $code .= "\n<div class=\"form-group\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"number\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
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
                    $code .= "\n<input type=\"radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "_" . $k . "\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
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
                    $code .= "\n<input type=\"checkbox\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\"> {{ (" . $valor->Value . " == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'checked':'') }} " . $valor->Label;
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
                    $code .= "\n<input type=\"Radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
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
                    $code .= "\n <option value=\"$y\"  {{ ($y== \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }}>$y </option>";
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
                    $code .= "\n <option value=\"$mes\" {{ ($mes== \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }} >$mestext </option>";
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

                //{{ (\"$valor->Value\" == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }}
            }
            //generate JavaScript Ajax Events
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
        }
    }

    $code .= "\n<a class=\"btn btn-secondary\" href=\"{{ route('" . $ModelName . ".index') }}\"> Regresar</a>";
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
    $code = "";
    $code .= "    <div class=\"modal fade\" id=\"modal_" . $modelName . "\" role=\"dialog\">";
    $code .= "    <div class=\"modal-dialog modal-lg\">";
    $code .= "      <div class=\"modal-content\">";
    $code .= "        <div class=\"modal-header\">;";
    $code .= "          <button type=\"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>";
    $code .= "          <h4 class=\"modal-title\">Editar " . strtoupper($modelName) . "</h4>";
    $code .= "        </div>";
    $code .= "        <div class=\"modal-body\">";
    return $code;
}


function GenModalEnd($modelName)
{
    $code = "";
    $code .= "    </div>";
    $code .= "        <div class=\"modal-footer\">";
    $code .= "          <button type=\"button\" class=\"btn btn-default btn-sm\" data-dismiss=\"modal\">Cerrar</button>";
    $code .= "          <button type=\"button\" class=\"btn btn-default btn-success btn-sm save-edit-" . $modelName . "\" >Grabar</button>";
    $code .= "        </div>";
    $code .= "      </div>";
    $code .= "    </div>";
    $code .= "  </div>";
    $code .= "</div>";
    return $code;
}


function GenViewEditModal($ModelName, $fields)
{
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
    $code .= "\n<form id=\"frmEdit" . $ModelName . "\" class= \"form-horizontal\" action=\"{{ route('" . $ModelName . ".update',\$" . ucfirst(str_replace("_", "", $ModelName)) . "->id) }}\" method=\"POST\" enctype=\"multipart/form-data\">";
    $code .= "\n@csrf";
    $code .= "\n@method('PATCH')";
    $code .= "\n<div class=\"card-body\">";
    foreach ($fields as $fld) {
        if (isset($fld->ShowInEdit) && $fld->ShowInEdit) {
            if ($fld->FormType == "Text" || $fld->FormType == "Money") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"text\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "TextArea") {
                $code .= "\n<div class=\"form-group  col-md-4\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<textarea row=\"4\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}</textarea>";
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
                $code .= "\n<input type=\"password\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Email") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"email\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Date") {
                $code .= "\n<div class=\"form-group col-md-2\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"date\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Number") {
                $code .= "\n<div class=\"form-group col-md-2\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"number\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
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
                    $code .= "\n<input type=\"radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "_" . $k . "\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
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
                    $code .= "\n<input type=\"checkbox\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\"> {{ (" . $valor->Value . " == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'checked':'') }} " . $valor->Label;
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
                    $code .= "\n<input type=\"Radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
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
                $code .= "\n <option value=\"{{ \$row->" . $fld->FieldRel . " }}\" {{ (\$row->" . $fld->FieldRel . "== \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }} >{{ \$row->" . $fld->FieldDisplay . " }}</option>";
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
                    $code .= "\n <option value=\"$valor->Value\" {{ (\"$valor->Value\" == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }} >$valor->Label </option>";
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
    $code .= "\n<form id=\"frmEdit" . $ModelName . "\" class= \"form-horizontal\" action=\"{{ route('" . $ModelName . ".create',\$" . ucfirst(str_replace("_", "", $ModelName)) . "->id) }}\" method=\"POST\" enctype=\"multipart/form-data\">";
    $code .= "\n@csrf";
    $code .= "\n@method('PATCH')";
    $code .= "\n<div class=\"card-body\">";
    foreach ($fields as $fld) {
        if (isset($fld->ShowInCreate) && $fld->ShowInCreate) {
            if ($fld->FormType == "Text" || $fld->FormType == "Money") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"text\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "TextArea") {
                $code .= "\n<div class=\"form-group  col-md-4\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<textarea row=\"4\" maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\"  class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}</textarea>";
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
                $code .= "\n<input type=\"password\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Email") {
                $code .= "\n<div class=\"form-group col-md-3\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"email\"  maxlength=\"" . $fld->Long . "\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Date") {
                $code .= "\n<div class=\"form-group col-md-2\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"date\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
                $code .= "\n@if(\$errors->has('" . $fld->FieldName . "'))";
                $code .= "\n<div class=\"alert-danger\">{{ \$errors->first('" . $fld->FieldName . "') }}</div>";
                $code .= "\n@endif";
                $code .= "\n</div>";
            }
            if ($fld->FormType == "Number") {
                $code .= "\n<div class=\"form-group col-md-2\">";
                $code .= "\n<label for=\"" . $fld->FieldName . "\" class=\"col-sm-4 control-label\">" . $fld->Label . "</label>";
                $code .= "\n<input type=\"number\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "\" value=\"{{ \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . " }}\" class=\"form-control\" placeholder=\"" . $fld->FieldName . "\">";
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
                    $code .= "\n<input type=\"radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "_" . $k . "\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
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
                    $code .= "\n<input type=\"checkbox\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\"> {{ (" . $valor->Value . " == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'checked':'') }} " . $valor->Label;
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
                    $code .= "\n<input type=\"Radio\" name=\"" . $fld->FieldName . "\" id=\"" . $fld->FieldName . "[]\" value=\"" . $valor->Value . "\" class=\"\" {{ (" . $valor->Value . " == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'checked':'') }} > " . $valor->Label;
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
                $code .= "\n <option value=\"{{ \$row->" . $fld->FieldRel . " }}\" {{ (\$row->" . $fld->FieldRel . "== \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }} >{{ \$row->" . $fld->FieldDisplay . " }}</option>";
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
                    $code .= "\n <option value=\"$valor->Value\" {{ (\"$valor->Value\" == \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }} >$valor->Label </option>";
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
    $jsCode = '';
    $code = "";
    $code .= "\n@extends('layouts.admin')";
    $code .= "\n@section('contenido')";
    $code .= "\n<div class=\"row\">";
    $code .= "\n<div class=\"col-md-12\">";
    $code .= "\n<div class=\"card\">";
    $code .= "\n<div class=\"card-header\">";
    $code .= "\n<h2 class=\"\">Nuevo " . $ModelName . "</h2>";
    $code .= "\n</div>";
    $code .= "\n<div class=\"pull-right\">";
    $code .= "\n@if (\$errors->any())";
    $code .= "\n<div class=\"alert alert-danger\">";
    $code .= "\n<strong>Whoops!</strong> Hay error en los datos de entrada<br><br>";
    $code .= "\n</div>";
    $code .= "\n@endif";
    $code .= "\n<form class= \"form-horizontal\" action=\"{{ route('" . $ModelName . ".create') }}\" method=\"POST\" method=\"POST\" enctype=\"multipart/form-data\">";
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
                $code .= "\n <option value=\"{{ \$row->" . $fld->FieldRel . " }}\" {{ (\$row->" . $fld->FieldRel . "== \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }}>{{ \$row->" . $fld->FieldDisplay . " }}</option>";
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
                    $code .= "\n <option value=\"$valor->Value\" {{ (\$row->" . $fld->FieldRel . "== \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }} >$valor->Label</option>";
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
                    $code .= "\n <option value=\"$y\"  {{ ($y== \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }}>$y </option>";
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
                    $code .= "\n <option value=\"$mes\" {{ ($mes== \$" . ucfirst(str_replace("_", "", $ModelName)) . "->" . $fld->FieldName . "?'selected':'') }} >$mestext </option>";
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

    $code .= "\n<a class=\"btn btn-secondary\" href=\"{{ route('" . $ModelName . ".index') }}\"> Regresar</a>";
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
    $code .= "\n  class " . ucfirst($ModelName) . " extends Migration";
    $code .= "\n  {";
    $code .= "\n      /**";
    $code .= "\n       * Run the migrations.";
    $code .= "\n       *";
    $code .= "\n       * @return void";
    $code .= "\n       */";
    $code .= "\n      public function up()";
    $code .= "\n      {";
    $code .= "\n          Schema::create('" . ucfirst($ModelName) . "', function (Blueprint \$table) {";
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
    $code .= "\n      public function down()";
    $code .= "\n      {";
    $code .= "\n          Schema::dropIfExists('" . ucfirst($ModelName) . "');";
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
//print_r($Comandos);
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
        $jsonConfig = $db->readStructure(strtoupper($Comandos['TABLES'][0]) == 'ALL' ? array() : $Comandos['TABLES']);
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
    //print_r($jsonConfig);exit(0);
}
print_r($Comandos["MAKE"]);

echo "\n Comenzando el proceso de Generación de codigo.....";
sleep(1);
foreach ($jsonConfig->Tables as $tbl) {
    sleep(1);
    foreach ($Comandos["MAKE"] as $mk) {
        if (strtoupper($Comandos["TABLES"][0]) != 'ALL') {
            if (in_array($tbl->TableName, $Comandos["TABLES"])) {
                if (strtoupper($mk) == 'CONTROLLER') {
                    echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                    $data = GenController($tbl->TableName, $tbl->fields);
                    $myfile = fopen("app/Http/Controllers/" . ucfirst(str_replace("_", "", $tbl->TableName)) . 'Controller.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                }
                if (strtoupper($mk) == 'MODEL') {
                    echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                    $data = GenModel($tbl->TableName, $tbl->fields);
                    $myfile = fopen("app/Models/" . ucfirst(str_replace("_", "", $tbl->TableName)) . '.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                }
                if (strtoupper($mk) == 'MIGRATIONS') {
                    echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                    $data = GenMigration($tbl->TableName, $tbl->fields);
                    $myfile = fopen("database/migrations/" . date('Y_m_d_His') . "_create_" . $tbl->TableName . '.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                }

                if (strtoupper($mk) == 'VIEW') {
                    echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                    if (!file_exists('resources/views/' . str_replace("_", "", $tbl->TableName))) {
                        mkdir('resources/views/' . str_replace("_", "", $tbl->TableName));
                    }

                    //INDEX
                    $data = GenViewIndex($tbl->TableName, $tbl->fields);
                    $myfile = fopen('resources/views/' . str_replace("_", "", $tbl->TableName) . '/index.blade.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                    //EDIT
                    $data = GenViewCreate($tbl->TableName, $tbl->fields);
                    $myfile = fopen('resources/views/' . str_replace("_", "", $tbl->TableName) . '/create.blade.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                    //CREATE
                    $data = GenViewEdit($tbl->TableName, $tbl->fields);
                    $myfile = fopen('resources/views/' . str_replace("_", "", $tbl->TableName) . '/edit.blade.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                }
                if (strtoupper($mk) == 'VIEW-MODAL') {
                    if (!file_exists('resources/views/' . str_replace("_", "", $tbl->TableName) . '/modal')) {
                        @mkdir('resources/views/' . str_replace("_", "", $tbl->TableName) . '/modal');
                    }


                    //EDIT MODAL
                    $data = GenViewEditModal($tbl->TableName, $tbl->fields);
                    $myfile = fopen('resources/views/' . str_replace("_", "", $tbl->TableName) . '/modal/edit.blade.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);
                    //CREATE MODAL
                    $data = GenViewCreateModal($tbl->TableName, $tbl->fields);
                    $myfile = fopen('resources/views/' . str_replace("_", "", $tbl->TableName) . '/modal/create.blade.php', "w") or die("Unable to open file!");
                    fwrite($myfile, $data);
                    fclose($myfile);


                }
                if (strtoupper($mk) == 'ROUTE' || strtoupper($mk) == 'ROUTES') {
                    GenRoutesWEB($tbl->TableName);
                    echo "\n Agregando Rutas del Modelo " . $tbl->TableName;
                }
            }
        } else {
            if (strtoupper($mk) == 'CONTROLLER') {
                echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                $data = GenController($tbl->TableName, $tbl->fields);
                $myfile = fopen("app/Http/Controllers/" . ucfirst(str_replace("_", "", $tbl->TableName)) . 'Controller.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
            }
            if (strtoupper($mk) == 'MODEL') {
                echo "\n Generando " . ucfirst($mk) . " de la Tabla " . $tbl->TableName;
                $data = GenModel($tbl->TableName, $tbl->fields);
                $myfile = fopen("app/Models/" . ucfirst(str_replace("_", "", $tbl->TableName)) . '.php', "w") or die("Unable to open file!");
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
                if (!file_exists('resources/views/' . str_replace("_", "", $tbl->TableName))) {
                    mkdir('resources/views/' . str_replace("_", "", $tbl->TableName));
                }
                //index
                $data = GenViewIndex($tbl->TableName, $tbl->fields);
                $myfile = fopen('resources/views/' . str_replace("_", "", $tbl->TableName) . '/index.blade.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
                //EDIT
                $data = GenViewEdit($tbl->TableName, $tbl->fields);
                $myfile = fopen('resources/views/' . str_replace("_", "", $tbl->TableName) . '/edit.blade.php', "w") or die("Unable to open file!");
                fwrite($myfile, $data);
                fclose($myfile);
                //CREATE
                $data = GenViewCreate($tbl->TableName, $tbl->fields);
                $myfile = fopen('resources/views/' . str_replace("_", "", $tbl->TableName) . '/create.blade.php', "w") or die("Unable to open file!");
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
echo "\n * * * La Generación de Código terminó satisfactoriamente * * *";
sign();
