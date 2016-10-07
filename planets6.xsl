<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="planets4.xsl" />
  <xsl:output method="html" version="4.0" indent="yes"/>
  <xsl:template match="planet">
    <img width="100" height="100">
      <xsl:attribute name="src">
        <xsl:value-of select="@name"/>.jpg
      </xsl:attribute>
    </img>
    <xsl:apply-imports />
  </xsl:template>
</xsl:stylesheet>

