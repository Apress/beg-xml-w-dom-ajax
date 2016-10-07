<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="personid">0</xsl:param>
  <xsl:template match="/">
    <xsl:if test="$personid > 0">
      <div>
        <xsl:apply-templates select="/contacts/person[@id=$personid]"/>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template match="person">
		Name: 
		<xsl:value-of select="first_name"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="last_name"/>
    <br/>
		Type: <xsl:value-of select="@type"/>
    <br/>
		Company: <xsl:value-of select="company"/>
    <br/>
		Address: <xsl:value-of select="address1"/>, <xsl:value-of select="address2"/>, 
		<xsl:value-of select="country"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="postal_code"/>
  </xsl:template>
</xsl:stylesheet>
