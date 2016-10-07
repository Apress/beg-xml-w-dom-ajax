<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="numTemp">
    <xsl:value-of select="count(weather/temperature)"/>
  </xsl:variable>
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="//weather/city='Error'">
        <h4>Error</h4>
        <xsl:value-of select="weather/error"/>
      </xsl:when>
      <xsl:otherwise>
        <h4>Weather for <xsl:value-of select="weather/city"/></h4>
        <xsl:choose>
          <xsl:when test="$numTemp=0">
            There are currently no entries for
            <xsl:value-of select="weather/city"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="MinF">
              <xsl:value-of select="round(((weather/temperature/minimum * 9) div 5)+ 32)"/>
            </xsl:variable>
            <xsl:variable name="MaxF">
              <xsl:value-of select="round(((weather/temperature/maximum * 9) div 5)+ 32)"/>
            </xsl:variable>
            <strong>Outlook:</strong><br/>
            <xsl:text disable-output-escaping="yes">&lt;img src="images/</xsl:text>
            <xsl:value-of select="weather/outlook"/>
            <xsl:text disable-output-escaping="yes">.jpg" width="100" height="80" alt="</xsl:text>
            <xsl:value-of select="weather/outlook"/>
            <xsl:text disable-output-escaping="yes">" /&gt;</xsl:text><br/>
            <table border="0">
              <tr>
                <td/>
                <td><strong>C</strong></td>
                <td><strong>F</strong></td>
              </tr>
              <tr>
                <td><strong>Minimum</strong></td>
                <td><xsl:value-of select="weather/temperature/minimum"/></td>
                <td><xsl:value-of select="$MinF"/></td>
              </tr>
              <tr>
                <td><strong>Maximum</strong></td>
                <td><xsl:value-of select="weather/temperature/maximum"/></td>
                <td><xsl:value-of select="$MaxF"/></td>
              </tr>
            </table>
          </xsl:otherwise>
        </xsl:choose>
        <p>
          <hr/>Add a new entry:<br/>
          <form action="addweather.php" method="POST">
            <xsl:text disable-output-escaping="yes">
              &lt;input type="hidden" name="city" value="</xsl:text>
            <xsl:value-of select="weather/city/@id"/>
            <xsl:text disable-output-escaping="yes">" /&gt;
            </xsl:text>
            Minimum: <input type="text" name="min" size="2" maxlength="3"/><br/>
            Maximum: <input type="text" name="max" size="2" maxlength="3"/><br/>
			  Temperature is in: 
            <select name="temptype">
              <option value="C">Celsius</option>
              <option value="F">Fahrenheit</option>
            </select><br/>
			  Weather:
            <select name="weather">
              <xsl:for-each select="weather/weathertypes/type">
                <xsl:text disable-output-escaping="yes">
                  &lt;option value="</xsl:text>
                <xsl:value-of select="@id"/>
                <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text disable-output-escaping="yes">&lt;/option&gt;</xsl:text>
              </xsl:for-each>
            </select><br/>
            <input type="submit" value="Add"/>
          </form>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
