<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
	<div>
		<xsl:apply-templates select="/contacts/person"/>
	</div>
	</xsl:template>
	<xsl:template match="person">
	<a href="javascript:showPerson({@id});">
    <xsl:value-of select="first_name"/><xsl:text> </xsl:text><xsl:value-of select="last_name"/>
   </a><br/>
	</xsl:template>
</xsl:stylesheet>
