<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" 
    xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg">
<xsl:output method="xml" indent="yes"
    doctype-public="-//W3C//DTD SVG 1.0//EN"
    doctype-system="http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy> 
</xsl:template>

<xsl:template match="svg:svg">
  <svg xmlns="http://www.w3.org/2000/svg">
    <!-- Order is important here, so the attributes below overrides the 
         originals, which are copied "wholesale" -->
    <xsl:apply-templates select="@*" />
 
    <defs>
      <linearGradient id="lightgrey" x1="0%" y1="0%" x2="100%" y2="100%">
         <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
         <stop offset="100%" style="stop-color:rgb(128,128,128);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="lightblue" x1="0%" y1="0%" x2="100%" y2="100%">
         <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
         <stop offset="100%" style="stop-color:rgb(128,128,255);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="none" x1="0%" y1="0%" x2="100%" y2="100%">
         <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
         <stop offset="100%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
      </linearGradient>
    </defs>

    <xsl:apply-templates />
  </svg>
</xsl:template>

<!-- Match the top most "g" as Graphviz does stupid stuff to it. -->
<xsl:template match="/svg:svg/svg:g"> 
  <g>
    <xsl:apply-templates select="@*"/>
    <!-- Graphviz uses a polygon as the background. Don't want a gradient there -->
    <xsl:for-each select="svg:polygon">
      <xsl:copy><xsl:apply-templates select="@*" /></xsl:copy>
    </xsl:for-each>
    <xsl:apply-templates select="svg:title|svg:g" />
  </g>
</xsl:template> 
 

<xsl:template match="svg:text">
   <text style="font-size:10px; font-family:Verdana">
     <xsl:apply-templates select="@*|text()" />
   </text>
</xsl:template> 


<!-- This is longer than it has to be, but it can be expanded to cover more
     tags simply by changing the "match" attribute -->
<xsl:template match="svg:polygon|svg:ellipse|svg:polyline">
        <xsl:element name="{name()}">
          <xsl:apply-templates select="@*"/>
          <xsl:attribute name="style">fill: black; stroke: none; fill-opacity:0.3</xsl:attribute> 
          <xsl:attribute name="transform">translate(3,3)</xsl:attribute>
        </xsl:element>
        <xsl:element name="{name()}">
          <xsl:apply-templates select="@*" />
          <xsl:choose>
             <xsl:when test="@fill != ''"><xsl:attribute name="style">fill:url(#<xsl:value-of select="@fill"/>);stroke:black;</xsl:attribute></xsl:when>
             <xsl:otherwise><xsl:attribute name="style">fill:url(#<xsl:value-of select="normalize-space(substring-after(substring-before(@style,';'),'fill:'))"/>);stroke:black;</xsl:attribute></xsl:otherwise>
          </xsl:choose>
        </xsl:element>
</xsl:template>

<xsl:template match="svg:path">
        <path>
           <xsl:apply-templates select="@*|text()" />
        </path>
        <path>
          <xsl:apply-templates select="@*" />
          <xsl:attribute name="transform">translate(3,3)</xsl:attribute>
          <xsl:choose>
            <xsl:when test="@stroke != ''"><xsl:attribute name="style">stroke:{@stroke}; stroke-opacity:0.3; fill:none;</xsl:attribute></xsl:when>
            <xsl:otherwise><xsl:attribute name="style">fill: none; stroke: black; stroke-opacity:0.3</xsl:attribute></xsl:otherwise>
          </xsl:choose>
        </path>
</xsl:template>
 
</xsl:stylesheet>

 
