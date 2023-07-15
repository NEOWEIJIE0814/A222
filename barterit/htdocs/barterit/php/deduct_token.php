<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}


if (isset($_POST['selecttoken'])) {
    $token = $_POST['selecttoken'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_users SET user_token =(user_token - $token) WHERE user_id = '$userid'"; //need to deduct 2 token 
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