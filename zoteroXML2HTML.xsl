<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:vife="no:where"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 16, 2016</xd:p>
            <xd:p><xd:b>Author:</xd:b> Johannes Kepper</xd:p>
            <xd:p>This XSLT converts an XML output from Zotero to static HTML, 
                to be included in the ViFE website.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <ul>
            <xsl:apply-templates select="//record"/>
        </ul>
    </xsl:template>
    
    <xsl:template match="record">
        <li>
            <xsl:choose>
                <xsl:when test="ref-type/@name = 'Book'">
                    <xsl:sequence select="vife:getAuthors(.)"/>
                </xsl:when>
                <xsl:when test="ref-type/@name = 'Book Section'">
                    
                </xsl:when>
                <xsl:when test="ref-type/@name = 'Generic'">
                    
                </xsl:when>
                <xsl:when test="ref-type/@name = 'Journal Article'">
                    
                </xsl:when>
                <xsl:when test="ref-type/@name = 'Conference Proceedings'">
                    
                </xsl:when>
                <xsl:when test="ref-type/@name = 'Conference Paper'">
                    
                </xsl:when>
            </xsl:choose>
        </li>
    </xsl:template>
    
    <xsl:function name="vife:getAuthors" as="node()*">
        <xsl:param name="record" as="node()"/>
        
        <xsl:variable name="author.elements" select=".//author" as="node()*"/>
        
        <xsl:choose>
            <xsl:when test="count($author.elements) = 1">
                <span class="author"><xsl:value-of select="$author.elements/text()"/></span>
            </xsl:when>
            <xsl:when test="count($author.elements) = 2">
                <span class="author"><xsl:value-of select="$author.elements[1]/text()"/></span>,
                <span class="author"><xsl:value-of select="$author.elements[2]/text()"/></span>
            </xsl:when>
            <xsl:when test="count($author.elements) = 3">
                <span class="author"><xsl:value-of select="$author.elements[1]/text()"/></span>,
                <span class="author"><xsl:value-of select="$author.elements[2]/text()"/></span>,
                <span class="author"><xsl:value-of select="$author.elements[3]/text()"/></span>
            </xsl:when>
            <xsl:when test="count($author.elements) gt 3">
                <span class="author"><xsl:value-of select="$author.elements[1]/text()"/></span> et al.
            </xsl:when>
            <xsl:when test="count($author.elements) = 0">
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:message select="'ERROR: Authors unclear for the following record: '"/>
                <xsl:message select="$record"/>
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:if test="$author.elements/parent::secondary-authors or $author.elements/parent::tertiary-authors">
            (Hrsg.)
        </xsl:if>
        <xsl:text>:</xsl:text>
    </xsl:function>
    
</xsl:stylesheet>