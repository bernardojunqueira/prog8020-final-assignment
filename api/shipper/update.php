<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

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

    // get id of shipper to be edited
    $data = json_decode(file_get_contents("php://input"));

    // set ID property of shipper to be edited
    $shipper->shipperid = $data->shipperid;

    // set shipper property values
    $shipper->companyname = $data->companyname;
    $shipper->phone = $data->phone;

    // update the shipper
    if ($shipper->update()) {

        // set response code - 200 ok
        http_response_code(200);

        // tell the user
        echo json_encode(array("message" => "Shipper was updated."));
    } // if unable to update the shipper, tell the user
    else {

        // set response code - 503 service unavailable
        http_response_code(503);

        // tell the user
        echo json_encode(array("message" => "Unable to update shipper."));
    }
} else {

    // set response code
    http_response_code(401);

    // tell the user access denied
    echo json_encode(array("message" => "Access denied."));
}