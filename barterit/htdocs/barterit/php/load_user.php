<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");


$userid = $_POST['userid'];


$sqlloaduser = "SELECT * FROM `tbl_users` WHERE user_id = '$userid'";
$result = $conn->query($sqlloaduser);

if ($result->num_rows > 0) {
	while ($row = $result->fetch_assoc()) {
		$userarray = array();
		$userarray['id'] = $row['user_id'];
		$userarray['email'] = $row['user_email'];
		$userarray['name'] = $row['user_name'];
		$userarray['password'] = $row['user_password'];
		$userarray['otp'] = $row['otp'];
		$userarray['datereg'] = $row['user_datereg'];
		$userarray['phone'] = $row['user_phone'];	
		$userarray['token'] = $row['user_token'];	
		$response = array('status' => 'success', 'data' => $userarray);
		sendJsonResponse($response);
	}
}else{
	$response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>