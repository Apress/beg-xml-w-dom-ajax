<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="library">
		<div>The DVDs in the source document are:<br/>
			<xsl:apply-templates select="DVD"/>
    </div>
	</xsl:template>
	<xsl:template match="DVD">
		<span style="margin-left: 10px;"><xsl:value-of select="./title/text()"/></span><br/>
		<span style="margin-left: 20px;">Genre: <xsl:value-of select="./genre/text()"/></span><br/>
		<span style="margin-left: 20px;">Format: <xsl:value-of select="./format/text()"/></span><br/>
	</xsl:template>
</xsl:stylesheet>
