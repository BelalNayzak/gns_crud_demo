<?php
// server connection
$servername = "localhost";
$dbname = "gns_demo";
$username = "root";
$password = ""; // no pass in default

// Check connection
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

// store sql query in variable (we set id as auto increment so set it as empty)
$sql = "SELECT * FROM fruits";

// query execution
if ($conn->query($sql) == TRUE) {
    print_r(json_encode($conn->query($sql)->fetch_all()));
} else {
    echo "Error: " . $sql . "<br>" . $conn->error; // in php we use '.' operator for string concatenation!
}


?>