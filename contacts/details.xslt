<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
      <div>
        <xsl:apply-templates select="/contacts/person"/>
      </div>
  </xsl:template>
  <xsl:template match="person">
		<p><span class="emphasis">Name: </span>
		<xsl:value-of select="first_name"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="last_name"/></p>
		<p><span class="emphasis">Type: </span> <xsl:value-of select="@type"/></p>
		<p><span class="emphasis">Company: </span><xsl:value-of select="company"/></p>
		<p><span class="emphasis">Address: </span> <xsl:value-of select="address1"/>, <xsl:value-of select="address2"/>, 
		<xsl:value-of select="country"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="postal_code"/>
    </p>
  </xsl:template>
</xsl:stylesheet>
