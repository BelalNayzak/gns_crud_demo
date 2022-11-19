<?php
// server connection
$servername = "localhost";
$dbname = "gns_demo";
$username = "root";
$password = ""; // no pass in default

// get input from html using "$_POST[]"
$name = $_POST[name];
$color = $_POST[color];

// sql checking data is filled
if($name == "" && $color == "") {
    die("Please enter the feilds!");
}

// Check connection
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "";
// store sql query in variable (we set id as auto increment so set it as empty)
if($name != "" && $color != "") {
    $sql = "UPDATE fruits SET name = '$name', color = '$color' WHERE id = '$id'";

} else if($name != "" && $color == "") {
    $sql = "UPDATE fruits SET name = '$name' WHERE id = '$id'";

} else if($name == "" && $color != "") {
    $sql = "UPDATE fruits SET color = '$color' WHERE id = '$id'";

}

// query execution
if ($conn->query($sql) == TRUE) {
    echo "updated successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error; // in php we use '.' operator for string concatenation!
}


?>