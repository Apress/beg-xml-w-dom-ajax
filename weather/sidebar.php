<a href="index.php">Home</a><br />

<?php
include_once 'weather.php';

if (isset($country)) {
    $sql = 'SELECT country.countryContinentID, continent.* FROM country, continent WHERE countryContinentID=continentID AND countryID=' . $country;
    $cRes = mysql_query($sql) or die(mysql_error());
    if (mysql_num_rows($cRes) == 1) {
        $cRow = mysql_fetch_array($cRes);
        echo '<a href="index.php?continent=' . $cRow['continentID'] . '">' . $cRow['continent'] . '</a><br />';
    }
}

if (isset($area)) {
    $sql = 'SELECT area.areaCountryID, country.*, continent.* FROM area, country, continent WHERE areaCountryID=countryID AND countryContinentID=continentID AND areaID=' . $area;
    $cRes = mysql_query($sql) or die(mysql_error());
    if (mysql_num_rows($cRes) == 1) {
        $cRow = mysql_fetch_array($cRes);
        echo '<a href="index.php?continent=' . $cRow['continentID'] . '">' . $cRow['continent'] . '</a><br />';
        echo '<a href="index.php?country=' . $cRow['countryID'] . '">' . $cRow['country'] . '</a><br />';
    }
}

if (isset($city)) {
    $sql = 'SELECT city.cityAreaID, area.*, country.*, continent.* FROM city, area, country, continent WHERE cityAreaID=areaID AND areaCountryID=countryID AND countryContinentID=continentID AND cityID=' . $city;
    $cRes = mysql_query($sql) or die(mysql_error());
    if (mysql_num_rows($cRes) == 1) {
        $cRow = mysql_fetch_array($cRes);
        echo '<a href="index.php?continent=' . $cRow['continentID'] . '">' . $cRow['continent'] . '</a><br />';
        echo '<a href="index.php?country=' . $cRow['countryID'] . '">' . $cRow['country'] . '</a><br />';
        echo '<a href="index.php?area=' . $cRow['areaID'] . '">' . $cRow['area'] . '</a><br />';
    }
}

?>
