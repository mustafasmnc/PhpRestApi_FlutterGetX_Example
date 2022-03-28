<?php

//Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: DELETE');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers,Content-Type,Access-Control-Allow-Methods,Authorization,X-Requested-With');

include_once '../../config/Database.php';
include_once '../../models/Category.php';

//Instantiate DB & Connect
$database = new Database();
$db=$database->connect();

//Instantiate blog category object
$category = new Category($db);

//Get raw posted data
$data=json_decode(file_get_contents("php://input"));

//Set ID to update
$category->id=$data->id;

//Check ID if exist in DB table
if($category->checkID($category->id)){

    //Delete category
    if($category->delete()){
        echo json_encode(
            array('message'=>'Category Deleted')
        );
        
    }else{
        echo json_encode(
            array('message'=>'Category Not Deleted')
        );
    }
}
else{
    http_response_code(404);
    //header("HTTP/1.0 404 Not Found");
    echo json_encode(
        array('message'=>'Not Found')
    );
}


?>