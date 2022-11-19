<?php
// server connection
$servername = "localhost";
$dbname = "gns_demo";
$username = "root";
$password = ""; // no pass in default

// get input using "$_POST[]"
$name = $_POST[name];
$color = $_POST[color];

// sql checking data is filled
if($name == "" || $color == "") {
    die("Please enter the feilds!");
}

// Check connection
$conn = new mysqli($servername, $username, $password,$dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

// store sql query in variable (we set id as auto increment so set it as empty)
$sql = "INSERT INTO fruits (id, name, color) VALUES ('','".$name."', '".$color."')";

// query execution
if ($conn->query($sql) == TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error; // in php we use '.' operator for string concatenation!
}

?>