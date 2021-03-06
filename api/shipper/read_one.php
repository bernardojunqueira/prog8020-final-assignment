<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');

// include database and object files
include_once '../config/database.php';
include_once '../objects/shipper.php';
include_once '../shared/token.php';

// json web token
$token = new Token();

// authorize user with jwt
if (isset(apache_request_headers()['Authorization']) and $token->validate((apache_request_headers()['Authorization']))) {

    // get database connection
    $database = new Database();
    $db = $database->getConnection();

    // prepare shipper object
    $shipper = new Shipper($db);

    // set ID property of record to read
    $shipper->shipperid = isset($_GET['id']) ? $_GET['id'] : die();

    // read the details of shipper to be edited
    $shipper->readOne();

    if ($shipper->companyname != null) {
        // create array
        $shipper_arr = array(
            "shipperid" => $shipper->shipperid,
            "companyname" => $shipper->companyname,
            "phone" => $shipper->phone
        );

        // set response code - 200 OK
        http_response_code(200);

        // make it json format
        echo json_encode($shipper_arr);
    } else {
        // set response code - 404 Not found
        http_response_code(404);

        // tell the user shipper does not exist
        echo json_encode(array("message" => "Shipper does not exist."));
    }
} else {

    // set response code
    http_response_code(401);

    // tell the user access denied
    echo json_encode(array("message" => "Access denied."));
}