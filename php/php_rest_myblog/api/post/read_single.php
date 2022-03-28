<?php

//Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

include_once '../../config/Database.php';
include_once '../../models/Post.php';

//Instantiate DB & Connect
$database = new Database();
$db=$database->connect();

//Instantiate blog post object
$post = new Post($db);

//Get ID
$post->id=isset($_GET['id']) ? $_GET['id'] : die();

//Check ID if exist in DB table
if($post->checkID($post->id)){

    //Get post 
    $post->read_single();

    //Create array
    $post_arr=array(
        'id'=>$post->id,
        'title'=>$post->title,
        'body'=>$post->body,
        'author'=>$post->author,
        'category_id'=>$post->category_id,
        'category_name'=>$post->category_name
    );

    // Make JSON
    print_r(json_encode($post_arr));    
}else{
    http_response_code(404);
    //header("HTTP/1.0 404 Not Found");
    echo json_encode(
        array('message'=>'Not Found')
    );
}


?>