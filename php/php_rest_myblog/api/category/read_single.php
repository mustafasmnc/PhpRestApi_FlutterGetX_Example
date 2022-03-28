<?php

//Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

include_once '../../config/Database.php';
include_once '../../models/Category.php';

//Instantiate DB & Connect
$database = new Database();
$db=$database->connect();

//Instantiate blog category object
$category = new Category($db);

//Get ID
$category->id=isset($_GET['id']) ? $_GET['id'] : die();

if($category->checkID($category->id)){
    
    //Get category 
    $category->read_single();

    //Create array
    $category_arr=array(
        'id'=>$category->id,
        'name'=>$category->name
    );

    // Make JSON
    print_r(json_encode($category_arr));
}else{
    http_response_code(404);
    //header("HTTP/1.0 404 Not Found");
    echo json_encode(
        array('message'=>'Not Found')
    );
}


?>