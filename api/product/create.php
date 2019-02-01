<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// include database and object files
include_once '../config/database.php';
include_once '../objects/product.php';
include_once '../shared/token.php';

// json web token
$token = new Token();

// authorize user with jwt
if(isset(apache_request_headers()['Authorization']) and $token->validate((apache_request_headers()['Authorization']))){

    // instantiate database and category object
    $database = new Database();
    $db = $database->getConnection();
    $product = new Product($db);

    // get posted data
    $data = json_decode(file_get_contents("php://input"));

    // make sure data is not empty
    if(
        !empty($data->categoryid) &&
        !empty($data->productname) &&
        !empty($data->supplierid) &&
        !empty($data->unitprice)

    ){

        // set product property values
        $product->categoryid = $data->categoryid;
        $product->discontinued = isset($data->discontinued) ? true : false;
        $product->productname = $data->productname;
        $product->supplierid = $data->supplierid;
        $product->unitprice = $data->unitprice;

        // create the product
        if($product->create()){

            // set response code - 201 created
            http_response_code(201);

            // tell the user
            echo json_encode(array("message" => "Product was created."));
        }

        // if unable to create the product, tell the user
        else{

            // set response code - 503 service unavailable
            http_response_code(503);

            // tell the user
            echo json_encode(array("message" => "Unable to create product."));
        }
    }

    // tell the user data is incomplete
    else{

        // set response code - 400 bad request
        http_response_code(400);

        // tell the user
        echo json_encode(array("message" => "Unable to create product. Data is incomplete."));
    }

} else {

    // set response code
    http_response_code(401);

    // tell the user access denied
    echo json_encode(array("message" => "Access denied."));
}