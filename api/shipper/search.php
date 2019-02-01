<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// include database and object files
include_once '../config/core.php';
include_once '../config/database.php';
include_once '../objects/shipper.php';
include_once '../shared/token.php';

// json web token
$token = new Token();

// authorize user with jwt
if (isset(apache_request_headers()['Authorization']) and $token->validate((apache_request_headers()['Authorization']))) {

    // instantiate database and shipper object
    $database = new Database();
    $db = $database->getConnection();

    // initialize object
    $shipper = new Shipper($db);

    // get keywords
    $keywords = isset($_GET["s"]) ? $_GET["s"] : "";

    // query shippers
    $stmt = $shipper->search($keywords);
    $num = $stmt->rowCount();

    // check if more than 0 record found
    if ($num > 0) {

        // shippers array
        $shippers_arr = array();
        $shippers_arr["records"] = array();

        // retrieve our table contents
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            // extract row
            // this will make $row['name'] to
            // just $name only
            extract($row);

            $shipper_item = array(
                "shipperid" => $shipperid,
                "companyname" => $companyname,
                "phone" => $phone
            );

            array_push($shippers_arr["records"], $shipper_item);
        }

        // set response code - 200 OK
        http_response_code(200);

        // show shippers data
        echo json_encode($shippers_arr);
    } else {
        // set response code - 404 Not found
        http_response_code(404);

        // tell the user no shippers found
        echo json_encode(
            array("message" => "No shippers found.")
        );
    }
} else {

    // set response code
    http_response_code(401);

    // tell the user access denied
    echo json_encode(array("message" => "Access denied."));
}