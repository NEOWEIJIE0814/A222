<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}


if (isset($_POST['itemstatus'])) {
    $itemstatus = $_POST['itemstatus'];
    $cartid = $_POST['cartid'];
    $sqlupdate = "UPDATE tbl_carts SET barter_status = '$itemstatus' WHERE cart_id = '$cartid'"; 
	
    databaseUpdate($sqlupdate);
    die();
}

function databaseUpdate($sql){
    include_once("dbconnect.php");
    if ($conn->query($sql) === TRUE) {
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>