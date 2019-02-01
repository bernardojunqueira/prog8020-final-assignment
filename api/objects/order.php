<?php
/**
 * Created by PhpStorm.
 * User: bernardojunqueira
 * Date: 11/12/2018
 * Time: 8:30 PM
 */

class Order
{
    // database connection and table name
    private $conn;
    private $table_name = "ord";
    private $details_table_name = "ordd";
    private $products_table_name = "prod";

    // object properties
    public $orderid;
    public $custid;
    public $empid;
    public $orderdate;
    public $requireddate;
    public $shippeddate;
    public $shipperid;
    public $freight;
    public $shipname;
    public $shipaddress;
    public $shipcity;
    public $shipregion;
    public $shippostalcode;
    public $shipcountry;
    public $orderdetails;
    public $details = array();

    // constructor with $db as database connection
    public function __construct($db){
        $this->conn = $db;
    }

    // create order
    function create(){

        // query to insert record
        $query = "INSERT INTO
                " . $this->table_name . "
            SET
                custid=:custid, 
                empid=:empid,
                orderdate=:orderdate,
                requireddate=:requireddate,
                shippeddate=:shippeddate,
                shipperid=:shipperid,
                freight=:freight,
                shipname=:shipname,
                shipaddress=:shipaddress,
                shipcity=:shipcity,
                shipregion=:shipregion,
                shippostalcode=:shippostalcode,
                shipcountry=:shipcountry";

        // prepare query
        $stmt = $this->conn->prepare($query);

        // sanitize
        $this->custid=htmlspecialchars(strip_tags($this->custid));
        $this->empid=htmlspecialchars(strip_tags($this->empid));
        $this->orderdate=htmlspecialchars(strip_tags($this->orderdate));
        $this->requireddate=htmlspecialchars(strip_tags($this->requireddate));
        $this->shippeddate=htmlspecialchars(strip_tags($this->shippeddate));
        $this->shipperid=htmlspecialchars(strip_tags($this->shipperid));
        $this->freight=htmlspecialchars(strip_tags($this->freight));
        $this->shipname=htmlspecialchars(strip_tags($this->shipname));
        $this->shipaddress=htmlspecialchars(strip_tags($this->shipaddress));
        $this->shipcity=htmlspecialchars(strip_tags($this->shipcity));
        $this->shipregion=htmlspecialchars(strip_tags($this->shipregion));
        $this->shippostalcode=htmlspecialchars(strip_tags($this->shippostalcode));
        $this->shipcountry=htmlspecialchars(strip_tags($this->shipcountry));

        // bind values
        $stmt->bindParam(":custid", $this->custid);
        $stmt->bindParam(":empid", $this->empid);
        $stmt->bindParam(":orderdate", $this->orderdate);
        $stmt->bindParam(":requireddate", $this->requireddate);
        $stmt->bindParam(":shippeddate", $this->shippeddate);
        $stmt->bindParam(":shipperid", $this->shipperid);
        $stmt->bindParam(":freight", $this->freight);
        $stmt->bindParam(":shipname", $this->shipname);
        $stmt->bindParam(":shipaddress", $this->shipaddress);
        $stmt->bindParam(":shipcity", $this->shipcity);
        $stmt->bindParam(":shipregion", $this->shipregion);
        $stmt->bindParam(":shippostalcode", $this->shippostalcode);
        $stmt->bindParam(":shipcountry", $this->shipcountry);

        // execute query
        if($stmt->execute()){
            // create order details

           $orderid = $this->conn->lastInsertId();

           foreach ($this->details as $detail){
               // query to insert record

               $query = "INSERT INTO
                " . $this->details_table_name . "
            SET
                orderid=:orderid, 
                productid=:productid,
                unitprice=:unitprice,
                qty=:qty,
                discount=:discount";

               // prepare query
               $stmt = $this->conn->prepare($query);

               // sanitize
               $detail->orderid=htmlspecialchars(strip_tags($orderid));
               $detail->productid=htmlspecialchars(strip_tags($detail->productid));
               $detail->unitprice=htmlspecialchars(strip_tags($detail->unitprice));
               $detail->qty=htmlspecialchars(strip_tags($detail->qty));
               $detail->discount=htmlspecialchars(strip_tags($detail->discount));

               // bind values
               $stmt->bindParam(":orderid", $detail->orderid);
               $stmt->bindParam(":productid", $detail->productid);
               $stmt->bindParam(":unitprice", $detail->unitprice);
               $stmt->bindParam(":qty", $detail->qty);
               $stmt->bindParam(":discount", $detail->discount);

               $stmt->execute();
           }

            return true;
        }

        return false;
    }

    // read all orders
    function read(){

        // select all query
        $query = "
          SELECT
            o.orderid,
            o.orderdate,
            o.requireddate,
            o.shippeddate,
            c.companyname AS customer,
            CONCAT(e.firstname, e.lastname) AS employee,
            s.companyname AS shipper
          FROM " . $this->table_name . " o
            INNER JOIN cust c ON c.custid = o.custid
            INNER JOIN emp e ON e.empid = o.empid
            INNER JOIN ship s ON s.shipperid = o.shipperid
          ORDER BY o.orderdate, customer, employee";

        // prepare query statement
        $stmt = $this->conn->prepare($query);

        // execute query
        $stmt->execute();

        return $stmt;
    }

    // used when filling up the update order form
    function readOne(){

        // query to read single record
        $query = "SELECT
                orderid,
                custid,
                empid,
                orderdate,
                requireddate,
                shippeddate,
                shipperid,
                freight,
                shipname,
                shipaddress,
                shipcity,
                shipregion,
                shippostalcode,
                shipcountry
            FROM
                " . $this->table_name . "
            WHERE
                orderid = ?
            LIMIT
                0,1";

        // prepare query statement
        $stmt = $this->conn->prepare( $query );

        // bind id of order to be updated
        $stmt->bindParam(1, $this->orderid);

        // execute query
        $stmt->execute();

        // get retrieved row
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        // set values to object properties
        $this->custid = $row['custid'];
        $this->empid = $row['empid'];
        $this->orderdate = $row['orderdate'];
        $this->requireddate = $row['requireddate'];
        $this->shippeddate = $row['shippeddate'];
        $this->shipperid = $row['shipperid'];
        $this->freight = $row['freight'];
        $this->shipname = $row['shipname'];
        $this->shipaddress = $row['shipaddress'];
        $this->shipcity = $row['shipcity'];
        $this->shipregion = $row['shipregion'];
        $this->shippostalcode = $row['shippostalcode'];
        $this->shipcountry = $row['shipcountry'];

        // query to read all orders details
        $query = "SELECT
                d.orderid,
                d.productid,
                p.productname,
                d.unitprice,
                d.qty,
                d.discount
            FROM
                " . $this->details_table_name . " AS d
            INNER JOIN 
                " . $this->products_table_name . " AS p
                ON p.productid = d.productid
            WHERE
                orderid = ?";

        // prepare query statement
        $stmt = $this->conn->prepare( $query );

        // bind id of order to be updated
        $stmt->bindParam(1, $this->orderid);

        // execute query
        $stmt->execute();

        $num = $stmt->rowCount();
        // check if more than 0 record found
        if($num>0){

            // retrieve our table contents
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
                // extract row
                // this will make $row['name'] to
                // just $name only
                extract($row);

                $orderdetail = new OrderDetail();
                $orderdetail->orderid = $orderid;
                $orderdetail->productid = $productid;
                $orderdetail->productname = $productname;
                $orderdetail->unitprice = $unitprice;
                $orderdetail->qty = $qty;
                $orderdetail->discount = $discount;
                array_push($this->details, $orderdetail);
            }
        }

    }

    // read all orders with pagination
    public function readPaging($from_record_num, $records_per_page){

        // select all query with paging
        $query = "
          SELECT
            o.orderid,
            o.orderdate,
            o.requireddate,
            o.shippeddate,
            c.companyname AS customer,
            CONCAT(e.firstname, e.lastname) AS employee,
            s.companyname AS shipper
          FROM " . $this->table_name . " o
            INNER JOIN cust c ON c.custid = o.custid
            INNER JOIN emp e ON e.empid = o.empid
            INNER JOIN ship s ON s.shipperid = o.shipperid
          ORDER BY o.orderdate, customer, employee 
          LIMIT ?, ?";

        // prepare query statement
        $stmt = $this->conn->prepare( $query );

        // bind variable values
        $stmt->bindParam(1, $from_record_num, PDO::PARAM_INT);
        $stmt->bindParam(2, $records_per_page, PDO::PARAM_INT);

        // execute query
        $stmt->execute();

        // return values from database
        return $stmt;
    }

    // delete the order
    function delete(){

        // sanitize
        $this->orderid=htmlspecialchars(strip_tags($this->orderid));

        // delete order details
        $query = "DELETE FROM " . $this->details_table_name . " WHERE orderid = ?";

        // prepare query
        $stmt = $this->conn->prepare($query);

        // bind id of record to delete
        $stmt->bindParam(1, $this->orderid);

        // if order details were successfully deleted
        if($stmt->execute()){

            // delete order
            $query = "DELETE FROM " . $this->table_name . " WHERE orderid = ?";

            // prepare query
            $stmt = $this->conn->prepare($query);

            // bind id of record to delete
            $stmt->bindParam(1, $this->orderid);

            // execute query
            if($stmt->execute()){
                return true;
            }
        }

        return false;
    }

    // used for paging orders
    public function count(){
        $query = "SELECT COUNT(*) as total_rows FROM " . $this->table_name ;

        $stmt = $this->conn->prepare( $query );
        $stmt->execute();
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        return $row['total_rows'];
    }
}