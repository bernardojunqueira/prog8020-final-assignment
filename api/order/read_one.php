<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');

// include database and object files
include_once '../config/database.php';
include_once '../objects/order.php';
include_once '../objects/orderDetail.php';
include_once '../shared/token.php';

// json web token
$token = new Token();

// authorize user with jwt
if (isset(apache_request_headers()['Authorization']) and $token->validate((apache_request_headers()['Authorization']))) {

    // get database connection
    $database = new Database();
    $db = $database->getConnection();

    // prepare order object
    $order = new Order($db);

    // set ID property of record to read
    $order->orderid = isset($_GET['id']) ? $_GET['id'] : die();

    // read the details of order to be edited
    $order->readOne();

    if ($order->custid != null) {
        // create array
        $order_arr = array(
            "orderid" => $order->orderid,
            "custid" => $order->custid,
            "empid" => $order->empid,
            "orderdate" => $order->orderdate,
            "requireddate" => $order->requireddate,
            "shippeddate" => $order->shippeddate,
            "shipperid" => $order->shipperid,
            "freight" => $order->freight,
            "shipname" => $order->shipname,
            "shipaddress" => $order->shipaddress,
            "shipcity" => $order->shipcity,
            "shipregion" => $order->shipregion,
            "shippostalcode" => $order->shippostalcode,
            "shipcountry" => $order->shipcountry,
            "details" => $order->details
        );

        // set response code - 200 OK
        http_response_code(200);

        // make it json format
        echo json_encode($order_arr);
    } else {
        // set response code - 404 Not found
        http_response_code(404);

        // tell the user order does not exist
        echo json_encode(array("message" => "Order does not exist."));
    }
} else {

    // set response code
    http_response_code(401);

    // tell the user access denied
    echo json_encode(array("message" => "Access denied."));
}