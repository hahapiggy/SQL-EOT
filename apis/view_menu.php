<?php
    header("Content-type:text/html;charset=utf-8");
    include_once "db_conn.php";

    $query = ("select * from menu");
    $stmt = $db->prepare($query);
    $stmt->execute();
    $result = $stmt->fetchAll();

    /*
    echo "<table border='1'>
    <tr>
    <th>ID</th>
    <th>品項</th>
    <th>價錢</th>
    </tr>";

    for($i=0; $i<count($result); $i++){
        echo "<tr>";
        echo "<td>".$result[$i]['menu_ID']."</td>";
        echo "<td>".$result[$i]['menu_name']."</td>";
        echo "<td>".$result[$i]['price']."</td>";
        echo "</tr>.";
    }
    echo "</table>";
    echo "<br><input type = 'button' onclick='history.back()' value='Go Back'></input>";
    */
    echo json_encode($result);
