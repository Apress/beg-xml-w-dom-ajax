<?php
function alterTemp($temperature, $current) {
    if ($current=='C') {
        $newtemp = $temperature;
    } else {
      $newtemp = ((($temperature -32) * 5) / 9);
    }
    return $newtemp;
}

include_once 'weather.php';

$city = $_POST['city'];
$min = $_POST['min'];
$max = $_POST['max'];
$weather = $_POST['weather'];
$temptype = $_POST['temptype'];

if (is_numeric($min) && is_numeric($max)) {
    $sql = 'INSERT INTO weather (weatherCityID, weatherDate, weatherMin, weatherMax, weatherWeatherTypeID) VALUES (' . $city . ',' . time() . ',' . alterTemp($min, $temptype) . ', ' . alterTemp($max, $temptype) . ',' . $weather . ')';
} 
else {
    $sql = 'SELECT (1+1)';
}

mysql_query($sql) or die(mysql_error() . $sql);

header('Location: index.php?city=' . $city);
?>
