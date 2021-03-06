<?xml version="1.0" encoding="UTF-16" standalone="yes"?>
<xsl:stylesheet espi:dummy-for-xmlns="" atom:dummy-for-xmlns="" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:espi="http://naesb.org/espi" xmlns:atom="http://www.w3.org/2005/Atom">
<!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. The name or details of 
    this mode may change during 1Q 2007.-->


<!--PHASES-->


<!--PROLOG-->
<xsl:output method="xml" indent="yes" />

<!--KEYS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path">
<xsl:apply-templates select="parent::*" mode="schematron-get-full-path" />
<xsl:text>/</xsl:text>
<xsl:choose>
<xsl:when test="namespace-uri()=''"><xsl:value-of select="name()" /></xsl:when>
<xsl:otherwise>
<xsl:text>*:</xsl:text>
<xsl:value-of select="local-name()" />
<xsl:text>[namespace-uri()='</xsl:text>
<xsl:value-of select="namespace-uri()" />
<xsl:text>']</xsl:text>
</xsl:otherwise>
</xsl:choose>
<xsl:variable name="preceding" select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])" />
<xsl:text>[</xsl:text>
<xsl:value-of select="1+ $preceding" />
<xsl:text>]</xsl:text>
</xsl:template>
<xsl:template match="@*" mode="schematron-get-full-path">
<xsl:apply-templates select="parent::*" mode="schematron-get-full-path" />
<xsl:text>/</xsl:text>
<xsl:choose>
<xsl:when test="namespace-uri()=''">@sch:schema</xsl:when>
<xsl:otherwise>
<xsl:text>@*[local-name()='</xsl:text>
<xsl:value-of select="local-name()" />
<xsl:text>' and namespace-uri()='</xsl:text>
<xsl:value-of select="namespace-uri()" />
<xsl:text>']</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2">
<xsl:for-each select="ancestor-or-self::*">
<xsl:text>/</xsl:text>
<xsl:value-of select="name(.)" />
<xsl:if test="preceding-sibling::*[name(.)=name(current())]">
<xsl:text>[</xsl:text>
<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />
<xsl:text>]</xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:if test="not(self::*)">
<xsl:text />/@<xsl:value-of select="name(.)" />
</xsl:if>
</xsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path" />
<xsl:template match="text()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')" />
</xsl:template>
<xsl:template match="comment()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')" />
</xsl:template>
<xsl:template match="processing-instruction()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')" />
</xsl:template>
<xsl:template match="@*" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.@', name())" />
</xsl:template>
<xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:text>.</xsl:text>
<xsl:choose>
<xsl:when test="count(. | ../namespace::*) = count(../namespace::*)">
<xsl:value-of select="concat('.namespace::-',1+count(namespace::*),'-')" />
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template>
<xsl:template match="*" mode="generate-id-2" priority="2">
<xsl:text>U</xsl:text>
<xsl:number level="multiple" count="*" />
</xsl:template>
<xsl:template match="node()" mode="generate-id-2">
<xsl:text>U.</xsl:text>
<xsl:number level="multiple" count="*" />
<xsl:text>n</xsl:text>
<xsl:number count="node()" />
</xsl:template>
<xsl:template match="@*" mode="generate-id-2">
<xsl:text>U.</xsl:text>
<xsl:number level="multiple" count="*" />
<xsl:text>_</xsl:text>
<xsl:value-of select="string-length(local-name(.))" />
<xsl:text>_</xsl:text>
<xsl:value-of select="translate(name(),':','.')" />
</xsl:template>
<!--Strip characters-->
<xsl:template match="text()" priority="-1" />

<!--SCHEMA METADATA-->
<xsl:template match="/">
<anElement>
<pattern name="" /><xsl:apply-templates select="/" mode="M2" /><pattern name="" /><xsl:apply-templates select="/" mode="M3" /><pattern name="" /><xsl:apply-templates select="/" mode="M4" /><pattern name="" /><xsl:apply-templates select="/" mode="M5" /><pattern name="" /><xsl:apply-templates select="/" mode="M6" /><pattern name="" /><xsl:apply-templates select="/" mode="M7" /><pattern name="" /><xsl:apply-templates select="/" mode="M8" /><pattern name="" /><xsl:apply-templates select="/" mode="M9" />
</anElement>
</xsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed" priority="4000" mode="M2">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:entry[*/espi:IntervalBlock]" />
<xsl:otherwise>
<assert TestID="D032">
<role></role>
<TestName>IntervalBlock</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:entry[*/espi:MeterReading]" />
<xsl:otherwise>
<assert TestID="D027">
<role></role>
<TestName>MeterReading</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:entry[*/espi:ReadingType]" />
<xsl:otherwise>
<assert TestID="D049">
<role></role>
<TestName>ReadingType</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M2" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M2" />
<xsl:template match="@*|node()" priority="-2" mode="M2">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M2" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M2" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry[*/espi:IntervalBlock]" priority="4000" mode="M3">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:IntervalBlock/espi:interval/espi:start" />
<xsl:otherwise>
<assert TestID="D039">
<role></role>
<TestName>IntervalBlock interval start</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:IntervalBlock/espi:interval/espi:start=atom:content/espi:IntervalBlock/espi:IntervalReading/espi:timePeriod/espi:start" />
<xsl:otherwise>
<assert TestID="D042">
<role></role>
<TestName>first interval in block</TestName>
<Report>verify that first interval in block start time matches the start time of the block</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:IntervalBlock/espi:IntervalReading/espi:timePeriod/espi:duration" />
<xsl:otherwise>
<assert TestID="D044">
<role></role>
<TestName>IntervalReading timePeriod duration</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:IntervalBlock/espi:IntervalReading/espi:timePeriod/espi:start" />
<xsl:otherwise>
<assert TestID="D045">
<role></role>
<TestName>IntervalReading timePeriod start</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:IntervalBlock/espi:IntervalReading/espi:value" />
<xsl:otherwise>
<assert TestID="D046">
<role></role>
<TestName>IntervalReading value</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M3" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M3" />
<xsl:template match="@*|node()" priority="-2" mode="M3">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M3" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M3" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry[*/espi:IntervalBlock]" priority="4000" mode="M4">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:IntervalBlock/espi:interval/espi:duration" />
<xsl:otherwise>
<assert TestID="D038">
<role></role>
<TestName>IntervalBlock interval duration</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:id" />
<xsl:otherwise>
<assert TestID="D031">
<role></role>
<TestName>IntervalBlock id</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='self']/@href" />
<xsl:otherwise>
<assert TestID="D034">
<role></role>
<TestName>IntervalBlock self link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='up']/@href" />
<xsl:otherwise>
<assert TestID="D036">
<role></role>
<TestName>IntervalBlock up link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:published" />
<xsl:otherwise>
<assert TestID="D040">
<role></role>
<TestName>IntervalBlock published</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:title" />
<xsl:otherwise>
<assert TestID="D033">
<role></role>
<TestName>IntervalBlock title</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:updated" />
<xsl:otherwise>
<assert TestID="D041">
<role></role>
<TestName>IntervalBlock updated</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:IntervalBlock]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" />
<xsl:otherwise>
<assert TestID="D035">
<role></role>
<TestName>IntervalBlock self link unique</TestName>
<Report>verify that link is unique</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:MeterReading]/atom:link[@rel='related' and @href=current()/atom:link[@rel='up']/@href])=1" />
<xsl:otherwise>
<assert TestID="D037">
<role></role>
<TestName>IntervalBlock up link</TestName>
<Report>verify that each IntervalBlock points to a single MeterReading</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M4" />
<xsl:template match="@*|node()" priority="-2" mode="M4">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M4" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M4" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry[*/espi:MeterReading]" priority="4000" mode="M5">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:MeterReading" />
<xsl:otherwise>
<assert TestID="D028">
<role></role>
<TestName>MeterReading (this test row is temporary for testing)</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M5" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M5" />
<xsl:template match="@*|node()" priority="-2" mode="M5">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M5" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M5" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry[*/espi:MeterReading]" priority="4000" mode="M6">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:id" />
<xsl:otherwise>
<assert TestID="D018">
<role></role>
<TestName>MeterReading id</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='self']/@href" />
<xsl:otherwise>
<assert TestID="D020">
<role></role>
<TestName>MeterReading self link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='up']/@href" />
<xsl:otherwise>
<assert TestID="D022">
<role></role>
<TestName>MeterReading up link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:published" />
<xsl:otherwise>
<assert TestID="D029">
<role></role>
<TestName>MeterReading published</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:title" />
<xsl:otherwise>
<assert TestID="D019">
<role></role>
<TestName>MeterReading title</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:updated" />
<xsl:otherwise>
<assert TestID="D030">
<role></role>
<TestName>MeterReading updated</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count (/atom:feed/atom:entry/atom:content/espi:IntervalBlock[../../atom:link[@rel='up']/@href = current()/atom:link[@rel='related']/@href]/espi:IntervalReading[espi:timePeriod/espi:start = preceding-sibling::espi:IntervalReading/espi:timePeriod/espi:start])=0" />
<xsl:otherwise>
<assert TestID="D145">
<role></role>
<TestName>MeterReading Interval Block/Interval Readings/ are all unique (by start time)</TestName>
<Report>verify the presence of unique values</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count (/atom:feed/atom:entry[atom:link[@rel='up']/@href = current()/atom:link[@rel='related']/@href]/atom:content/espi:IntervalBlock/espi:interval/espi:start[ . = preceding::espi:IntervalBlock[../../atom:link[@rel='up']/@href = current()/atom:link[@rel='related']/@href]/espi:interval/espi:start])=0" />
<xsl:otherwise>
<assert TestID="D146">
<role></role>
<TestName>MeterReading Interval Blocks are all unique (by start time)</TestName>
<Report>verify the presence of unique values</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:IntervalBlock]/atom:link[@rel='up' and @href=current()/atom:link[@rel='related']/@href])&gt;0" />
<xsl:otherwise>
<assert TestID="D025">
<role></role>
<TestName>MeterReading related (IntervalBlockList)</TestName>
<Report>verify that each MeterReading has associated metering data</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:MeterReading]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" />
<xsl:otherwise>
<assert TestID="D021">
<role></role>
<TestName>MeterReading self link</TestName>
<Report>verify that link is unique</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:ReadingType]/atom:link[@rel='self' and @href=current()/atom:link[@rel='related']/@href])=1" />
<xsl:otherwise>
<assert TestID="D024">
<role></role>
<TestName>MeterReading related (ReadingType)</TestName>
<Report>verify that each MeterReading has one and only one associated ReadingType</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:UsagePoint]/atom:link[@rel='related' and @href=current()/atom:link[@rel='up']/@href])=1" />
<xsl:otherwise>
<assert TestID="D023">
<role></role>
<TestName>Meter reading up link</TestName>
<Report>verify correct up link</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M6" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M6" />
<xsl:template match="@*|node()" priority="-2" mode="M6">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M6" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M6" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=4]]" priority="4000" mode="M7">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:IntervalBlock]/atom:link[@rel = 'up' and @href = /atom:feed/atom:entry[*/espi:MeterReading][atom:link[@rel='related' and @href = current()/atom:link[@rel='self']/@href]]/atom:link[@rel='related']/@href])&gt;0" />
<xsl:otherwise>
<assert TestID="D026">
<role></role>
<TestName>MeterReading</TestName>
<Report>verify that "load profile" meter readings (accumulationBehavour=4) have any associated interval blocks</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M7" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M7" />
<xsl:template match="@*|node()" priority="-2" mode="M7">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M7" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M7" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry[*/espi:ReadingType]" priority="4000" mode="M8">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ReadingType/espi:intervalLength" />
<xsl:otherwise>
<assert TestID="D062">
<role></role>
<TestName>ReadingType intervalLength</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ReadingType/espi:kind" />
<xsl:otherwise>
<assert TestID="D063">
<role></role>
<TestName>ReadingType kind</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ReadingType/espi:powerOfTenMultiplier" />
<xsl:otherwise>
<assert TestID="D065">
<role></role>
<TestName>ReadingType powerOfTenMultiplier</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:content/espi:ReadingType/espi:uom" />
<xsl:otherwise>
<assert TestID="D068">
<role></role>
<TestName>ReadingType uom</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M8" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M8" />
<xsl:template match="@*|node()" priority="-2" mode="M8">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M8" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M8" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN -->


	<!--RULE -->
<xsl:template match="/atom:feed/atom:entry[*/espi:ReadingType]" priority="4000" mode="M9">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:id" />
<xsl:otherwise>
<assert TestID="D048">
<role></role>
<TestName>ReadingType id</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='self']" />
<xsl:otherwise>
<assert TestID="D051">
<role></role>
<TestName>ReadingType self link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:link[@rel='up']" />
<xsl:otherwise>
<assert TestID="D053">
<role></role>
<TestName>ReadingType up link</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:published" />
<xsl:otherwise>
<assert TestID="D069">
<role></role>
<TestName>ReadingType published</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:title" />
<xsl:otherwise>
<assert TestID="D050">
<role></role>
<TestName>ReadingType title</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="atom:updated" />
<xsl:otherwise>
<assert TestID="D070">
<role></role>
<TestName>ReadingType updated</TestName>
<Report>verify the presence of a valid value</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:MeterReading]/atom:link[@rel='related' and @href=current()/atom:link[@rel='self']/@href])&gt;0" />
<xsl:otherwise>
<assert TestID="D054">
<role></role>
<TestName>ReadingType up link</TestName>
<Report>verify that each ReadingType points to at least one MeterReading</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/atom:feed/atom:entry[*/espi:ReadingType]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" />
<xsl:otherwise>
<assert TestID="D052">
<role></role>
<TestName>ReadingType self link</TestName>
<Report>verify that link is unique</Report>
<diagnostics>for future use</diagnostics>
</assert>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M9" />
<xsl:template match="@*|node()" priority="-2" mode="M9">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M9" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M9" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>
