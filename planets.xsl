<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="4.0" indent="yes"/>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body">
    <body>
      <p>
        <a href="http://www.nasa.gov/">Visit NASA!</a> | <a href="http://www.nineplanets.org/">Tour the solar system</a>
      </p>
      <xsl:apply-templates/>
      <hr/>
      Copyright Planetary Fun 2006.
    </body>
  </xsl:template>
</xsl:stylesheet>
