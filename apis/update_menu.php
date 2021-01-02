<?php
    require("./utils.php");
    include_once "db_conn.php";

    $number = $_POST["menu_ID"];
    $name = $_POST["menu_name"];
    $price = $_POST["price"];

    $query = ("update `menu` set menu_name=?, price=? where menu_ID=?");
    $stmt = $db->prepare($query);
    $result = $stmt->execute(array($menu_name, $price, $menu_ID));
    header("Location:inform.php");
    
    echo json_encode($result);