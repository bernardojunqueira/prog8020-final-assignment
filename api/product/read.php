<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// include database and object files
include_once '../config/database.php';
include_once '../objects/product.php';
include_once '../shared/token.php';

// json web token
$token = new Token();

// authorize user with jwt
if(isset(apache_request_headers()['Authorization']) and $token->validate((apache_request_headers()['Authorization']))){

    // instantiate database and product object
    $database = new Database();
    $db = $database->getConnection();
    $product = new Product($db);

    // query product
    $stmt = $product->read();
    $num = $stmt->rowCount();

    // check if more than 0 record found
    if($num>0){

        // products array
        $products_arr=array();
        $products_arr["records"]=array();

        // retrieve our table contents
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            // extract row
            // this will make $row['name'] to
            // just $name only
            extract($row);

            $product_item=array(
                "productid" => $productid,
                "productname" => $productname,
                "companyname" => $companyname,
                "categoryname" => $categoryname,
                "unitprice" => $unitprice,
                "discontinued" => $discontinued
            );

            array_push($products_arr["records"], $product_item);
        }

        // set response code - 200 OK
        http_response_code(200);

        // show products data in json format
        echo json_encode($products_arr);
    }
    else{

        // set response code - 404 Not found
        http_response_code(404);

        // tell the user no products found
        echo json_encode(
            array("message" => "No products found.")
        );
    }
} else {

    // set response code
    http_response_code(401);

    // tell the user access denied
    echo json_encode(array("message" => "Access denied."));
}