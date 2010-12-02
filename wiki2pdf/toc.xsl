<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:outline="http://code.google.com/p/wkhtmltopdf/outline"
                xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
              indent="yes" />
  <xsl:template match="outline:outline">
    <html>
      <head>
        <title>Table of Content</title>
        <style>
          body {
            color: black;
            background-color: #eeeedd;
            margin-left: 20px;
            margin-right: 20px;
            width: 800px;
          }
          h1 {text-align: center; font-size: 190%;}
          span.page {float: right;}
          li {list-style: none; line-height: 180%;}
          ul {font-size: 100%; }
          ul ul { display:none; }
        </style>
      </head>
      <body>
        <h1>目次</h1>
        <ul><xsl:apply-templates select="outline:item/outline:item"/></ul>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="outline:item">
    <li>
      <xsl:if test="@title!=''">
        <div>
          <span class="title"> <xsl:value-of select="@title" /> </span>
          <span class="page"> <xsl:value-of select="@page" /> </span>
        </div>
      </xsl:if>
      <ul>
        <xsl:apply-templates select="outline:item"/>
      </ul>
    </li>
  </xsl:template>
</xsl:stylesheet>
