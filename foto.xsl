<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:strip-space elements="*"/>

  <xsl:output method="xml"/>

  <xsl:template match="tabelle">
    <FMPXMLRESULT>
      <METADATA>
        <xsl:apply-templates select="tabella[@nomeFM='FOTOGRAFIE']"/>
      </METADATA>
      <RESULTSET>
        <xsl:apply-templates select="document('scheda_oa.xml')//FTA"/>
      </RESULTSET>
    </FMPXMLRESULT>
  </xsl:template>

  <xsl:template match="tabella">

    <xsl:for-each select="campo">
      <FIELD NAME="{.}"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="FTA">

    <xsl:variable name="sub_elements" select="*"/>

    <xsl:variable name="chiave" select="@id_field"/>

    <xsl:variable name="chiave_esterna" select="ancestor::CARD//NCI"/>
    <ROW>

      <xsl:for-each select="document('mappa_campi.xml')//tabella[@nomeFM='FOTOGRAFIE']/campo">

        <xsl:variable name="field" select="."/>
        <COL>
          <DATA>

            <xsl:choose>

              <xsl:when test="$field = '_NCI'">
                <xsl:value-of select="$chiave_esterna"/>
              </xsl:when>

              <xsl:when test="$field = 'chiave'">
                <xsl:value-of select="$chiave"/>
              </xsl:when>

              <xsl:otherwise>

                <xsl:value-of select="$sub_elements[name()=$field]"/>

              </xsl:otherwise>
            </xsl:choose>
          </DATA>
        </COL>

      </xsl:for-each>

    </ROW>

  </xsl:template>

</xsl:stylesheet>