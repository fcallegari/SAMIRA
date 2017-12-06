<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:strip-space elements="*"/>

  <xsl:output method="xml"/>

  <xsl:template match="tabelle">
    <FMPXMLRESULT>
      <METADATA>
        <xsl:apply-templates select="tabella[@nomeFM='OPERE']"/>
      </METADATA>
      <RESULTSET>
        <xsl:apply-templates select="document('scheda_oa.xml')/CARDSET"/>
      </RESULTSET>
    </FMPXMLRESULT>
  </xsl:template>

  <xsl:template match="tabella">

    <xsl:for-each select="campo">
      <FIELD NAME="{.}"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="CARDSET">

    <!-- ciclo esterno sulle CARD -->
    <xsl:for-each select="CARD">
      <ROW>

        <xsl:variable name="card" select="@id_card"/>
        <!-- ciclo interno sui campi della mappa -->

        <xsl:for-each select="document('mappa_campi.xml')//tabella[@nomeFM='OPERE']/campo">

          <xsl:variable name="field" select="."/>
          <COL>
            <DATA>

              <xsl:choose>

                <xsl:when test="$field='ID_CARD'">
                  <xsl:value-of select="$card"/>
                </xsl:when>

                <xsl:otherwise>
                  <xsl:value-of select="document('scheda_oa.xml')/CARDSET/CARD[@id_card=$card]//*[name()=$field]"/>
                </xsl:otherwise>
              </xsl:choose>
            </DATA>
          </COL>
        </xsl:for-each>
      </ROW>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>