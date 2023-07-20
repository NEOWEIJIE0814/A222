<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");


if (isset($_POST['userid'])){
	$userid = $_POST['userid'];	
	$sqlloaditem = "SELECT * FROM `tbl_items` WHERE user_id = '$userid'";
	$sqlcart = "SELECT * FROM `tbl_carts` WHERE barter_id = '$userid'";
}


if (isset($sqlcart)){
	$resultcart = $conn->query($sqlcart);
	$number_of_result_cart = $resultcart->num_rows;
	if ($number_of_result_cart > 0) {
		$totalcart = 0;
		while ($rowcart = $resultcart->fetch_assoc()) {
			$totalcart = $totalcart+ $rowcart['cart_qty'];
		}
	}else{
		$totalcart = 0;
	}
}else{
	$totalcart = 0;
}

$result = $conn->query($sqlloaditem);



if ($result->num_rows > 0) {
    $item["item"] = array();
	while ($row = $result->fetch_assoc()) {
        $itemlist = array();
        $itemlist['item_id'] = $row['item_id'];
        $itemlist['user_id'] = $row['user_id'];
        $itemlist['item_name'] = $row['item_name'];
        $itemlist['item_desc'] = $row['item_desc'];
		$itemlist['item_price'] = $row['item_price'];
        $itemlist['item_qty'] = $row['item_qty'];
        $itemlist['item_lat'] = $row['item_lat'];
        $itemlist['item_long'] = $row['item_long'];
        $itemlist['item_state'] = $row['item_state'];
        $itemlist['item_locality'] = $row['item_locality'];
		$itemlist['item_date'] = $row['item_date'];
        array_push($item["item"],$itemlist);
    }
    $response = array('status' => 'success', 'data' => $item,'cartqty'=> $totalcart);
    sendJsonResponse($response);
}else{
     $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}