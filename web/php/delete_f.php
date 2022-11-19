<?php
// server connection
$servername = "localhost";
$dbname = "gns_demo";
$username = "root";
$password = ""; // no pass in default

// get input from html using "$_POST[]"
$id = $_POST[id];

// sql checking data is filled
if($id == "") {
    die("something went wrong!");
}

// Check connection
$conn = new mysqli($servername, $username, $password,$dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

// store sql query in variable (we set id as auto increment so set it as empty)
$sql = "DELETE FROM fruits WHERE id = '$id'";

// query execution
if ($conn->query($sql) == TRUE) {
    echo "deleted successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error; // in php we use '.' operator for string concatenation!
}

?>