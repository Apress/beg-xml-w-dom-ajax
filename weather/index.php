<?php
if (isset($_GET['continent'])) {
    $continent = intval($_GET['continent']);
}
if (isset($_GET['country'])) {
    $country = intval($_GET['country']);
}
if (isset($_GET['area'])) {
    $area = intval($_GET['area']);
}
if (isset($_GET['city'])) {
    $city = intval($_GET['city']);
}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Community Weather</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="standard.css" rel="stylesheet" type="text/css" />
	<style>
		#layHeading {
			position:absolute; 
			left:0px; 
			top:0px; 
			width:600px; 
			height:70px; 
			z-index:1;	
		}
		#layNavigation {
			position:absolute; 
			left:2px; 
			top:75px; 
			width:140px; 
			z-index:2;
		}
		#layContent {
			 position:absolute; 
			 left:150px; 
			 top:75px; 
			 width:450px; 
			 z-index:3;
		}
	</style>
  </head>
  <body>
    <div id="layHeading">
      <img src="images/header.jpg" width="600" height="70" alt="Page Heading"/>
    </div>
    <div id="layNavigation">
      <?php include 'sidebar.php'; ?>
    </div>
	<div id="layContent">
      <?php include_once 'standard.php'; ?>
    </div>
  </body>
</html>
