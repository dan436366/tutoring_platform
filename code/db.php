<?php
$host = 'localhost'; 
$port = 3306; 
$user = 'root';
$password = ''; 
$database = 'tutoring_platform';

$conn = new mysqli($host, $user, $password, $database, $port);

if ($conn->connect_error) {
    die("Помилка підключення: " . $conn->connect_error);
}
?>
