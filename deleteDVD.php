<?php
  $id = $_REQUEST['id'];
  $dom = new DomDocument();
  $dom->load("dvd.xml");
  $root = $dom->documentElement;
  $path = "/library/DVD[@id=" . $id . "]";
  $xPath = new domxpath($dom);
  $DVDelement = $xPath->query($path)->item(0);
  $root -> removeChild($DVDelement);
  $dom->save("dvd.xml");
  ?>
<html>
  <head>
    <link href="styles.css" type="text/css" rel="stylesheet" />
  </head>
  <body>
    <div id="divMessage">You have successfully updated the XML document</div>
  </body>
</html>
