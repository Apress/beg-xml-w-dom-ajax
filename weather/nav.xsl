<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="linksto">
    <xsl:value-of select="entries/items/linksto"/>
  </xsl:variable>
  <xsl:variable name="numLinks">
    <xsl:value-of select="count(entries/items/entry)" />
  </xsl:variable>
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="//entries/current='Error'">
        <h4>Error</h4>
        <xsl:value-of select="entries/error" />
      </xsl:when>
      <xsl:otherwise>
        <h4>Current: <xsl:value-of select="entries/current" /></h4>
        <xsl:choose>
          <xsl:when test="$numLinks=0">
            There are currently no <strong>
            <xsl:value-of select="$linksto" />
            </strong> entries in the database under
            <xsl:value-of select="entries/current" />
          </xsl:when>
          <xsl:otherwise>
            <p>Please select a <xsl:value-of select="$linksto" />:</p>
            <xsl:for-each select="entries/items/entry">
              <a>
                <xsl:attribute name="href">index.php?<xsl:value-of select="$linksto" />=<xsl:value-of select="@id" /></xsl:attribute><xsl:value-of select="." />
              </a><br />
            </xsl:for-each> 	
          </xsl:otherwise>
        </xsl:choose>
        <p>
          Add a new <xsl:value-of select="$linksto" />:<br />
          <form action="addnew.php" method="POST">
            <xsl:text disable-output-escaping="yes">
              &lt;input type="hidden" name="current" value="</xsl:text><xsl:value-of select="entries/current/@type" />
            <xsl:text disable-output-escaping="yes">" /&gt;
            </xsl:text>
            <xsl:text disable-output-escaping="yes">
              &lt;input type="hidden" name="parent" value="</xsl:text><xsl:value-of select="entries/current/@id" /><xsl:text disable-output-escaping="yes">" /&gt;
            </xsl:text>
            <xsl:text disable-output-escaping="yes">
              &lt;input type="hidden" name="into" value="</xsl:text><xsl:value-of select="$linksto" /><xsl:text disable-output-escaping="yes">" /&gt;
            </xsl:text>
            <input type="text" name="entry" /> <br />
            <input type="submit" value="Add" />
          </form>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>