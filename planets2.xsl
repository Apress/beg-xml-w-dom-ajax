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
      <h2>Quick reference</h2>
      <ul>
        <xsl:for-each select="h2">
          <li>
            <a>
              <xsl:attribute name="href">
                #<xsl:value-of select="text()"/></xsl:attribute>
              <xsl:value-of select="text()"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>
      <xsl:apply-templates/>
      <hr/>
      Copyright Planetary Fun 2006.
    </body>
  </xsl:template>
  <xsl:template match="h2">
    <a>
      <xsl:attribute name="name"><xsl:value-of select="text()"/></xsl:attribute>
      <h2>
        <xsl:apply-templates/>
      </h2>
    </a>
  </xsl:template>
</xsl:stylesheet>
