<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="4.0" indent="yes"/>
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="text()"/>
  <xsl:template match="neighbours">
    <html>
      <head>
        <title>A simple HTML page</title>
        <style type="text/css">
          body { font-family: Verdana, Arial, sans-serif; font-size: 12px;}
      </style>
      </head>
      <body>
        <p>
          <a href="http://www.nasa.gov/">Visit NASA!</a> | <a href="http://www.nineplanets.org/">Tour the solar system</a>
        </p>
        <h1>Our neighbours</h1>
        <xsl:apply-templates/>
        <hr/>
        Copyright Planetary Fun 2006.
    </body>
    </html>
  </xsl:template>
  <xsl:template match="planet">
    <h2>
      <xsl:value-of select="@name"/>
    </h2>
    <xsl:value-of select="description/text()"/>
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>
  <xsl:template match="diameter">
    <li>
      <strong>Diameter: </strong>
      <xsl:value-of select="text()"/>
    </li>
  </xsl:template>
  <xsl:template match="moons">
    <li>
      <strong>Moons: </strong>
      <xsl:value-of select="text()"/>
    </li>
  </xsl:template>
  <xsl:template match="meanTemp">
    <li>
      <strong>Mean temperature: </strong>
      <xsl:value-of select="text()"/>
    </li>
  </xsl:template>
  <xsl:template match="oneDay">
    <li>
      <strong>Length of one day: </strong>
      <xsl:value-of select="text()"/>
    </li>
  </xsl:template>
  <xsl:template match="oneYear">
    <li>
      <strong>Length of one year: </strong>
      <xsl:value-of select="text()"/>
    </li>
  </xsl:template>
</xsl:stylesheet>
