<?php
include_once 'weather.php';

$into = $_POST['into'];
$current = $_POST['current'];
$parent = $_POST['parent'];
$entry = $_POST['entry']; 

if (strlen(trim($entry)) > 0) { 
    switch ($into) {
        case 'continent':
            $sql = 'INSERT into continent (continent) VALUES ("' . htmlspecialchars($entry,ENT_QUOTES) . '")';
            break;
        case 'country':
            $sql = 'INSERT into country (country, countryContinentID) VALUES ("' . htmlspecialchars($entry,ENT_QUOTES) . '",' . $parent . ')';
            break;
        case 'area':
            $sql = 'INSERT into area (area, areaCountryID) VALUES ("' . htmlspecialchars($entry,ENT_QUOTES) . '",' . $parent . ')';
            break;
        case 'city':
            $sql = 'INSERT into city (city, cityAreaID) VALUES ("' . htmlspecialchars($entry,ENT_QUOTES) . '",' . $parent . ')';
            break;
        default:
            $sql = '';
	        break;
   }
} 
else {
    $sql ='';
}

if (strlen($sql) > 0) {  
    mysql_query($sql) or die(mysql_error());
}

header('Location: index.php?' . $current . '=' . $parent);

?>
