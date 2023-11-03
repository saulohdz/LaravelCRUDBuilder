██╗  ██╗██████╗  ██████╗ ███████╗ ██████╗ ██╗     ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
██║  ██║██╔══██╗██╔════╝ ██╔════╝██╔═══██╗██║     ██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
███████║██████╔╝██║  ███╗███████╗██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
██╔══██║██╔══██╗██║   ██║╚════██║██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
██║  ██║██║  ██║╚██████╔╝███████║╚██████╔╝███████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║███████║
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


 LARAVEL 7.0
   ____ ____  _   _ ____                                    _
  / ___|  _ \| | | |  _ \    __ _  ___ _ __   ___ _ __ __ _| |_ ___  _ __
 | |   | |_) | | | | | | |  / _` |/ _ \ '_ \ / _ \ '__/ _` | __/ _ \| '__|
 | |___|  _ <| |_| | |_| | | (_| |  __/ | | |  __/ | | (_| | || (_) | |
  \____|_| \_\\___/|____/   \__, |\___|_| |_|\___|_|  \__,_|\__\___/|_|
                            |___/
BY

---------------------------------------------------------------------    
┌─┐┌─┐┬ ┬┬  ┌─┐ ┬ ┬┌─┐┬─┐┌┐┌┌─┐┌┐┌┌┬┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐┬┬   ┌─┐┌─┐┌┬┐    
└─┐├─┤│ ││  │ │ ├─┤├┤ ├┬┘│││├─┤│││ ││├┤ ┌─┘│└┘│ ┬│││├─┤││   │  │ ││││    
└─┘┴ ┴└─┘┴─┘└─┘o┴ ┴└─┘┴└─┘└┘┴ ┴┘└┘─┴┘└─┘└─┘└──└─┘┴ ┴┴ ┴┴┴─┘o└─┘└─┘┴ ┴    
---------------------------------------------------------------------    
Laravel CRUD generator is a tool designed for Rapid Develpment
en task repetitives, this tools generate Views, Controllers, and Models
for PHP Laravel Framework 5.8 and grather.

HELP

 Builder for Laravel 7.0 by Saulo Hernandez O.  

 Based in AdminLTE V3 template  (copyright adminlte.io)                                                            
 ------------------------------------------------                                                           
 Command :  php builder parameter #1 parameter #2 parameter #3                                            
 Paramaters :                                                                                               
        GenStructure=file.json  -> generate file JSON if database structure based in .ENV file , this command execute alone
        and not execute together whit the other commands                                                      
        configfile:file.json file with the structure en database generated                                            
        tables:| All  or  table 1,table 2,...,table n|  Tables that you want generate                          
        make:controller|,model,|view,|route|migrations "generate Controllers, Models, View, Migartions and/or routes of tables"
         (generate file webroutes.php, this file maybe included in web.php)

Note: Put This file in new Laravel folder project

	file.json structure  EXAMPLE:
	{
	    "Database": "creeserjuntos",
	    "DatabaseType": "MySql",
	    "host": "127.0.0.1",
	    "dbuser": "root",
	    "dbpassword": "",
	    "Tables": [ /* Array of Objects of tables  */
        {
            "TableName": "contactos",
            "config": {
                "editPage": "upd_contactos.php",
                "newPage": "add_contactos.php",
                "viewPage": "view_contactos.php",
                "functionEdit": "",
                "functionDelete": "",
                "functionView": "",
                "PrimaryKey": "id",
                "buttons": {
                    "Add": true,
                    "Delete": true,
                    "Edit": true,
                    "View": true
                }
            },
            "fields": [/*Array of Objects of fields of table */
                {
                    "FieldName": "id",		 --> Field Name
                    "TableName": "contactos",	 --> Table Container belong field
                    "LongMax": "0",		 --> Long of Field
                    "Long": "20",                --> Long of Database Type 
                    "NumberCharSet": "63",       --> Char Set
                    "Flags": "36865",            --> Database Flags
                    "FormType": "Text",          --> Form Input Type (Text, Date, Relation(Select2),Radio, Check, Boolean,Email,List)
                    "SubType": "",		 --> Used with specified behavior of Formtype ()
                    "Label": "",		 --> Label show in Form
                    "PK": "true",		 --> Tthe field is PK = true or false
                    "AI": "true",                --> The Field is Auto Increment
                    "Validation": "" ,/* laravel validation rules*/
                    "TableRel": "",		 --> This config is use with FormType=Relation, TableRel = Table related
                    "FieldRel": "",              --> This config is use with FormType=Relation, FielRel = Pk Field in Table ralated
                    "FieldDisplay": "",          --> Fiels displayed in result of relation
                    "ChildTable": "",		 --> not used yet
                    "IdParent": "",		 --> not used yet
                    "ChildDisplay": "",		 --> not used yet
                    "UseCombo": "",		 --> used if showing a Select Box with Result of relation
                    "ShowInList": "",		 --> If this field showing in index view
                    "ShowInDetails": "",	 --> if this field showing in Details view in master detail view (not yet used)
                    "ShowInCreate": "",	 --> if this field showing in Details view create
                    "ShowInEdit": "",	 --> if this field showing in Details view edit
                    "ReadOnly": "",		 --> If this field is read only in form
                    "Format": "",                --> Formating view of this field in index view
                    "Width": "",
                    "Heigth": "",
                    "Values": [],		 /* array json with values in Fields type Check, Radio, List  example -> [{"Label":"Admin","Value":true},{},{}]
                    "ViewIcon":false,    /*  if is true show the icon related to value
                    "IconValues": [],    /* array json with images related to values  in Fields type Check, Radio, List example ->[{"Value":true,"Icon":"/img/admin.png"},{}], and show  front value 
                    "FieldDbType": "8"           --> Field Data base Type numeric
                },
                {
                     
                                                                                                            
