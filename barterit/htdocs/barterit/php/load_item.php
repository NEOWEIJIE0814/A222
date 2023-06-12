<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

if (isset($_POST['userid'])){
	$userid = $_POST['userid'];	
	$sqlloadcatches = "SELECT * FROM `tbl_items` WHERE user_id = '$userid'";
}if (isset($_POST['search'])){
	$search = $_POST['search'];
	$sqlloadcatches = "SELECT * FROM `tbl_items` WHERE item_name LIKE '%$search%'";
}else{
	$sqlloadcatches = "SELECT * FROM `tbl_items`";
}



$result = $conn->query($sqlloadcatches);
if ($result->num_rows > 0) {
    $item["item"] = array();
	while ($row = $result->fetch_assoc()) {
        $itemlist = array();
        $itemlist['item_id'] = $row['item_id'];
        $itemlist['user_id'] = $row['user_id'];
        $itemlist['item_name'] = $row['item_name'];
        $itemlist['item_desc'] = $row['item_desc'];
        $itemlist['item_lat'] = $row['item_lat'];
        $itemlist['item_long'] = $row['item_long'];
        $itemlist['item_state'] = $row['item_state'];
        $itemlist['item_locality'] = $row['item_locality'];
		$itemlist['item_date'] = $row['item_date'];
        array_push($item["item"],$itemlist);
    }
    $response = array('status' => 'success', 'data' => $item);
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