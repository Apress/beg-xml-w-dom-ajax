<?php
include_once 'weather.php';

$xml = new DomDocument('1.0', 'UTF-8');
$xml->xmlStandalone = false;

$root = $xml->createElement('weather');
$root = $xml->appendChild($root);

$sql = 'SELECT * FROM city WHERE cityID =' . $city;
$cres = mysql_query($sql) or die(mysql_error() . "\n<br />" . $sql);

if (mysql_num_rows($cres) == 0) {
    $cityElement = $xml->createElement('city', 'Error');
    $root->appendChild($cityElement);

    $error = $xml->createElement('error', 'You appear to have selected an invalid city');
    $root->appendChild($error);
} 
else {
    $crow = mysql_fetch_array($cres);
    $city_name = $crow['city'];
    $cityElement = $xml->createElement('city', $city_name);
    $cityElement->setAttribute('id', $city);
    $cityElement = $root->appendChild($cityElement);

    $weatherWindow = time() - 28800;
    $sql = 'DELETE FROM weather WHERE weatherCityID=' . $city . ' AND weatherDate < ' . $weatherWindow;
    mysql_query($sql) or die(mysql_error() . "\n<br />" . $sql);

    $sql = 'SELECT count(weather.weatherWeatherTypeID) AS tOrder, weathertype.weatherType FROM weather, weathertype WHERE weatherWeatherTypeID=weatherTypeID and weatherCityID =' . $city . ' GROUP BY weatherWeatherTypeID ORDER BY tOrder DESC';
    $wres = mysql_query($sql) or die(mysql_error() . "\n<br />" . $sql);

    if (mysql_num_rows($wres) > 0) {
        $wrow = mysql_fetch_array($wres);

        $sql = 'SELECT ROUND(AVG(weatherMax)) AS maxavg FROM weather WHERE weatherCityID =' . $city;
        $wMaxRes = mysql_query($sql) or die(mysql_error() . "\n<br />" . $sql);
        $wMaxRow = mysql_fetch_array($wMaxRes);

        $sql = 'SELECT ROUND(AVG(weatherMin)) AS minavg FROM weather WHERE weatherCityID =' . $city;
        $wMinRes = mysql_query($sql) or die(mysql_error() . "\n<br />" . $sql);
        $wMinRow = mysql_fetch_array($wMinRes);

        $temp = $xml->createElement('temperature');
        $temp = $root->appendChild($temp);
        $min = $xml->createElement('minimum', $wMinRow['minavg']);
        $min = $temp->appendChild($min);
        $max = $xml->createElement('maximum', $wMaxRow['maxavg']);
        $max = $temp->appendChild($max);

        $outlook = $xml->createElement('outlook', $wrow['weatherType']);
        $outlook = $root->appendChild($outlook);
    }

    $types = $xml->createElement('weathertypes');
    $types = $root->appendChild($types);

    $sql = 'SELECT weatherTypeID, weatherType FROM weatherType';
    $tRes = mysql_query($sql) or die(mysql_error() . "\n<br />" . $sql);

    while ($tRow = mysql_fetch_array($tRes)) {
        $type = $xml->createElement('type', $tRow['weatherType']);
        $type->setAttribute('id', $tRow['weatherTypeID']);
        $type = $types->appendChild($type);
    }
}

?>
