<?php
$wdb_host = 'localhost';
$wdb_user = 'user_weather';
$wdb_pass = 'weatherpassword';
$wdb_name = 'weather';
mysql_connect($wdb_host, $wdb_user, $wdb_pass); 
mysql_select_db($wdb_name);
?>
