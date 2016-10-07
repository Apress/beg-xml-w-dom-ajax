<?php

include_once 'weather.php';

$xml = new DomDocument('1.0', 'UTF-8');
$xml->xmlStandalone = false;

$root = $xml->createElement('entries');
$root = $xml->appendChild($root);

if (isset($area)) {
    $sql = 'SELECT * from area WHERE areaID=' . $area;
    $tres = mysql_query($sql) or die(mysql_error());
    
    if (mysql_num_rows($tres) == 0) {
        $current = $xml->createElement('current', 'Error');
        $current = $root->appendChild($current);
        
        $error = $xml->createElement('error', 'You appear to have selected an invalid area');
        $error = $root->appendChild($error);
    } 
	else {
        $row = mysql_fetch_array($tres);
        $area_name = $row['area'];
        
        $sql = 'SELECT * FROM city WHERE cityAreaID =' . $area . ' ORDER BY city';
        $cres = mysql_query($sql) or die(mysql_error());

        $current = $xml->createElement('current', $area_name);
        $current->setAttribute('type', 'area');
        $current->setAttribute('id', $area);
        $root->appendChild($current);

        $items = $xml->createElement('items');
        $root->appendChild($items);

        $linksto = $xml->createElement('linksto', 'city');
        $items->appendChild($linksto);

        while ($crow = mysql_fetch_array($cres)) {
            $entry = $xml->createElement('entry', $crow['city']);
            $entry->setAttribute('id', $crow['cityID']);
            $items->appendChild($entry);
        }
    }
} 
else if (isset($country)) {
    $sql = 'SELECT * from country WHERE countryID =' . $country;
    $tres = mysql_query($sql) or die(mysql_error());

    if (mysql_num_rows($tres) == 0) {
        $current = $xml->createElement('current', 'Error');
        $current = $root->appendChild($current);
        
        $error = $xml->createElement('error', 'You appear to have selected an invalid country');
        $error = $root->appendChild($error);
    } 
	else {
        $trow = mysql_fetch_array($tres);
        $country_name = $trow['country'];

        $sql = 'SELECT * FROM area WHERE areaCountryID =' . $country . ' ORDER BY area';
        $cres = mysql_query($sql) or die(mysql_error());

        $current = $xml->createElement('current', $country_name);
        $current->setAttribute('type', 'country');
        $current->setAttribute('id', $country);
        $root->appendChild($current);

        $items = $xml->createElement('items');
        $root->appendChild($items);

        $linksto = $xml->createElement('linksto', 'area');
        $items->appendChild($linksto);

        while ($crow = mysql_fetch_array($cres)) {
            $entry = $xml->createElement('entry', $crow['area']);
            $entry->setAttribute('id', $crow['areaID']);
            $items->appendChild($entry);
        }
    }
} 
else if (isset($continent)) {
    $sql = 'SELECT * from continent WHERE continentID =' . $continent;
    $tres = mysql_query($sql) or die(mysql_error());

    if (mysql_num_rows($tres) == 0) {
        $current = $xml->createElement('current', 'Error');
        $current = $root->appendChild($current);
        
        $error = $xml->createElement('error', 'You appear to have selected an invalid continent');
        $error = $root->appendChild($error);
    } 
	else {
        $trow = mysql_fetch_array($tres);
        $continent_name = $trow['continent'];

        $sql = 'SELECT * FROM country WHERE countryContinentID =' . $continent . ' ORDER BY country';
        $cres = mysql_query($sql) or die(mysql_error());

        $current = $xml->createElement('current', $continent_name);
        $current->setAttribute('type', 'continent');
        $current->setAttribute('id', $continent);
        $root->appendChild($current);

        $items = $xml->createElement('items');
        $root->appendChild($items);

        $linksto = $xml->createElement('linksto', 'country');
        $items->appendChild($linksto);

        while ($crow = mysql_fetch_array($cres)) {
            $entry = $xml->createElement('entry', $crow['country']);
            $entry->setAttribute('id', $crow['countryID']);
            $items->appendChild($entry);
        }
    }
} 
else {
    $sql = 'SELECT * FROM continent ORDER BY continent';
    $cres = mysql_query($sql) or die(mysql_error());

    $current = $xml->createElement('current', 'Home');
    $current->setAttribute('type', 'home');
    $root->appendChild($current);

    $items = $xml->createElement('items');
    $root->appendChild($items);

    $linksto = $xml->createElement('linksto', 'continent');
    $items->appendChild($linksto);

    while ($crow = mysql_fetch_array($cres)) {
        $entry = $xml->createElement('entry', $crow['continent']);
        $entry->setAttribute('id', $crow['continentID']);
        $items->appendChild($entry);
    }
}
?>
