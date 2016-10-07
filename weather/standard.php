<?php
$xml = new DomDocument();
$xsl = new DomDocument();
if (isset($city)) {
    include 'mk_weather.php';
    $xsl->load('weather.xsl');
} 
else {
    include 'mk_navxml.php';
    $xsl->load('nav.xsl');
}
$xml->loadXML($xml->saveXML());
$proc = new XsltProcessor();
$xsl = $proc->importStylesheet($xsl);
$newdom = $proc->transformToDoc($xml);
echo $newdom->saveXML();
?>
