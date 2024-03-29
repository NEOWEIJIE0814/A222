<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$item_id = $_POST['item_id'];
$cartqty = $_POST['cart_qty'];
$cartprice = $_POST['cart_price'];
$userid = $_POST['userid'];
$barterid = $_POST['barterid'];
$barterstatus = $_POST['barter_status'];

$checkitemid = "SELECT * FROM `tbl_carts` WHERE `user_id` = '$userid' AND  `item_id` = '$item_id'";

$resultqty = $conn->query($checkitemid);
$numresult = $resultqty->num_rows;

if ($numresult > 0) {
	$sql = "UPDATE `tbl_carts` SET `cart_qty`= (cart_qty + $cartqty),`cart_price`= (cart_price+$cartprice) WHERE `user_id` = '$userid' AND  `item_id` = '$item_id'";
}else{
	$sql = "INSERT INTO `tbl_carts`(`item_id`, `cart_qty`, `cart_price`, `user_id`, `barter_id`,`barter_status` ) VALUES ('$item_id','$cartqty','$cartprice','$userid','$barterid', '$barterstatus')";
}

if ($conn->query($sql) === TRUE) {
		$response = array('status' => 'success', 'data' => $sql);
		sendJsonResponse($response);
	}else{
		$response = array('status' => 'failed', 'data' => $sql);
		sendJsonResponse($response);
	}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>