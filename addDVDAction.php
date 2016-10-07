<?php
  $title = $_POST['txtTitle'];
  $format = $_POST['txtFormat'];
  $genre = $_POST['txtGenre'];
  
  $dom = new DomDocument(); 
  $dom->preserveWhiteSpace = false;
  $dom->formatOutput = true;
  $dom->load("dvd.xml"); 

  $root = $dom->documentElement;
  $DVDelements = $dom->getElementsByTagName("DVD");
  $newID =  $DVDelements->length + 1;
  
  $newDVDElement = $dom->createElement("DVD");
  $newDVDElement->setAttribute("id",$newID);

  $newTitleElement = $dom->createElement("title");
  $newTitleElement->appendChild($dom->createTextNode($title));
    
  $newFormatElement = $dom->createElement("format");
  $newFormatElement->appendChild($dom->createTextNode($format));
    
  $newGenreElement = $dom->createElement("genre");
  $newGenreElement->appendChild($dom->createTextNode($genre));
    
  $newDVDElement->appendChild($newTitleElement);
  $newDVDElement->appendChild($newFormatElement);
  $newDVDElement->appendChild($newGenreElement);
    
  $root->appendChild($newDVDElement);

  
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
