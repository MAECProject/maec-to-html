<?xml version="1.0" encoding="UTF-8"?>
<!--
MAEC XML to HTML transform v0.91
Compatible with MAEC Schema v2.1 output

Updated 9/10/2012
ikirillov@mitre.org
-->


<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:maec="http://maec.mitre.org/XMLSchema/maec-core-2"
    xmlns:cybox="http://cybox.mitre.org/cybox_v1"
    xmlns:Common="http://cybox.mitre.org/Common_v1"
    xmlns:SystemObj="http://cybox.mitre.org/objects#SystemObject"
    xmlns:FileObj="http://cybox.mitre.org/objects#FileObject"
    xmlns:ProcessObj="http://cybox.mitre.org/objects#ProcessObject"
    xmlns:PipeObj="http://cybox.mitre.org/objects#PipeObject" 
    xmlns:PortObj="http://cybox.mitre.org/objects#PortObject" 
    xmlns:AddressObj="http://cybox.mitre.org/objects#AddressObject"
    xmlns:SocketObj="http://cybox.mitre.org/objects#SocketObject"
    xmlns:MutexObj="http://cybox.mitre.org/objects#MutexObject"
    xmlns:MemoryObj="http://cybox.mitre.org/objects#MemoryObject"
    xmlns:URIObj="http://cybox.mitre.org/objects#URIObject"
    xmlns:LibraryObj="http://cybox.mitre.org/objects#LibraryObject"
    xmlns:WinHandleObj="http://cybox.mitre.org/objects#WinHandleObject"
    xmlns:WinMutexObj="http://cybox.mitre.org/objects#WinMutexObject"
    xmlns:WinServiceObj="http://cybox.mitre.org/objects#WinServiceObject"
    xmlns:WinRegistryKeyObj="http://cybox.mitre.org/objects#WinRegistryKeyObject"
    xmlns:WinPipeObj="http://cybox.mitre.org/objects#WinPipeObject"
    xmlns:WinDriverObj="http://cybox.mitre.org/objects#WinDriverObject"
    xmlns:WinFileObj="http://cybox.mitre.org/objects#WinFileObject"
    xmlns:WinExecutableFileObj="http://cybox.mitre.org/objects#WinExecutableFileObject"
    xmlns:WinProcessObj="http://cybox.mitre.org/objects#WinProcessObject"
    xmlns:mmdef="http://xml/metadataSharing.xsd" >
    
<xsl:output method="html" omit-xml-declaration="yes" indent="no" media-type="text/html"/>
    <xsl:key name="objectID" match="maec:Object" use="@id"/>
    <xsl:key name="objectType" match="maec:Object" use="@type"/>
    <xsl:key name="actionID" match="maec:Action" use="@id"/>
    
    <xsl:template match="/">
            <html>
                <title>MAEC Report</title>
                <STYLE type="text/css">
                    /* define table skin */
                    table.grid {
                    margin: 0px;
                    margin-left: 25px;
                    padding: 0;
                    border-collapse: separate;
                    border-spacing: 0;
                    width: 100%;
                    border-style:solid;
                    border-width:1px;
                    }
                    
                    table.grid * {
                    font: 11px Arial, Helvetica, sans-serif;
                    vertical-align: top;
                    text-align: left;
                    }
                    
                    table.grid thead, table.grid .collapsible {
                    background-color: #c7c3bb;
                    }
                    
                    table.grid th {
                    color: #565770;
                    padding: 4px 16px 4px 0;
                    padding-left: 10px;
                    font-weight: bold;
                    } 
                    
                    table.grid td {
                    color: #565770;
                    padding: 4px 6px;
                    }

                    table.grid tr.even {
                    background-color: #EDEDE8;
                    }

                    body {
                    font: 11px Arial, Helvetica, sans-serif;
                    font-size: 13px;
                    }
                    #wrapper { 
                    margin: 0 auto;
                    width: 80%;
                    }
                    #header {
                    color: #333;
                    padding: 10px;
                    /*border: 2px solid #ccc;*/
                    margin: 10px 0px 5px 0px;
                    /*background: #BD9C8C;*/
                    }
                    #content { 
                    width: 100%;
                    color: #333;
                    border: 2px solid #ccc;
                    background: #FFFFFF;
                    margin: 0px 0px 5px 0px;
                    padding: 10px;
                    font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
                    font-size: 11px;
                    color: #039;
                    }
                    #hor-minimalist-a
                    {
                    font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
                    font-size: 12px;
                    background: #fff;
                    margin: 0px;
                    border-collapse: collapse;
                    text-align: left;
                    }
                    #hor-minimalist-a th
                    {
                    font-size: 11px;
                    font-weight: normal;
                    color: #039;
                    padding: 10px 8px;
                    border-bottom: 2px solid #6678b1;
                    }
                    #hor-minimalist-a td
                    {
                    color: #669;
                    padding: 9px 8px 0px 8px;
                    }
                    #hor-minimalist-a tbody tr:hover td
                    {
                    color: #009;
                    }
                    #one-column-emphasis
                    {
                    font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
                    font-size: 12px;
                    margin: 0px;
                    text-align: left;
                    border-collapse: collapse;
                    }
                    #one-column-emphasis td
                    {
                    padding: 5px 10px;
                    color: #200;
                    border-top: 1px solid #e8edff;
                    border-right: 1px solid #e8edff;
                    border-bottom: 1px solid #e8edff;
                    }
                    .oce-first
                    {
                    background: #d0dafd;
                    border-right: 10px solid transparent;
                    border-left: 10px solid transparent;
                    }
                    .oce-first-inner
                    {
                    background: #EFF8F4;
                    border-right: 10px solid transparent;
                    border-left: 10px solid transparent;
                    }
                    .oce-first-inner-inner
                    {
                    background: #E5F4EE;
                    border-right: 10px solid transparent;
                    border-left: 10px solid transparent;
                    }
                    .oce-first-inner-inner-inner
                    {
                    background: #DBEFE6;
                    border-right: 10px solid transparent;
                    border-left: 10px solid transparent;
                    }
                    .oce-first-inner-inner-inner-inner
                    {
                    background: #D0EAE0;
                    border-right: 10px solid transparent;
                    border-left: 10px solid transparent;
                    }
                    .oce-first-inner-inner-inner-inner-inner
                    {
                    background: #B7D1C6;
                    border-right: 10px solid transparent;
                    border-left: 10px solid transparent;
                    }
                    #container { 
                    color: #333;
                    border: 1px solid #ccc;
                    background: #FFFFFF;
                    margin: 0px 0px 10px 0px;
                    padding: 10px;
                    }
                    #section { 
                    color: #333;
                    background: #FFFFFF;
                    margin: 0px 0px 5px 0px;
                    }
                    #object_label_div div {
                    display: inline;
                    width: 30%;
                    }
                    #object_type_label {
                    width:200px;
                    background: #e8edff;
                    border-top: 1px solid #ccc;
                    border-left: 1px solid #ccc;
                    border-right: 5px solid #ccc;
                    padding: 1px;
                    }
                    #defined_object_type_label {
                    width:400px;
                    background: #E9F3CF;
                    border-top: 1px solid #ccc;
                    border-left: 1px solid #ccc;
                    border-right: 1px solid #ccc;
                    padding: 1px;
                    }
                    #associated_object_label {
                    font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
                    font-size: 12px;
                    margin-bottom: 2px;
                    }
                </STYLE>
                
                <SCRIPT type="text/javascript">
                    //Collapse functionality
                    function toggleDiv(divid, spanID){
                    if(document.getElementById(divid).style.display == 'none'){
                    document.getElementById(divid).style.display = 'block';
                    if(spanID){
                    document.getElementById(spanID).innerText = "-";
                    }
                    }else{
                    document.getElementById(divid).style.display = 'none';
                    if(spanID){
                    document.getElementById(spanID).innerText = "+";
                    }
                    }
                    }
                </SCRIPT>
                <head/>
                <body>
                    <div id="wrapper">
                        <div id="header"> 
                            <H1>MAEC Output</H1>
                            <table id="hor-minimalist-a" width="100%">
                                <thead>
                                    <tr>
                                        <th scope="col">Schema Version</th>
                                        <th scope="col">Generated From</th>
                                        <th scope="col">Generation Date</th>
                                    </tr>
                                </thead>
                                <TR>
                                    <TD><xsl:value-of select="//maec:MAEC_Bundle/@schema_version"/></TD>
                                    <TD><xsl:value-of select="tokenize(document-uri(.), '/')[last()]"/></TD>
                                    <TD><xsl:value-of select="current-date()"/></TD>
                                </TR>   
                            </table>
                        </div>
                        <xsl:if test="//maec:Analyses">
                            <h2><a name="analysis">Analyses</a></h2>
                            <div id="content">
                                 <xsl:call-template name="processAnalyses"/>
                            </div>
                        </xsl:if>
                        <xsl:if test="//maec:MAEC_Bundle/maec:Actions">
                            <h2><a name="actions">Actions</a></h2>
                            <div id="content">
                                <xsl:call-template name="processActions"/>
                            </div>
                        </xsl:if>
                        <xsl:if test="//maec:Collections/maec:Action_Collections">
                            <h2><a name="action_collections">Action Collections</a></h2>
                            <div id="content">
                                <xsl:call-template name="processActionCollections"/>
                            </div>
                        </xsl:if>
                        <xsl:if test="//maec:MAEC_Bundle/maec:Objects">
                            <h2><a name="objects">Objects</a></h2>
                            <div id="content">
                                <xsl:call-template name="processObjects"/>
                            </div> 
                        </xsl:if>
                        <xsl:if test="//maec:Collections/maec:Object_Collections">
                            <h2><a name="object_collections">Object Collections</a></h2>
                            <div id="content">
                                <xsl:call-template name="processObjectCollections"/>
                            </div>
                        </xsl:if>
                   </div>
                </body>
            </html>
    </xsl:template>
    
    <xsl:template name="processAnalyses">
            <xsl:for-each select="//maec:Analyses/maec:Analysis">
                <xsl:variable name="imgVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <div id="anaHeader" style="cursor: pointer;" onclick="toggleDiv('{concat(@id, '_Content')}', '{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span>
                    <b>Analysis</b>
                </div>
                <div id="{concat(@id, '_Content')}" style="overflow:hidden; display:none;">
                    <xsl:call-template name="processAnalysis"/>
                </div>
            </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="processAnalysis">
        <table id="hor-minimalist-a" width="100%">
            <thead>
                <tr>
                    <th scope="col">Analysis Method</th>
                    <th scope="col">Analysis Type</th>
                    <th scope="col">Start Datetime</th>
                    <th scope="col">Complete Datetime</th>
                    <th scope="col">Update Datetime</th>
                </tr>
            </thead>
            <TR>
                <xsl:choose>
                    <xsl:when test="@method">
                        <TD><xsl:value-of select="@method"/></TD>
                    </xsl:when>
                    <xsl:otherwise>
                        <TD>N/A</TD>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="@type">
                        <TD><xsl:value-of select="@type"/></TD>
                    </xsl:when>
                    <xsl:otherwise>
                        <TD>N/A</TD>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="@start_datetime">
                        <TD><xsl:value-of select="@start_datetime"/></TD>
                    </xsl:when>
                    <xsl:otherwise>
                        <TD>N/A</TD>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="@complete_datetime">
                        <TD><xsl:value-of select="@complete_datetime"/></TD>
                    </xsl:when>
                    <xsl:otherwise>
                        <TD>N/A</TD>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="@lastupdate_datetime">
                        <TD><xsl:value-of select="@lastupdate_datetime"/></TD>
                    </xsl:when>
                    <xsl:otherwise>
                        <TD>N/A</TD>
                    </xsl:otherwise>
                </xsl:choose>
            </TR>
        </table>
        <br/>
        
        <h3>Subject(s)</h3><br/>
        <xsl:for-each select="maec:Subject">
            <xsl:for-each select="key('objectID',maec:Object_Reference/@object_id)">
                <xsl:call-template name="processObject">
                    <xsl:with-param name="span_var" select="generate-id()"/>
                    <xsl:with-param name="div_var" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="maec:Object">
                <xsl:call-template name="processObject">
                    <xsl:with-param name="span_var" select="generate-id()"/>
                    <xsl:with-param name="div_var" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:for-each>
        
        <xsl:if test="maec:Summary">
            <h3>Analysis Summary</h3>
            <div id="section">
                <h4><xsl:value-of select="maec:Summary"/></h4>
            </div>
        </xsl:if>
        
        <xsl:if test="maec:Analysts">
            <h3>Analyst(s)</h3><br/>
            <div id="section">
                <table id="one-column-emphasis">
                    <colgroup>
                        <col class="oce-first" />
                    </colgroup>
                    <tbody>
                        <xsl:for-each select="maec:Analysts/Common:Contributor">
                            <xsl:call-template name="processContributor"/>
                        </xsl:for-each>
                    </tbody>
                </table>
                <br/>
            </div>
        </xsl:if>
        
        <xsl:if test="maec:Source">
            <h3>Source</h3><br/>
            <div id="section">
                <table id="one-column-emphasis">
                    <colgroup>
                        <col class="oce-first" />
                    </colgroup>
                    <tbody>
                        <xsl:call-template name="processSource"/>
                    </tbody>
                </table> 
            </div>
        </xsl:if>
        
        <xsl:if test="maec:Analysis_Environment">
            <h3>Analysis Environment</h3><br/>
            <div id="section">
                <xsl:if test="maec:Analysis_Environment/maec:OS">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <td>Operating System (CPE Name)</td>
                                <td><xsl:value-of select="maec:Analysis_Environment/maec:OS/@cpe_name"/></td>
                            </tr>
                        </tbody>
                    </table>
                    <br/>
                </xsl:if>
                <xsl:if test="maec:Analysis_Environment/maec:Enivironment_Variables">
                    <table id="hor-minimalist-a">
                        <thead>
                            <tr>
                                <th scope="col">Environment Variable</th>
                                <th scope="col">Value</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="maec:Analysis_Environment/maec:Enivironment_Variables/maec:Environment_Variable">
                                <tr>
                                    <td><xsl:value-of select="maec:Name"/></td>
                                    <td><xsl:value-of select="maec:Value"/></td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table> <br/>
                </xsl:if>
            </div>
        </xsl:if>
        
        <xsl:if test="maec:Tools">
            <h3>Tools Used</h3>
            <xsl:for-each select="maec:Tools/maec:Tool">
                <div id="section">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first" />
                        </colgroup>
                        <tbody>
                            <xsl:call-template name="processToolInformation"/>
                        </tbody>
                    </table>
                </div>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="maec:Comments">
            <h3>Comments</h3><br/>
            <div id="section">
                <xsl:for-each select="maec:Comments/maec:Comments">
                    <li><xsl:value-of select="."/></li>
                </xsl:for-each>
            </div>
        </xsl:if>

        <xsl:if test="maec:Report">
            <h3>Report</h3><br/>
            <div id="section">
                <xsl:for-each select="maec:Report">
                    <xsl:call-template name="processStructuredTextGroup"/>
                </xsl:for-each>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processSource">
        <xsl:if test="maec:Name">
            <tr>
                <td>Name</td>
                <td><xsl:value-of select="maec:Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="maec:Method">
            <tr>
                <td>Method</td>
                <td><xsl:value-of select="maec:Method"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="maec:Reference">
            <tr>
                <td>Reference</td>
                <td><xsl:value-of select="maec:Reference"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="maec:Organization">
            <tr>
                <td>Organization</td>
                <td><xsl:value-of select="maec:Organization"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="maec:URL">
            <tr>
                <td>URL</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="maec:URL">
                                <xsl:call-template name="processURIObject"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="processContributor">
        <xsl:if test="Common:Name">
            <tr>
                <td>Name</td>
                <td><xsl:value-of select="Common:Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Organization">
            <tr>
                <td>Organization</td>
                <td><xsl:value-of select="Common:Organization"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Role">
            <tr>
                <td>Role</td>
                <td><xsl:value-of select="Common:Role"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Email">
            <tr>
                <td>Email Address</td>
                <td><xsl:value-of select="Common:Email"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Date">
            <tr>
                <td>Date</td>
                <td><xsl:value-of select="Common:Date"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Phone">
            <tr>
                <td>Phone Number</td>
                <td><xsl:value-of select="Common:Phone"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Contribution_Location">
            <tr>
                <td>Contribution Location</td>
                <td><xsl:value-of select="Common:Contribution_Location"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processToolInformation">
        <xsl:if test="Common:Name">
            <tr>
                <td>Name</td>
                <td><xsl:value-of select="Common:Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Version">
            <tr>
                <td>Version</td>
                <td><xsl:value-of select="Common:Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Vendor">
            <tr>
                <td>Vendor</td>
                <td><xsl:value-of select="Common:Vendor"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Service_Pack">
            <tr>
                <td>Service Pack</td>
                <td><xsl:value-of select="Common:Service_Pack"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Tool_Hashes">
            <tr>
                <td>Tool Hashes</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Tool_Hashes/Common:Hash">
                                <xsl:call-template name="processHash"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Tool_Configuration">
            <tr>
                <td>Tool Configuration</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Tool_Configuration">
                                <xsl:call-template name="processToolConfiguration"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processToolConfiguration">
        <xsl:if test="Common:Configuration_Settings">
            <tr>
                <td>Configuration Settings</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Configuration_Settings/Common:Configuration_Setting">
                                <xsl:call-template name="processConfigurationSetting"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Dependencies">
            <tr>
                <td>Dependencies</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Dependencies/Common:Dependency">
                                <xsl:call-template name="processDependency"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Usage_Context_Assumptions">
            <tr>
                <td>Usage Context Assumptions</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Usage_Context_Assumptions/Common:Usage_Context_Assumption">
                                <xsl:call-template name="processStructuredTextGroup"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Internationalization_Settings">
            <tr>
                <td>Internationalization Settings</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Internationalization_Settings/Common:InternalStrings">
                                <xsl:call-template name="processInternalStrings"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Build_Information">
            <tr>
                <td>Build Information</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Build_Information">
                                <xsl:call-template name="processBuildInformation"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processInternalStrings">
        <xsl:if test="Common:Key">
            <tr>
                <td>Key</td>
                <td><xsl:value-of select="Common:Key"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Content">
            <tr>
                <td>Content</td>
                <td><xsl:value-of select="Common:Content"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processBuildInformation">
        <xsl:if test="Common:Build_ID">
            <tr>
                <td>Build ID</td>
                <td><xsl:value-of select="Common:Build_ID"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Build_Project">
            <tr>
                <td>Build Project</td>
                <td><xsl:value-of select="Common:Build_Project"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Build_Utility">
            <tr>
                <td>Build Utility</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Build_Utility">
                                <xsl:call-template name="processBuildUtility"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Build_Version">
            <tr>
                <td>Build Version</td>
                <td><xsl:value-of select="Common:Build_Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Build_Label">
            <tr>
                <td>Build Label</td>
                <td><xsl:value-of select="Common:Build_Label"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Compilation_Date">
            <tr>
                <td>Compilation Date</td>
                <td><xsl:value-of select="Common:Compilation_Date"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Compilers">
            <tr>
                <td>Compilers</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Compilers/Common:Compiler">
                                <xsl:call-template name="processCompiler"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Build_Configuration">
            <tr>
                <td>Build Configuration</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Build_Configuration">
                                <xsl:call-template name="processBuildConfiguration"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Build_Script">
            <tr>
                <td>Build Script</td>
                <td><xsl:value-of select="Common:Build_Script"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Libraries">
            <tr>
                <td>Libraries</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Libraries/Common:Library">
                                <xsl:call-template name="processLibrary"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Build_Output_Log">
            <tr>
                <td>Build Output Log</td>
                <td><xsl:value-of select="Common:Build_Output_Log"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processLibrary">
        <xsl:if test="@name">
            <tr>
                <td>Name</td>
                <td><xsl:value-of select="@name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="@version">
            <tr>
                <td>Version</td>
                <td><xsl:value-of select="@version"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processBuildConfiguration">
        <xsl:if test="Common:Configuration_Setting_Description">
            <tr>
                <td>Configuration Setting Description</td>
                <td><xsl:value-of select="Common:Configuration_Setting_Description"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Configuration_Settings">
            <tr>
                <td>Configuration Settings</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Configuration_Settings/Common:Configuration_Setting">
                                <xsl:call-template name="processConfigurationSetting"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processCompiler">
        <xsl:if test="Common:Compiler_Informal_Description">
            <tr>
                <td>Compiler Informal Description</td>
                <td><xsl:value-of select="Common:Compiler_Informal_Description"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Compiler_CPE_Specification">
            <tr>
                <td>Compiler CPE Specification</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Compiler_CPE_Specification">
                                <xsl:call-template name="processCPESpecification"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processBuildUtility">
        <xsl:if test="Common:Build_Utility_Name">
            <tr>
                <td>Build Utility Name</td>
                <td><xsl:value-of select="Common:Build_Utility_Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Build_Utility_CPE_Specification">
            <tr>
                <td>Build Utility</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Build_Utility_CPE_Specification">
                                <xsl:call-template name="processCPESpecification"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processCPESpecification">
        <xsl:if test="Common:CPE_Name">
            <tr>
                <td>CPE Name</td>
                <td><xsl:value-of select="Common:CPE_Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Title">
            <tr>
                <td>Title</td>
                <td><xsl:value-of select="Common:Title"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Meta_Item_Metadata">
            <tr>
                <td>Meta Item Metadata</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Meta_Item_Metadata">
                                <xsl:call-template name="processMetaItemMetadata"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processMetaItemMetadata">
        <xsl:if test="Common:Modification_Date">
            <tr>
                <td>Modification Data</td>
                <td><xsl:value-of select="Common:Modification_Date"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:NVD_ID">
            <tr>
                <td>NVD ID</td>
                <td><xsl:value-of select="Common:NVD_ID"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Status">
            <tr>
                <td>Status</td>
                <td><xsl:value-of select="Common:Status"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:XMLNS_Meta">
            <tr>
                <td>XMLNS Meta</td>
                <td><xsl:value-of select="Common:XMLNS_Meta"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processConfigurationSetting">
        <xsl:if test="Common:Item_Name">
            <tr>
                <td>Item Name</td>
                <td><xsl:value-of select="Common:Item_Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Item_Value">
            <tr>
                <td>Item Value</td>
                <td><xsl:value-of select="Common:Item_Value"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Item_Type">
            <tr>
                <td>Item Type</td>
                <td><xsl:value-of select="Common:Item_Type"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Item_Description">
            <tr>
                <td>Item Description</td>
                <td><xsl:value-of select="Common:Item_Description"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processDependency">
        <xsl:if test="Common:Dependency_Type">
            <tr>
                <td>Type</td>
                <td><xsl:value-of select="Common:Dependency_Type"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Dependency_Description">
            <tr>
                <td>Description</td>
                <td><xsl:value-of select="Common:Dependency_Description"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processActions">
            <xsl:for-each select="//maec:MAEC_Bundle/maec:Actions">
                <div id="actionsHeader" style="cursor: pointer;" onclick="toggleDiv('allactionsdiv', 'allactionsspan')">
                    <span id="allactionsspan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>All Actions</b>
                </div>
                <div id="allactionsdiv" style="overflow:hidden; display:none;">
                    <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                        <COLGROUP>
                            <COL width="50%"/>
                            <COL width="10%"/>
                            <COL width="10%"/>
                            <COL width="10%"/>
                            <COL width="10%"/>
                            <COL width="10%"/>
                        </COLGROUP>
                        <THEAD>
                            <TR>
                                <TH class="header">
                                    Name
                                </TH>
                                <TH class="header">
                                    Type
                                </TH>
                                <TH class="header">
                                    Context
                                </TH>
                                <TH class="header">
                                    Ordinal Position
                                </TH>
                                <TH class="header">
                                    Status
                                </TH>
                                <TH class="header">
                                    Timestamp
                                </TH>
                            </TR>
                        </THEAD>
                        <TBODY>
                            <xsl:for-each select="maec:Action">
                                <xsl:sort select="@type" order="ascending"/>
                                <xsl:choose>
                                    <xsl:when test="position() mod 2">
                                        <TR class="odd">
                                            <xsl:call-template name="processAction"/>
                                        </TR>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <TR class="even">
                                            <xsl:call-template name="processAction"/>
                                        </TR>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </TBODY>
                    </TABLE>    
                </div>
            </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="processObjectCollections">
        <xsl:for-each select="//maec:Collections/maec:Object_Collections/maec:Object_Collection">
            <xsl:variable name="imgVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
            <div id="objectColHeader" style="cursor: pointer;" onclick="toggleDiv('{concat(replace(@name,' ','_'),'_Header')}', '{$imgVar}')">
                <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b><xsl:value-of select="@name"/></b>
            </div>
            <div id="{concat(replace(@name,' ','_'),'_Header')}" style="overflow:hidden; display:none;">
                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                    <COLGROUP>
                        <COL width="70%"/>
                        <COL width="30%"/>
                    </COLGROUP>
                    <THEAD>
                        <TR>
                            <TH class="header">
                                Object Type
                            </TH>
                            <TH class="header">
                                Defined Object Type
                            </TH>
                        </TR>
                    </THEAD>
                    <TBODY>
                        <xsl:for-each select="maec:Object_List/maec:Object">
                            <xsl:sort select="@type" order="ascending"/>
                            <xsl:choose>
                                <xsl:when test="position() mod 2">
                                    <TR class="odd">
                                        <xsl:call-template name="processObj"/>
                                    </TR>
                                </xsl:when>
                                <xsl:otherwise>
                                    <TR class="even">
                                        <xsl:call-template name="processObj"/>
                                    </TR>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </TBODY>
                </TABLE>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="processActionCollections">
            <xsl:for-each select="//maec:Collections/maec:Action_Collections/maec:Action_Collection">
                <xsl:variable name="imgVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <div id="actioncolHeader" style="cursor: pointer;" onclick="toggleDiv('{concat(replace(@name,' ','_'),'_Header')}', '{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b><xsl:value-of select="@name"/></b>
                           </div>
                           <div id="{concat(replace(@name,' ','_'),'_Header')}" style="overflow:hidden; display:none;">
                                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                                    <COLGROUP>
                                        <COL width="50%"/>
                                        <COL width="10%"/>
                                        <COL width="10%"/>
                                        <COL width="10%"/>
                                        <COL width="10%"/>
                                        <COL width="10%"/>
                                    </COLGROUP>
                                    <THEAD>
                                        <TR>
                                            <TH class="header">
                                                Name
                                            </TH>
                                            <TH class="header">
                                                Type
                                            </TH>
                                            <TH class="header">
                                                Context
                                            </TH>
                                            <TH class="header">
                                                Ordinal Position
                                            </TH>
                                            <TH class="header">
                                                Status
                                            </TH>
                                            <TH class="header">
                                                Timestamp
                                            </TH>
                                        </TR>
                                    </THEAD>
                                    <TBODY>
                                        <xsl:for-each select="maec:Action_List/maec:Action">
                                            <xsl:sort select="@type" order="ascending"/>
                                            <xsl:choose>
                                                <xsl:when test="position() mod 2">
                                                    <TR class="odd">
                                                        <xsl:call-template name="processAction"/>
                                                    </TR>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <TR class="even">
                                                        <xsl:call-template name="processAction"/>
                                                    </TR>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </TBODY>
                                </TABLE>    
                            </div>
            </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="processAction">
        <TD>
            <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
            <xsl:variable name="imgVar" select="generate-id()"/>
            <div id="fileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span>
                <xsl:choose>
                    <xsl:when test="cybox:Action_Name/cybox:Defined_Name">
                        <xsl:value-of select="cybox:Action_Name/cybox:Defined_Name"/>
                    </xsl:when>
                    <xsl:when test="cybox:Action_Name/cybox:Undefined_Name">
                        <xsl:value-of select="cybox:Action_Name/cybox:Undefined_Name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        (no name)
                    </xsl:otherwise>
                </xsl:choose>
            </div>
            <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                <xsl:if test="maec:Description">
                    <br/>
                    <div id="section">
                                <span style="font-weight:bold;">Description</span> 
                                <h3>Description</h3><br/>
                                <xsl:for-each select="maec:Description">
                                    <xsl:call-template name="processStructuredTextGroup"/>
                                </xsl:for-each>
                    </div>
                </xsl:if>
                
                <xsl:if test="cybox:Associated_Objects">
                    <xsl:for-each select="cybox:Associated_Objects/cybox:Associated_Object">
                        <xsl:call-template name="processAssociatedObject"/>
                    </xsl:for-each>
                </xsl:if>
                
            </div>
        </TD>
        <TD>                    
            <xsl:choose>
            <xsl:when test="@type">
                <xsl:value-of select="@type"/>
            </xsl:when>
            <xsl:otherwise>
                N/A
            </xsl:otherwise>
            </xsl:choose>
        </TD>
        
        <TD>                    
            <xsl:choose>
                <xsl:when test="@context">
                    <xsl:value-of select="@context"/>
                </xsl:when>
                <xsl:otherwise>
                    N/A
                </xsl:otherwise>
            </xsl:choose>
        </TD>
        
        <TD>
            <xsl:choose>
                <xsl:when test="@ordinal_position">
                    <xsl:value-of select="@ordinal_position"/>
                </xsl:when>
                <xsl:otherwise>
                    N/A
                </xsl:otherwise>
            </xsl:choose>
        </TD>
        
        <TD>                    
            <xsl:choose>
            <xsl:when test="@action_status">
                <xsl:value-of select="@action_status"/>
            </xsl:when>
            <xsl:otherwise>
                N/A
            </xsl:otherwise>
        </xsl:choose>
        </TD>
        
        <TD>                    
         <xsl:choose>
            <xsl:when test="@timestamp">
                <xsl:value-of select="@timestamp"/>
            </xsl:when>
            <xsl:otherwise>
                N/A
            </xsl:otherwise>
        </xsl:choose>
        </TD>       
    </xsl:template>

    <xsl:template name="processDefinedObject">
        <xsl:param name="span_var"/>
        <xsl:param name="div_var"/>
        <xsl:choose>
            <xsl:when test="@xsi:type='FileObj:FileObjectType'">
                <div id="fileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> File Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processFileObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='WinFileObj:WindowsFileObjectType'">
                <div id="winFileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Windows File Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processFileObject"/>
                    <xsl:call-template name="processWinFileObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='WinExecutableFileObj:WindowsExecutableFileObjectType'">
                <div id="winExecFileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Windows Executable File Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processFileObject"/>
                    <xsl:call-template name="processWinFileObject"/>
                    <xsl:call-template name="processWinExecutableFileObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='WinRegistryKeyObj:WindowsRegistryKeyObjectType'">
                <div id="winRegKeyObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Windows Registry Key Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processWinRegistryKeyObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='ProcessObj:ProcessObjectType'">
                <div id="processObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Process Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processProcessObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='WinProcessObj:WindowsProcessObjectType'">
                <div id="winProcessObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Windows Process Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processProcessObject"/>
                    <xsl:call-template name="processWinProcessObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='WinServiceObj:WindowsServiceObjectType'">
                <div id="winServiceObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Windows Service Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processProcessObject"/>
                    <xsl:call-template name="processWinProcessObject"/>
                    <xsl:call-template name="processWinServiceObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='WinDriverObj:WindowsDriverObjectType'">
                <div id="winDriverObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Windows Driver Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processWinDriverObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='PipeObj:PipeObjectType'">
                <div id="pipeObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Pipe Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processPipeObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='WinPipeObj:WindowsPipeObjectType'">
                <div id="winPipeObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Windows Pipe Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processPipeObject"/>
                    <xsl:call-template name="processWinPipeObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='MutexObj:MutexObjectType'">
                <div id="mutexObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Mutex Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processMutexObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='WinMutexObj:WindowsMutexObjectType'">
                <div id="winMutexObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Windows Mutex Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processMutexObject"/>
                    <xsl:call-template name="processWinMutexObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='WinPipeObj:WindowsPipeObjectType'">
                <div id="winPipeObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Windows Pipe Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processPipeObject"/>
                    <xsl:call-template name="processWinPipeObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='SocketObj:SocketObjectType'">
                <div id="socketObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Socket Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processSocketObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='URIObj:URIObjectType'">
                <div id="uriObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> URI Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processURIObject"/>
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='LibraryObj:LibraryObjectType'">
                <div id="libraryObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Library Object Attributes
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:call-template name="processLibraryObject"/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="processDomainSpecificObjectAttributes">
        <xsl:param name="span_var" select="generate-id()"/>
        <xsl:param name="div_var" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
        <xsl:choose>
            <xsl:when test="@xsi:type='maec:AVClassificationsType'">
                <div id="avClass" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> AV Classifications
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <xsl:call-template name="processAVClassifications"/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="processDefinedEffect">
        <xsl:param name="span_var" select="generate-id()"/>
        <xsl:param name="div_var" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
        <xsl:choose>
            <xsl:when test="@xsi:type='cybox:DataReadEffectType'">
                <div id="effect" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Data Read (effect)
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="cybox:Data">
                                <xsl:call-template name="processDataSegment"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='cybox:DataReceivedEffectType'">
                <div id="effect" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Data Received (effect)
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="cybox:Data">
                                <xsl:call-template name="processDataSegment"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='cybox:DataSentEffectType'">
                <div id="effect" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Data Sent (effect)
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="cybox:Data">
                                <xsl:call-template name="processDataSegment"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='cybox:DataWrittenEffectType'">
                <div id="effect" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Data Written (effect)
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="cybox:Data">
                                <xsl:call-template name="processDataSegment"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='cybox:PropertyReadEffectType'">
                <div id="effect" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Property Read (effect)
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:if test="cybox:Name">
                                <tr>
                                    <td>Name</td>
                                    <td><xsl:value-of select="cybox:Name"/></td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="cybox:Value">
                                <tr>
                                    <td>Value</td>
                                    <td><xsl:value-of select="cybox:Value"/></td>
                                </tr>
                            </xsl:if>
                        </tbody>
                    </table> 
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='cybox:SendControlCodeEffectType'">
                <div id="effect" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Control Code Sent (effect)
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:if test="cybox:Control_Code">
                                <tr>
                                    <td>Control Code</td>
                                    <td><xsl:value-of select="cybox:Control_Code"/></td>
                                </tr>
                            </xsl:if>
                        </tbody>
                    </table> 
                </div>
            </xsl:when>
            <xsl:when test="@xsi:type='cybox:ValuesEnumeratedEffectType'">
                <div id="effect" style="cursor: pointer;" onclick="toggleDiv('{$div_var}','{$span_var}')">
                    <span id="{$span_var}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Values Enumerated (effect)
                </div>
                <div id="{$div_var}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="cybox:Values/cybox:Value">
                                <tr>
                                    <td>Value</td>
                                    <td><xsl:value-of select="cybox:Value"/></td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="processDataSegment">
        <xsl:if test="Common:Data_Format">
            <tr>
                <td>Data Format</td>
                <td><xsl:value-of select="Common:Data_Format"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Data_Size">
            <tr>
                <td>Data Size</td>
                <td><xsl:value-of select="Common:Data_Size"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Data_Segment">
            <tr>
                <td>Data Segment</td>
                <td><xsl:value-of select="Common:Data_Segment"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Offset">
            <tr>
                <td>Offset</td>
                <td><xsl:value-of select="Common:Offset"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Search_Distance">
            <tr>
                <td>Search Distance</td>
                <td><xsl:value-of select="Common:Search_Distance"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Search_Within">
            <tr>
                <td>Search Within</td>
                <td><xsl:value-of select="Common:Search_Within"/></td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template name="processAssociatedObject">
        <xsl:param name="span_var" select="generate-id()"/>
        <xsl:param name="div_var" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
        <xsl:choose>
            <xsl:when test="@idref">
                <xsl:if test="@association_type">
                    <div id="associated_object_label"><xsl:value-of select="@association_type"/> Object</div>
                </xsl:if>
                <xsl:for-each select="key('objectID',@idref)">
                    <xsl:call-template name="processObject">
                        <xsl:with-param name="div_var" select="$div_var"/>
                        <xsl:with-param name="span_var" select="$span_var"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="@association_type">
                    <div id="associated_object_label"><xsl:value-of select="@association_type"/> Object</div>
                </xsl:if>
                <xsl:call-template name="processObject">
                    <xsl:with-param name="div_var" select="$div_var"/>
                    <xsl:with-param name="span_var" select="$span_var"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="processObjects">
        <div id="allObjHeader" style="cursor: pointer;" onclick="toggleDiv('allObjContent', 'allObjSpan')">
            <span id="allObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>All Objects</b>
        </div>
        <div id="allObjContent" style="overflow:hidden; display:none;">
            <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                <COLGROUP>
                    <COL width="70%"/>
                    <COL width="30%"/>
                </COLGROUP>
                
                <THEAD>
                    <TR>
                        <TH class="header">
                            Object Type
                        </TH>
                        <TH class="header">
                            Defined Object Type
                        </TH>
                    </TR>
                </THEAD>
                <TBODY>
                    <xsl:for-each select="//maec:MAEC_Bundle/maec:Objects/maec:Object">
                        <xsl:sort select="@type" order="ascending"/>
                        <xsl:choose>
                            <xsl:when test="position() mod 2">
                                <TR class="odd">
                                    <xsl:call-template name="processObj"/>
                                </TR>
                            </xsl:when>
                            <xsl:otherwise>
                                <TR class="even">
                                    <xsl:call-template name="processObj"/>
                                </TR>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </TBODY>
            </TABLE>
        </div>
    </xsl:template>
    
    <xsl:template name="processObj">
            <TD>
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="fileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <xsl:value-of select="@type"/>
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <xsl:for-each select="cybox:Defined_Object">
                        <xsl:call-template name="processDefinedObject">
                            <xsl:with-param name="div_var" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                            <xsl:with-param name="span_var" select="generate-id()"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </div>
            </TD>
            <TD>                    
                <xsl:choose>
                    <xsl:when test="cybox:Defined_Object">
                        <xsl:value-of select="cybox:Defined_Object/@xsi:type"/>
                    </xsl:when>
                    <xsl:otherwise>
                        N/A
                    </xsl:otherwise>
                </xsl:choose>
            </TD>
        
    </xsl:template>
    
    <xsl:template name="processObject">
        <xsl:param name="span_var"/>
        <xsl:param name="div_var"/>
        <div id="object_label_div">
            <div id="object_type_label"><xsl:value-of select="@type"/> Object </div>
        <xsl:if test="cybox:Defined_Object/@xsi:type">
            <div id="defined_object_type_label"><xsl:value-of select="cybox:Defined_Object/@xsi:type"/></div>
        </xsl:if>
        </div>
        <div id="container">
            <xsl:if test="cybox:Defined_Object">
                <xsl:for-each select="cybox:Defined_Object">
                    <xsl:call-template name="processDefinedObject">
                        <xsl:with-param name="div_var" select="$div_var"/>
                        <xsl:with-param name="span_var" select="$span_var"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="cybox:Domain-specific_Object_Attributes">
                <xsl:for-each select="cybox:Domain-specific_Object_Attributes">
                    <xsl:call-template name="processDomainSpecificObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="cybox:Defined_Effect">
                <xsl:for-each select="cybox:Defined_Effect">
                    <xsl:call-template name="processDefinedEffect"/>
                </xsl:for-each>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template name="processAVClassifications">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:for-each select="maec:AV_Classification">
                    <xsl:call-template name="processClassification"></xsl:call-template>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processClassification">
        <xsl:if test="mmdef:companyName">
            <tr>
                <td>Company Name</td>
                <td><xsl:value-of select="mmdef:companyName"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="mmdef:classificationName">
            <tr>
                <td>Classification Name</td>
                <td><xsl:value-of select="mmdef:classificationName"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processWinExecutableFileObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="WinExecutableFileObj:Peak_Code_Entropy">
                    <tr>
                        <td>Peak Code Entropy</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:call-template name="processPeakCodeEntropy"/>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinExecutableFileObj:PE_Attributes">
                    <tr>
                        <td>PE Attributes</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="WinExecutableFileObj:PE_Attributes">
                                        <xsl:call-template name="processPEAttributes"/>
                                    </xsl:for-each>
                                </tbody>
                            </table>                             
                        </td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processWinHandleObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="WinHandleObj:ID">
                    <tr>
                        <td>ID</td>
                        <td><xsl:value-of select="WinHandleObj:ID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinHandleObj:Name">
                    <tr>
                        <td>Name</td>
                        <td><xsl:value-of select="WinHandleObj:Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinHandleObj:Type">
                    <tr>
                        <td>Type</td>
                        <td><xsl:value-of select="WinHandleObj:Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinHandleObj:Object_Address">
                    <tr>
                        <td>Object Address</td>
                        <td><xsl:value-of select="WinHandleObj:Object_Address"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinHandleObj:Access_Mask">
                    <tr>
                        <td>Access Mask</td>
                        <td><xsl:value-of select="WinHandleObj:Access_Mask"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinHandleObj:Pointer_Count">
                    <tr>
                        <td>Pointer Count</td>
                        <td><xsl:value-of select="WinHandleObj:Pointer_Count"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processPipeObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="@named">
                    <tr>
                        <td>Named</td>
                        <td><xsl:value-of select="@named"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="PipeObj:Name">
                    <tr>
                        <td>Name</td>
                        <td><xsl:value-of select="PipeObj:Name"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processMutexObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="@named">
                    <tr>
                        <td>Named</td>
                        <td><xsl:value-of select="@named"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="MutexObj:Name">
                    <tr>
                        <td>Name</td>
                        <td><xsl:value-of select="MutexObj:Name"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processWinMutexObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="WinMutexObj:Handle">
                    <tr>
                        <td>Handle</td>
                        <td>
                            <xsl:for-each select="WinMutexObj:Handle">
                                <xsl:call-template name="processWinHandleObject"/>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinMutexObj:Security_Attributes">
                    <tr>
                        <td>Security Attributes</td>
                        <td><xsl:value-of select="WinMutexObj:Security_Attributes"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processMemoryObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="@is_injected">
                    <tr>
                        <td>Is Injected</td>
                        <td><xsl:value-of select="@is_injected"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@is_mapped">
                    <tr>
                        <td>Is Mapped</td>
                        <td><xsl:value-of select="@is_mapped"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@is_protected">
                    <tr>
                        <td>Is Protected</td>
                        <td><xsl:value-of select="@is_protected"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="MemoryObj:Hashes">
                    <tr>
                        <td>Hashes</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="MemoryObj:Hashes/Common:Hash">
                                        <xsl:call-template name="processHash"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="MemoryObj:Name">
                    <tr>
                        <td>Name</td>
                        <td><xsl:value-of select="MemoryObj:Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="MemoryObj:Region_Size">
                    <tr>
                        <td>Region Size</td>
                        <td><xsl:value-of select="MemoryObj:Region_Size"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="MemoryObj:Region_Start_Address">
                    <tr>
                        <td>Region Start Address</td>
                        <td><xsl:value-of select="MemoryObj:Region_Start_Address"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processPortObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="PortObj:Port_Value">
                    <tr>
                        <td>Port Number</td>
                        <td><xsl:value-of select="PortObj:Port_Value"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="PortObj:Layer4_Protocol">
                    <tr>
                        <td>Layer 4 Protocol</td>
                        <td><xsl:value-of select="PortObj:Layer4_Protocol"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processURIObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="@type">
                    <tr>
                        <td>URI Type</td>
                        <td><xsl:value-of select="@type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="URIObj:Value">
                    <tr>
                        <td>URI Value</td>
                        <td><xsl:value-of select="URIObj:Value"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processSocketObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="@is_blocking">
                    <tr>
                        <td>Is Blocking</td>
                        <td><xsl:value-of select="@is_blocking"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@is_listening">
                    <tr>
                        <td>Is Listening</td>
                        <td><xsl:value-of select="@is_listening"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="SocketObj:Address_Family">
                    <tr>
                        <td>Address Family</td>
                        <td><xsl:value-of select="SocketObj:Address_Family"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="SocketObj:Domain">
                    <tr>
                        <td>Communication Domain</td>
                        <td><xsl:value-of select="SocketObj:Domain"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="SocketObj:Local_Address">
                    <tr>
                        <td>Local Address</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="SocketObj:Local_Address">
                                        <xsl:call-template name="processSocketAddress"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="SocketObj:Remote_Address">
                    <tr>
                        <td>Remote Address</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="SocketObj:Remote_Address">
                                        <xsl:call-template name="processSocketAddress"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="SocketObj:Protocol">
                    <tr>
                        <td>IP Protocol</td>
                        <td><xsl:value-of select="SocketObj:Protocol"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="SocketObj:Options">
                    <tr>
                        <td>Socket Options</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="SocketObj:Options">
                                        <xsl:call-template name="processSocketOptions"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="SocketObj:Type">
                    <tr>
                        <td>Socket Type</td>
                        <td><xsl:value-of select="SocketObj:Type"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processSocketOptions">
        <xsl:if test="SocketObj:IP_MULTICAST_IF">
            <tr>
                <td>IP_MULTICAST_IF</td>
                <td><xsl:value-of select="SocketObj:IP_MULTICAST_IF"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:IP_MULTICAST_IF2">
            <tr>
                <td>IP_MULTICAST_IF2</td>
                <td><xsl:value-of select="SocketObj:IP_MULTICAST_IF2"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:IP_MULTICAST_LOOP">
            <tr>
                <td>IP_MULTICAST_LOOP</td>
                <td><xsl:value-of select="SocketObj:IP_MULTICAST_LOOP"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:IP_TOS">
            <tr>
                <td>IP_TOS</td>
                <td><xsl:value-of select="SocketObj:IP_TOS"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_BROADCAST">
            <tr>
                <td>SO_BROADCAST</td>
                <td><xsl:value-of select="SocketObj:SO_BROADCAST"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_CONDITIONAL_ACCEPT">
            <tr>
                <td>SO_CONDITIONAL_ACCEPT</td>
                <td><xsl:value-of select="SocketObj:SO_CONDITIONAL_ACCEPT"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_KEEPALIVE">
            <tr>
                <td>SO_KEEPALIVE</td>
                <td><xsl:value-of select="SocketObj:SO_KEEPALIVE"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_DONTROUTE">
            <tr>
                <td>SO_DONTROUTE</td>
                <td><xsl:value-of select="SocketObj:SO_DONTROUTE"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_LINGER">
            <tr>
                <td>SO_LINGER</td>
                <td><xsl:value-of select="SocketObj:SO_LINGER"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_DONTLINGER">
            <tr>
                <td>SO_DONTLINGER</td>
                <td><xsl:value-of select="SocketObj:SO_DONTLINGER"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_OOBINLINE">
            <tr>
                <td>SO_OOBINLINE</td>
                <td><xsl:value-of select="SocketObj:SO_OOBINLINE"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_RCVBUF">
            <tr>
                <td>SO_RCVBUF</td>
                <td><xsl:value-of select="SocketObj:SO_RCVBUF"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_GROUP_PRIORITY">
            <tr>
                <td>SO_GROUP_PRIORITY</td>
                <td><xsl:value-of select="SocketObj:SO_GROUP_PRIORITY"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_REUSE_ADDR">
            <tr>
                <td>SO_REUSE_ADDR</td>
                <td><xsl:value-of select="SocketObj:SO_REUSE_ADDR"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_DEBUG">
            <tr>
                <td>SO_DEBUG</td>
                <td><xsl:value-of select="SocketObj:SO_DEBUG"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_RCVTIMEO">
            <tr>
                <td>SO_RCVTIMEO</td>
                <td><xsl:value-of select="SocketObj:SO_RCVTIMEO"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_SNDBUF">
            <tr>
                <td>SO_SNDBUF</td>
                <td><xsl:value-of select="SocketObj:SO_SNDBUF"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_SNDTIMEO">
            <tr>
                <td>SO_SNDTIMEO</td>
                <td><xsl:value-of select="SocketObj:SO_SNDTIMEO"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_UPDATE_ACCEPT_CONTEXT">
            <tr>
                <td>SO_UPDATE_ACCEPT_CONTEXT</td>
                <td><xsl:value-of select="SocketObj:SO_UPDATE_ACCEPT_CONTEXT"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:SO_TIMEOUT">
            <tr>
                <td>SO_TIMEOUT</td>
                <td><xsl:value-of select="SocketObj:SO_TIMEOUT"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:TCP_NODELAY">
            <tr>
                <td>TCP_NODELAY</td>
                <td><xsl:value-of select="SocketObj:TCP_NODELAY"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processSocketAddress">
        <xsl:if test="SocketObj:IP_Address">
            <tr>
                <td>IP Address</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="SocketObj:IP_Address">
                                <xsl:call-template name="processAddressObject"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="SocketObj:Port">
            <tr>
                <td>Port</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="SocketObj:Port">
                                <xsl:call-template name="processPortObject"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processAddressObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="@category">
                    <tr>
                        <td>Address Category</td>
                        <td><xsl:value-of select="@category"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@is_source">
                    <tr>
                        <td>Is Source Address</td>
                        <td><xsl:value-of select="@is_source"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@is_destination">
                    <tr>
                        <td>Is Destination Address</td>
                        <td><xsl:value-of select="@is_destination"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="AddressObj:Address_Value">
                    <tr>
                        <td>Address</td>
                        <td><xsl:value-of select="AddressObj:Address_Value"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="AddressObj:Ext_Category">
                    <tr>
                        <td>Extension Category</td>
                        <td><xsl:value-of select="AddressObj:Address_Value"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="AddressObj:VLAN_Name">
                    <tr>
                        <td>VLAN Name</td>
                        <td><xsl:value-of select="AddressObj:VLAN_Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="AddressObj:VLAN_Num">
                    <tr>
                        <td>VLAN Number</td>
                        <td><xsl:value-of select="AddressObj:VLAN_Num"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processWinServiceObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="@service_dll_signature_exists">
                    <tr>
                        <td>Service DLL Signature Exists</td>
                        <td><xsl:value-of select="@service_dll_signature_exists"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@service_dll_signature_verified">
                    <tr>
                        <td>Service DLL Signature Verified</td>
                        <td><xsl:value-of select="@service_dll_signature_verified"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Description_List">
                    <tr>
                        <td>Descriptions</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="WinServiceObj:Description_List/WinServiceObj:Description">
                                        <tr>
                                            <td>Description</td>
                                            <td><xsl:value-of select="."/></td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Display_Name">
                    <tr>
                        <td>Display Name</td>
                        <td><xsl:value-of select="WinServiceObj:Display_Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Service_Name">
                    <tr>
                        <td>Service Name</td>
                        <td><xsl:value-of select="WinServiceObj:Service_Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Service_DLL">
                    <tr>
                        <td>Service DLL</td>
                        <td><xsl:value-of select="WinServiceObj:Service_DLL"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Service_DLL_Certificate_Issuer">
                    <tr>
                        <td>Service DLL Certificate Issuer</td>
                        <td><xsl:value-of select="WinServiceObj:Service_DLL_Certificate_Issuer"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Service_DLL_Certificate_Subject">
                    <tr>
                        <td>Service DLL Certificate Subject</td>
                        <td><xsl:value-of select="WinServiceObj:Service_DLL_Certificate_Subject"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Service_DLL_Hashes">
                    <tr>
                        <td>Service DLL Hashes</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="WinServiceObj:Service_DLL_Hashes/Common:Hash">
                                        <xsl:call-template name="processHash"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Service_DLL_Signature_Description">
                    <tr>
                        <td>Service DLL Signature Description</td>
                        <td><xsl:value-of select="WinServiceObj:Service_DLL_Signature_Description"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Startup_Command_Line">
                    <tr>
                        <td>Startup Command Line</td>
                        <td><xsl:value-of select="WinServiceObj:Startup_Command_Line"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Startup_Type">
                    <tr>
                        <td>Startup Type</td>
                        <td><xsl:value-of select="WinServiceObj:Startup_Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Service_Status">
                    <tr>
                        <td>Service Status</td>
                        <td><xsl:value-of select="WinServiceObj:Service_Status"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Service_Type">
                    <tr>
                        <td>Service Type</td>
                        <td><xsl:value-of select="WinServiceObj:Service_Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinServiceObj:Started_As">
                    <tr>
                        <td>Started As</td>
                        <td><xsl:value-of select="WinServiceObj:Started_As"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processWinPipeObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="WinPipeObj:Default_Time_Out">
                    <tr>
                        <td>Default Time Out</td>
                        <td><xsl:value-of select="WinPipeObj:Default_Time_Out"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinPipeObj:Handle">
                    <tr>
                        <td>Handle</td>
                        <td>
                            <xsl:for-each select="WinPipeObj:Handle">
                                <xsl:call-template name="processWinHandleObject"/>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinPipeObj:In_Buffer_Size">
                    <tr>
                        <td>Input Buffer Size</td>
                        <td><xsl:value-of select="WinPipeObj:In_Buffer_Size"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinPipeObj:Max_Instances">
                    <tr>
                        <td>Maximum # of Instances</td>
                        <td><xsl:value-of select="WinPipeObj:Max_Instances"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinPipeObj:Open_Mode">
                    <tr>
                        <td>Open Mode</td>
                        <td><xsl:value-of select="WinPipeObj:Open_Mode"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinPipeObj:Out_Buffer_Size">
                    <tr>
                        <td>Output Buffer Size</td>
                        <td><xsl:value-of select="WinPipeObj:Out_Buffer_Size"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinPipeObj:Pipe_Mode">
                    <tr>
                        <td>Pipe Mode</td>
                        <td><xsl:value-of select="WinPipeObj:Pipe_Mode"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinPipeObj:Security_Attributes">
                    <tr>
                        <td>Security Attributes</td>
                        <td><xsl:value-of select="WinPipeObj:Security_Attributes"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processLibraryObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="LibraryObj:Name">
                    <tr>
                        <td>Name</td>
                        <td><xsl:value-of select="LibraryObj:Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="LibraryObj:Base_Address">
                    <tr>
                        <td>Base_Address</td>
                        <td><xsl:value-of select="LibraryObj:Base_Address"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="LibraryObj:Path">
                    <tr>
                        <td>Path</td>
                        <td><xsl:value-of select="LibraryObj:Path"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="LibraryObj:Size">
                    <tr>
                        <td>Size (bytes)</td>
                        <td><xsl:value-of select="LibraryObj:Size"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="LibraryObj:Type">
                    <tr>
                        <td>Type</td>
                        <td><xsl:value-of select="LibraryObj:Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="LibraryObj:Version">
                    <tr>
                        <td>Version</td>
                        <td><xsl:value-of select="LibraryObj:Version"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processFileObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="FileObj:File_Name">
                    <tr>
                        <td>File Name</td>
                        <td><xsl:value-of select="FileObj:File_Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:File_Path">
                    <tr>
                        <td>File Path</td>
                        <td><xsl:value-of select="FileObj:File_Path"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Device_Path">
                    <tr>
                        <td>Device Path</td>
                        <td><xsl:value-of select="FileObj:Device_Path"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Full_Path">
                    <tr>
                        <td>Full Path</td>
                        <td><xsl:value-of select="FileObj:Full_Path"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:File_Extension">
                    <tr>
                        <td>File Extension</td>
                        <td><xsl:value-of select="FileObj:File_Extension"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Size_In_Bytes">
                    <tr>
                        <td>Size (bytes)</td>
                        <td><xsl:value-of select="FileObj:Size_In_Bytes"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Modified_Time">
                    <tr>
                        <td>Modified Time (m_time)</td>
                        <td><xsl:value-of select="FileObj:Modified_Time"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Accessed_Time">
                    <tr>
                        <td>Accessed Time (a_time)</td>
                        <td><xsl:value-of select="FileObj:Accessed_Time"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Created_Time">
                    <tr>
                        <td>Created Time (c_time)</td>
                        <td><xsl:value-of select="FileObj:Created_Time"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:User_Owner">
                    <tr>
                        <td>User Owner</td>
                        <td><xsl:value-of select="FileObj:User_Owner"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Peak_Entropy">
                    <tr>
                        <td>User Owner</td>
                        <td><xsl:value-of select="FileObj:User_Owner"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Hashes">
                    <tr>
                        <td>Hashes</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="FileObj:Hashes/Common:Hash">
                                        <xsl:call-template name="processHash"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Digital_Signatures">
                    <tr>
                        <td>Digital Signatures</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="FileObj:Digital_Signatures/FileObj:Digital_Signature">
                                        <xsl:call-template name="processDigitalSignature"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Sym_Links">
                    <tr>
                        <td>Symbolic Links</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="FileObj:Sym_Links/FileObj:Sym_Link">
                                        <tr>
                                            <td>Symbolic Link</td>
                                            <td><xsl:value-of select="."/></td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Packer_List">
                    <tr>
                        <td>Packed With</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="FileObj:Packer_List/FileObj:Packer">
                                        <xsl:call-template name="processPacker"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="FileObj:Byte_Runs">
                    <tr>
                        <td>Byte Runs</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="FileObj:Byte_Runs/Common:Byte_Run">
                                        <xsl:call-template name="processByteRun"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processWinDriverObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="WinDriverObj:Driver_Name">
                    <tr>
                        <td>Driver Name</td>
                        <td><xsl:value-of select="WinDriverObj:Driver_Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:Device_Object_List">
                    <tr>
                        <td>Devices List</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="WinDriverObj:Device_Object_List/WinDriverObj:Device_Object">
                                        <xsl:call-template name="processDriverDevice"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:Driver_Object_Address">
                    <tr>
                        <td>Driver Object Address</td>
                        <td><xsl:value-of select="WinDriverObj:Driver_Object_Address"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:Driver_Start_IO">
                    <tr>
                        <td>Driver StartIO Entrypoint</td>
                        <td><xsl:value-of select="WinDriverObj:Driver_Start_IO"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:Driver_Unload">
                    <tr>
                        <td>Driver Unload Entrypoint</td>
                        <td><xsl:value-of select="WinDriverObj:Driver_Unload"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:Image_Base">
                    <tr>
                        <td>Preferred Image Base Address</td>
                        <td><xsl:value-of select="WinDriverObj:Image_Base"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:Image_Size">
                    <tr>
                        <td>Image Size (bytes)</td>
                        <td><xsl:value-of select="WinDriverObj:Image_Size"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_CLEANUP">
                    <tr>
                        <td>IRP_MJ_CLEANUP (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_CLEANUP"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_CLOSE">
                    <tr>
                        <td>IRP_MJ_CLOSE (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_CLOSE"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_CREATE">
                    <tr>
                        <td>IRP_MJ_CREATE (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_CREATE"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_CREATE_MAILSLOT">
                    <tr>
                        <td>IRP_MJ_CREATE_MAILSLOT (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_CREATE_MAILSLOT"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_CREATE_NAMED_PIPE">
                    <tr>
                        <td>IRP_MJ_CREATE_NAMED_PIPE (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_CREATE_NAMED_PIPE"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_DEVICE_CHANGE">
                    <tr>
                        <td>IRP_MJ_DEVICE_CHANGE (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_DEVICE_CHANGE"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_DEVICE_CONTROL">
                    <tr>
                        <td>IRP_MJ_DEVICE_CONTROL (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_DEVICE_CONTROL"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_DIRECTORY_CONTROL">
                    <tr>
                        <td>IRP_MJ_DIRECTORY_CONTROL (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_DIRECTORY_CONTROL"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_FILE_SYSTEM_CONTROL">
                    <tr>
                        <td>IRP_MJ_FILE_SYSTEM_CONTROL (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_FILE_SYSTEM_CONTROL"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_FLUSH_BUFFERS">
                    <tr>
                        <td>IRP_MJ_FLUSH_BUFFERS (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_FLUSH_BUFFERS"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_INTERNAL_DEVICE_CONTROL">
                    <tr>
                        <td>IRP_MJ_INTERNAL_DEVICE_CONTROL (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_INTERNAL_DEVICE_CONTROL"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_LOCK_CONTROL">
                    <tr>
                        <td>IRP_MJ_LOCK_CONTROL (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_LOCK_CONTROL"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_PNP">
                    <tr>
                        <td>IRP_MJ_PNP (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_PNP"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_POWER">
                    <tr>
                        <td>IRP_MJ_POWER (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_POWER"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_READ">
                    <tr>
                        <td>IRP_MJ_READ (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_READ"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_QUERY_EA">
                    <tr>
                        <td>IRP_MJ_QUERY_EA (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_QUERY_EA"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_QUERY_INFORMATION">
                    <tr>
                        <td>IRP_MJ_QUERY_INFORMATION (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_QUERY_INFORMATION"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_QUERY_SECURITY">
                    <tr>
                        <td>IRP_MJ_QUERY_SECURITY (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_QUERY_SECURITY"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_QUERY_QUOTA">
                    <tr>
                        <td>IRP_MJ_QUERY_QUOTA (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_QUERY_QUOTA"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_QUERY_VOLUME_INFORMATION">
                    <tr>
                        <td>IRP_MJ_QUERY_VOLUME_INFORMATION (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_QUERY_VOLUME_INFORMATION"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_SET_EA">
                    <tr>
                        <td>IRP_MJ_SET_EA (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_SET_EA"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_SET_INFORMATION">
                    <tr>
                        <td>IRP_MJ_SET_INFORMATION (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_SET_INFORMATION"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_SET_SECURITY">
                    <tr>
                        <td>IRP_MJ_SET_SECURITY (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_SET_SECURITY"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_SET_QUOTA">
                    <tr>
                        <td>IRP_MJ_SET_QUOTA (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_SET_QUOTA"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_SET_VOLUME_INFORMATION">
                    <tr>
                        <td>IRP_MJ_SET_VOLUME_INFORMATION (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_SET_VOLUME_INFORMATION"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_SHUTDOWN">
                    <tr>
                        <td>IRP_MJ_SHUTDOWN (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_SHUTDOWN"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_SYSTEM_CONTROL">
                    <tr>
                        <td>IRP_MJ_SYSTEM_CONTROL (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_SYSTEM_CONTROL"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinDriverObj:IRP_MJ_WRITE">
                    <tr>
                        <td>IRP_MJ_WRITE (count)</td>
                        <td><xsl:value-of select="WinDriverObj:IRP_MJ_WRITE"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processDriverDevice">
        <xsl:if test="WinDriverObj:Device_Name">
            <tr>
                <td>Device Name</td>
                <td><xsl:value-of select="WinDriverObj:Device_Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinDriverObj:Device_Object">
            <tr>
                <td>Device Object</td>
                <td><xsl:value-of select="WinDriverObj:Device_Object"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinDriverObj:Attached_Device_Name">
            <tr>
                <td>Attached Device Name</td>
                <td><xsl:value-of select="WinDriverObj:Attached_Device_Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinDriverObj:Attached_Device_Object">
            <tr>
                <td>Attached Device Object</td>
                <td><xsl:value-of select="WinDriverObj:Attached_Device_Object"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinDriverObj:Attached_To_Device_Name">
            <tr>
                <td>Attached To Device Name</td>
                <td><xsl:value-of select="WinDriverObj:Attached_To_Device_Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinDriverObj:Attached_To_Device_Object">
            <tr>
                <td>Attached To Device Object</td>
                <td><xsl:value-of select="WinDriverObj:Attached_To_Device_Object"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinDriverObj:Attached_To_Driver_Object">
            <tr>
                <td>Attached To Driver Object</td>
                <td><xsl:value-of select="WinDriverObj:Attached_To_Driver_Object"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinDriverObj:Attached_To_Driver_Name">
            <tr>
                <td>Attached To Driver Name</td>
                <td><xsl:value-of select="WinDriverObj:Attached_To_Driver_Name"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processWinProcessObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="@aslr_enabled">
                    <tr>
                        <td>ASLR Enabled</td>
                        <td><xsl:value-of select="@aslr_enabled"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@dep_enabled">
                    <tr>
                        <td>DEP Enabled</td>
                        <td><xsl:value-of select="@dep_enabled"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinProcessObj:Handle_List">
                    <tr>
                        <td>Open Handles</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="ProcessObj:Handle_List/WinHandleObj:Handle">
                                        <xsl:call-template name="processWinHandleObject"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinProcessObj:Priority">
                    <tr>
                        <td>Priority</td>
                        <td><xsl:value-of select="WinProcessObj:Priority"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinProcessObj:Section_List">
                    <tr>
                        <td>Memory Sections</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="WinProcessObj:Section_List/WinProcessObj:Memory_Section">
                                        <xsl:call-template name="processMemoryObject"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinProcessObj:Security_ID">
                    <tr>
                        <td>Security ID (SID)</td>
                        <td><xsl:value-of select="WinProcessObj:Security_ID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinProcessObj:Startup_Info">
                    <tr>
                        <td>Startup Info</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="WinProcessObj:Startup_Info">
                                        <xsl:call-template name="processStartupInfo"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinProcessObj:Security_Type">
                    <tr>
                        <td>Security ID (SID) Type</td>
                        <td><xsl:value-of select="WinProcessObj:Security_Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinProcessObj:Window_Title">
                    <tr>
                        <td>Window Title</td>
                        <td><xsl:value-of select="WinProcessObj:Window_Title"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processProcessObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="@is_hidden">
                    <tr>
                        <td>Is Hidden</td>
                        <td><xsl:value-of select="@is_hidden"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:PID">
                    <tr>
                        <td>Process ID (PID)</td>
                        <td><xsl:value-of select="ProcessObj:PID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Name">
                    <tr>
                        <td>Name</td>
                        <td><xsl:value-of select="ProcessObj:Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Path">
                    <tr>
                        <td>Path</td>
                        <td><xsl:value-of select="ProcessObj:Path"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Current_Working_Directory">
                    <tr>
                        <td>Current Working Directory</td>
                        <td><xsl:value-of select="ProcessObj:Current_Working_Directory"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Creation_Time">
                    <tr>
                        <td>Creation Date/Time</td>
                        <td><xsl:value-of select="ProcessObj:Creation_Time"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Parent_PID">
                    <tr>
                        <td>Parent PID</td>
                        <td><xsl:value-of select="ProcessObj:Parent_PID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Child_PID_List">
                    <tr>
                        <td>Children (PIDs)</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="ProcessObj:Child_PID_List/ProcessObj:Child_PID">
                                        <tr>
                                            <td>Child PID</td>
                                            <td><xsl:value-of select="."/></td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Argument_List">
                    <tr>
                        <td>Argument List</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="ProcessObj:Argument_List/ProcessObj:Argument">
                                        <tr>
                                            <td>Argument</td>
                                            <td><xsl:value-of select="."/></td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Environment_Variable_List">
                    <tr>
                        <td>Environment Variables</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="ProcessObj:Environment_Variable_List/Common:Environment_Variable">
                                        <xsl:call-template name="processEnvironmentVariable"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Image_Info">
                    <tr>
                        <td>Image Information</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="ProcessObj:Image_Info">
                                        <xsl:call-template name="processImageInfo"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Kernel_Time">
                    <tr>
                        <td>Kernel Time</td>
                        <td><xsl:value-of select="ProcessObj:Kernel_Time"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Port_List">
                    <tr>
                        <td>Open Ports</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="ProcessObj:Port_List/ProcessObj:Port">
                                        <xsl:call-template name="processPortObject"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Network_Connection_List">
                    <tr>
                        <td>Open Network Connections</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="ProcessObj:Network_Connection_List/ProcessObj:Network_Connection">
                                        <xsl:call-template name="processNetworkConnection"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Start_Time">
                    <tr>
                        <td>Start Time</td>
                        <td><xsl:value-of select="ProcessObj:Start_Time"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Status">
                    <tr>
                        <td>Status</td>
                        <td><xsl:value-of select="ProcessObj:Status"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:String_List">
                    <tr>
                        <td>Strings</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="ProcessObj:String_List/Common:String">
                                        <xsl:call-template name="processExtractedString"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:Username">
                    <tr>
                        <td>Username</td>
                        <td><xsl:value-of select="ProcessObj:Username"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="ProcessObj:User_Time">
                    <tr>
                        <td>User Time</td>
                        <td><xsl:value-of select="ProcessObj:User_Time"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processWinFileObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="WinFileObj:Filename_Accessed_Time">
                    <tr>
                        <td>Filename Accessed Time</td>
                        <td><xsl:value-of select="WinFileObj:Filename_Accessed_Time"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinFileObj:Filename_Created_Time">
                    <tr>
                        <td>Filename Created Time</td>
                        <td><xsl:value-of select="WinFileObj:Filename_Created_Time"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinFileObj:Filename_Modified_Time">
                    <tr>
                        <td>Filename Modified Time</td>
                        <td><xsl:value-of select="WinFileObj:Filename_Modified_Time"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinFileObj:Drive">
                    <tr>
                        <td>Drive Letter</td>
                        <td><xsl:value-of select="WinFileObj:Drive"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinFileObj:Security_ID">
                    <tr>
                        <td>Security ID (SID)</td>
                        <td><xsl:value-of select="WinFileObj:Security_ID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinFileObj:Security_Type">
                    <tr>
                        <td>Security Type</td>
                        <td><xsl:value-of select="WinFileObj:Security_Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinFileObj:Stream_List">
                    <tr>
                        <td>Stream List</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="WinFileObj:Stream_List/WinFileObj:Stream">
                                        <xsl:call-template name="processStream"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processWinRegistryKeyObject">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="WinRegistryKeyObj:Hive">
                    <tr>
                        <td>Hive</td>
                        <td><xsl:value-of select="WinRegistryKeyObj:Hive"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinRegistryKeyObj:Key">
                    <tr>
                        <td>Key</td>
                        <td><xsl:value-of select="WinRegistryKeyObj:Key"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinRegistryKeyObj:Number_Values">
                    <tr>
                        <td>Number of Values</td>
                        <td><xsl:value-of select="WinRegistryKeyObj:Number_Values"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinRegistryKeyObj:Modified_Time">
                    <tr>
                        <td>Modified Time</td>
                        <td><xsl:value-of select="WinRegistryKeyObj:Modified_Time"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinRegistryKeyObj:Creator_Username">
                    <tr>
                        <td>Creator Username</td>
                        <td><xsl:value-of select="WinRegistryKeyObj:Creator_Username"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinRegistryKeyObj:Number_Subkeys">
                    <tr>
                        <td>Number of Subkeys</td>
                        <td><xsl:value-of select="WinRegistryKeyObj:Number_Subkeys"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinRegistryKeyObj:Values">
                    <tr>
                        <td>Values</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="WinRegistryKeyObj:Values/WinRegistryKeyObj:Value">
                                        <xsl:call-template name="processWinRegistryValue"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinRegistryKeyObj:Handle_List">
                    <tr>
                        <td>Handle List</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="WinRegistryKeyObj:Handle_List/WinHandleObj:Handle">
                                        <xsl:call-template name="processWinHandleObject"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinRegistryKeyObj:Subkeys">
                    <tr>
                        <td>Subkeys</td>
                        <td>
                            <xsl:for-each select="WinRegistryKeyObj:Subkeys/WinRegistryKeyObj:Subkey">
                                <xsl:value-of select="."/> <br/>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="WinRegistryKeyObj:Byte_Runs">
                    <tr>
                        <td>Byte Runs</td>
                        <td>
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first-inner" />
                                </colgroup>
                                <tbody>
                                    <xsl:for-each select="WinRegistryKeyObj:Byte_Runs/Common:Byte_Run">
                                        <xsl:call-template name="processByteRun"/>
                                    </xsl:for-each>
                                </tbody>
                            </table> 
                        </td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processStream">
        <xsl:if test="WinFileObj:Name">
            <tr>
                <td>Name</td>
                <td><xsl:value-of select="WinFileObj:Name"></xsl:value-of></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinFileObj:Size_In_Bytes">
            <tr>
                <td>Size (bytes)</td>
                <td><xsl:value-of select="WinFileObj:Size_In_Bytes"></xsl:value-of></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Hash">
            <tr>
                <td>Hashes</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Hash">
                                <xsl:call-template name="processHash"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processHash">
        <tr>
            <xsl:choose>
                <xsl:when test="Common:Other_Type">
                    <td><xsl:value-of select="Common:Other_Type"/></td>
                </xsl:when>
                <xsl:otherwise>
                    <td><xsl:value-of select="Common:Type"/></td>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="Common:Fuzzy_Hash_Value">
                    <td><xsl:value-of select="Common:Fuzzy_Hash_Value"/></td>
                </xsl:when>
                <xsl:otherwise>
                    <td><xsl:value-of select="Common:Simple_Hash_Value"/></td>
                </xsl:otherwise>
            </xsl:choose>
        </tr>
    </xsl:template>
    
    <xsl:template name="processEnvironmentVariable">
        <xsl:if test="Common:Name">
            <tr>
                <td>Name</td>
                <td><xsl:value-of select="Common:Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Value">
            <tr>
                <td>Value</td>
                <td><xsl:value-of select="Common:Value"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processExtractedString">
        <xsl:if test="@encoding">
            <tr>
                <td>Encoding</td>
                <td><xsl:value-of select="@encoding"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:String_Value">
            <tr>
                <td>String Value</td>
                <td><xsl:value-of select="Common:String_Value"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Hashes">
            <tr>
                <td>Hashes</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Hashes/Common:Hash">
                                <xsl:call-template name="processHash"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Address">
            <tr>
                <td>Address</td>
                <td><xsl:value-of select="Common:Address"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Length">
            <tr>
                <td>Length (characters)</td>
                <td><xsl:value-of select="Common:Length"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Language">
            <tr>
                <td>Language</td>
                <td><xsl:value-of select="Common:Language"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:English_Translation">
            <tr>
                <td>English Translation</td>
                <td><xsl:value-of select="Common:English_Translation"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processNetworkConnection">
        <xsl:if test="ProcessObj:Creation_Time">
            <tr>
                <td>Creation Time</td>
                <td><xsl:value-of select="ProcessObj:Creation_Time"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="ProcessObj:Destination_IP_Address">
            <tr>
                <td>Destination IP Address</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="ProcessObj:Destination_IP_Address">
                                <xsl:call-template name="processAddressObject"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="ProcessObj:Destination_Port">
            <tr>
                <td>Destination Port</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="ProcessObj:Destination_Port">
                                <xsl:call-template name="processPortObject"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="ProcessObj:Source_IP_Address">
            <tr>
                <td>Source IP Address</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="ProcessObj:Source_IP_Address">
                                <xsl:call-template name="processAddressObject"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="ProcessObj:Source_Port">
            <tr>
                <td>Source Port</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="ProcessObj:Source_Port">
                                <xsl:call-template name="processPortObject"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="ProcessObj:TCP_State">
            <tr>
                <td>TCP State</td>
                <td><xsl:value-of select="ProcessObj:TCP_State"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processStartupInfo">
        <xsl:if test="WinProcessObj:lpDesktop">
            <tr>
                <td>lpDesktop</td>
                <td><xsl:value-of select="WinProcessObj:WinProcessObj"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:lpTitle">
            <tr>
                <td>lpTitle</td>
                <td><xsl:value-of select="WinProcessObj:lpTitle"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:dwX">
            <tr>
                <td>dwX</td>
                <td><xsl:value-of select="WinProcessObj:dwX"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:dwY">
            <tr>
                <td>dwY</td>
                <td><xsl:value-of select="WinProcessObj:dwY"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:dwXSize">
            <tr>
                <td>dwXSize</td>
                <td><xsl:value-of select="WinProcessObj:dwXSize"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:dwYSize">
            <tr>
                <td>dwYSize</td>
                <td><xsl:value-of select="WinProcessObj:dwYSize"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:dwXCountChars">
            <tr>
                <td>dwXCountChars</td>
                <td><xsl:value-of select="WinProcessObj:dwXCountChars"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:dwYCountChars">
            <tr>
                <td>dwYCountChars</td>
                <td><xsl:value-of select="WinProcessObj:dwYCountChars"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:dwFillAttribute">
            <tr>
                <td>dwFillAttribute</td>
                <td><xsl:value-of select="WinProcessObj:dwFillAttribute"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:dwFlags">
            <tr>
                <td>dwFlags</td>
                <td><xsl:value-of select="WinProcessObj:dwFlags"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:wShowWindow">
            <tr>
                <td>wShowWindow</td>
                <td><xsl:value-of select="WinProcessObj:wShowWindow"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:hStdInput">
            <tr>
                <td>hStdInput</td>
                <td><xsl:value-of select="WinProcessObj:hStdInput"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:hStdOutput">
            <tr>
                <td>hStdOutput</td>
                <td><xsl:value-of select="WinProcessObj:hStdOutput"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinProcessObj:hStdError">
            <tr>
                <td>hStdError</td>
                <td><xsl:value-of select="WinProcessObj:hStdError"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processImageInfo">
        <xsl:if test="ProcessObj:Command_Line">
            <tr>
                <td>Command Line</td>
                <td><xsl:value-of select="ProcessObj:Command_Line"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="ProcessObj:Current_Directory">
            <tr>
                <td>Current Directory</td>
                <td><xsl:value-of select="ProcessObj:Current_Directory"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="ProcessObj:Path">
            <tr>
                <td>Path</td>
                <td><xsl:value-of select="ProcessObj:Path"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processDigitalSignature">
        <xsl:if test="@signature_exists">
            <tr>
                <td>Signature Exists</td>
                <td><xsl:value-of select="@signature_exists"></xsl:value-of></td>
            </tr>
        </xsl:if>
        <xsl:if test="@signature_verified">
            <tr>
                <td>Signature Verified</td>
                <td><xsl:value-of select="@signature_verified"></xsl:value-of></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Certificate_Issuer">
            <tr>
                <td>Certificate Issuer</td>
                <td><xsl:value-of select="Common:Certificate_Issuer"></xsl:value-of></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Certificate_Subject">
            <tr>
                <td>Certificate Subject</td>
                <td><xsl:value-of select="Common:Certificate_Subject"></xsl:value-of></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Certificate_Description">
            <tr>
                <td>Certificate Description</td>
                <td><xsl:value-of select="Common:Certificate_Description"></xsl:value-of></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processPeakCodeEntropy">
        <xsl:if test="WinExecutableFileObj:Peak_Code_Entropy/WinExecutableFileObj:Value">
            <tr>
                <td>Value</td>
                <td><xsl:value-of select="WinExecutableFileObj:Peak_Code_Entropy/WinExecutableFileObj:Value"></xsl:value-of></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Peak_Code_Entropy/WinExecutableFileObj:Min">
            <tr>
                <td>Minimum</td>
                <td><xsl:value-of select="WinExecutableFileObj:Peak_Code_Entropy/WinExecutableFileObj:Min"></xsl:value-of></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Peak_Code_Entropy/WinExecutableFileObj:Max">
            <tr>
                <td>Maximum</td>
                <td><xsl:value-of select="WinExecutableFileObj:Peak_Code_Entropy/WinExecutableFileObj:Max"></xsl:value-of></td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processByteRun">
        <xsl:if test="Common:Offset">
            <tr>
                <td>Offset</td>
                <td><xsl:value-of select="Common:Offset"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:File_System_Offset">
            <tr>
                <td>File System Offset</td>
                <td><xsl:value-of select="Common:File_System_Offset"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Image_Offset">
            <tr>
                <td>Image Offset</td>
                <td><xsl:value-of select="Common:Image_Offset"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Length">
            <tr>
                <td>Length</td>
                <td><xsl:value-of select="Common:Length"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Byte_Run_Data">
            <tr>
                <td>Byte Run Data</td>
                <td><xsl:value-of select="Common:Byte_Run_Data"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Common:Hashes">
            <tr>
                <td>Hashes</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="Common:Hashes/Common:Hash">
                                <xsl:call-template name="processHash"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processPacker">
        <xsl:if test="FileObj:Name">
            <tr>
                <td>Packer Name</td>
                <td><xsl:value-of select="FileObj:Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="FileObj:Version">
            <tr>
                <td>Packer Version</td>
                <td><xsl:value-of select="FileObj:Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="FileObj:Type">
            <tr>
                <td>Packer Type</td>
                <td><xsl:value-of select="FileObj:Type"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="FileObj:PEiD">
            <tr>
                <td>PEiD</td>
                <td><xsl:value-of select="FileObj:PEiD"></xsl:value-of></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processWinRegistryValue">
        <xsl:if test="WinRegistryKeyObj:Name">
            <tr>
                <td>Name</td>
                <td><xsl:value-of select="WinRegistryKeyObj:Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinRegistryKeyObj:Data">
            <tr>
                <td>Data</td>
                <td><xsl:value-of select="WinRegistryKeyObj:Data"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinRegistryKeyObj:Datatype">
            <tr>
                <td>Datatype</td>
                <td><xsl:value-of select="WinRegistryKeyObj:Datatype"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinRegistryKeyObj:Byte_Runs">
            <tr>
                <td>Byte Runs</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinRegistryKeyObj:Byte_Runes/Common:Byte_Run">
                                <xsl:call-template name="processByteRun"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processEPJumpCode">
        <xsl:if test="WinExecutableFileObj:Depth">
            <tr>
                <td>Depth</td>
                <td><xsl:value-of select="WinExecutableFileObj:Depth"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Opcodes">
            <tr>
                <td>Opcodes</td>
                <td><xsl:value-of select="WinExecutableFileObj:Opcodes"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processPEAttributes">
        <xsl:if test="WinExecutableFileObj:Base_Address">
            <tr>
                <td>Base Address</td>
                <td><xsl:value-of select="WinExecutableFileObj:Base_Address"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Extraneous_Bytes">
            <tr>
                <td>Extraneous Bytes</td>
                <td><xsl:value-of select="WinExecutableFileObj:Extraneous_Bytes"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Digital_Signature">
            <tr>
                <td>Digital Signature</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Digital_Signature">
                                <xsl:call-template name="processDigitalSignature"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:EP_Jump_Codes">
            <tr>
                <td>EP Jump Codes</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:EP_Jump_Codes">
                                <xsl:call-template name="processEPJumpCode"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:PE_Timestamp">
            <tr>
                <td>PE Timestamp</td>
                <td><xsl:value-of select="WinExecutableFileObj:PE_Timestamp"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Subsystem">
            <tr>
                <td>Subsystem</td>
                <td><xsl:value-of select="WinExecutableFileObj:Subsystem"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Type">
            <tr>
                <td>Type</td>
                <td><xsl:value-of select="WinExecutableFileObj:Type"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Imports">
            <tr>
                <td>Imports</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Imports/WinExecutableFileObj:Import">
                                <xsl:call-template name="processPEImport"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Exports">
            <tr>
                <td>Exports</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Exports">
                                <xsl:call-template name="processPEExports"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Headers">
            <tr>
                <td>PE Headers</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Headers">
                                <xsl:call-template name="processPEHeaders"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processPEHeaders">
        <xsl:if test="WinExecutableFileObj:File_Name">
            <tr>
                <td>Signature</td>
                <td><xsl:value-of select="WinExecutableFileObj:Signature"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:DOS_Header">
            <tr>
                <td>DOS Header</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:DOS_Header">
                                <xsl:call-template name="processDOSHeader"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:File_Header">
            <tr>
                <td>File Header</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:File_Header">
                                <xsl:call-template name="processPEFileHeader"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Optional_Header">
            <tr>
                <td>Optional Header</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Optional_Header">
                                <xsl:call-template name="processPEOptionalHeader"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Entropy">
            <tr>
                <td>Entropy</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Entropy">
                                <xsl:call-template name="processEntropy"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Hashes">
            <tr>
                <td>Hashes</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Hashes/Common:Hash">
                                <xsl:call-template name="processHash"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processEntropy">
        <xsl:if test="WinExecutableFileObj:Value">
            <tr>
                <td>Value</td>
                <td><xsl:value-of select="WinExecutableFileObj:Value"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Min">
            <tr>
                <td>Minimum</td>
                <td><xsl:value-of select="WinExecutableFileObj:Min"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Max">
            <tr>
                <td>Maximum</td>
                <td><xsl:value-of select="WinExecutableFileObj:Max"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processDOSHeader">
        <xsl:if test="WinExecutableFileObj:e_magic">
            <tr>
                <td>e_magic</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_magic"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_cblp">
            <tr>
                <td>e_cblp</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_cblp"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_cp">
            <tr>
                <td>e_cp</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_cp"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_crlc">
            <tr>
                <td>e_crlc</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_crlc"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_cparhdr">
            <tr>
                <td>e_cparhdr</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_cparhdr"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_minalloc">
            <tr>
                <td>e_minalloc</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_minalloc"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_maxalloc">
            <tr>
                <td>e_maxalloc</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_maxalloc"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_ss">
            <tr>
                <td>e_ss</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_ss"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_sp">
            <tr>
                <td>e_sp</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_sp"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_csum">
            <tr>
                <td>e_csum</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_csum"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_ip">
            <tr>
                <td>e_ip</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_ip"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_cs">
            <tr>
                <td>e_cs</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_cs"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_lfarlc">
            <tr>
                <td>e_lfarlc</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_lfarlc"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_ovro">
            <tr>
                <td>e_ovro</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_ovro"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:reserved1">
            <xsl:for-each select="WinExecutableFileObj:reserved1">
                <tr>
                    <td>reserved1</td>
                    <td><xsl:value-of select="."/></td>
                </tr>
            </xsl:for-each>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_oemid">
            <tr>
                <td>e_oemid</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_oemid"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_oeminfo">
            <tr>
                <td>e_oeminfo</td>
                <td><xsl:value-of select="WinExecutableFileObj:e_oeminfo"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:reserved2">
            <tr>
                <td>reserved2</td>
                <td><xsl:value-of select="WinExecutableFileObj:reserved2"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:e_lfanew">
            <tr>
                <td>e_lfanew</td>
                <td><xsl:value-of select="WinExecutableFileObj:reserved2"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Hashes">
            <tr>
                <td>Hashes</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Hashes/Common:Hash">
                                <xsl:call-template name="processHash"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processPEFileHeader">
        <xsl:if test="WinExecutableFileObj:Machine">
            <tr>
                <td>Machine</td>
                <td><xsl:value-of select="WinExecutableFileObj:Machine"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Number_Of_Sections">
            <tr>
                <td>Number of Sections</td>
                <td><xsl:value-of select="WinExecutableFileObj:Number_Of_Sections"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Time_Date_Stamp">
            <tr>
                <td>Time/Date Stamp</td>
                <td><xsl:value-of select="WinExecutableFileObj:Time_Date_Stamp"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Pointer_To_Symbol_Table">
            <tr>
                <td>Pointer to Symbol Table</td>
                <td><xsl:value-of select="WinExecutableFileObj:Pointer_To_Symbol_Table"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Number_Of_Symbols">
            <tr>
                <td>Number of Symbols</td>
                <td><xsl:value-of select="WinExecutableFileObj:Number_Of_Symbols"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size_Of_Optional_Header">
            <tr>
                <td>Size of Optional Header</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size_Of_Optional_Header"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Characteristics">
            <tr>
                <td>Characteristics</td>
                <td><xsl:value-of select="WinExecutableFileObj:Characteristics"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Hashes">
            <tr>
                <td>Hashes</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Hashes/Common:Hash">
                                <xsl:call-template name="processHash"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processPEOptionalHeader">
        <xsl:if test="WinExecutableFileObj:Magic">
            <tr>
                <td>Magic</td>
                <td><xsl:value-of select="WinExecutableFileObj:Magic"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Major_Linker_Version">
            <tr>
                <td>Major Linker Version</td>
                <td><xsl:value-of select="WinExecutableFileObj:Major_Linker_Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Minor_Linker_Version">
            <tr>
                <td>Minor Linker Version</td>
                <td><xsl:value-of select="WinExecutableFileObj:Minor_Linker_Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size_Of_Code">
            <tr>
                <td>Size of Code</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size_Of_Code"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size_Of_Initialized_Data">
            <tr>
                <td>Size of Initialized Data</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size_Of_Initialized_Data"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size_Of_Uninitialized_Data">
            <tr>
                <td>Size of Uninitialized Data</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size_Of_Uninitialized_Data"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Address_Of_Entry_Point">
            <tr>
                <td>Address of Entry Point</td>
                <td><xsl:value-of select="WinExecutableFileObj:Address_Of_Entry_Point"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Base_Of_Code">
            <tr>
                <td>Base of Code</td>
                <td><xsl:value-of select="WinExecutableFileObj:Base_Of_Code"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Base_Of_Data">
            <tr>
                <td>Base of Data</td>
                <td><xsl:value-of select="WinExecutableFileObj:Base_Of_Data"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Image_Base">
            <tr>
                <td>Image Base</td>
                <td><xsl:value-of select="WinExecutableFileObj:Image_Base"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Section_Alignment">
            <tr>
                <td>Section Alignment</td>
                <td><xsl:value-of select="WinExecutableFileObj:Section_Alignment"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:File_Alignment">
            <tr>
                <td>File Alignment</td>
                <td><xsl:value-of select="WinExecutableFileObj:File_Alignment"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Major_OS_Version">
            <tr>
                <td>Major OS Version</td>
                <td><xsl:value-of select="WinExecutableFileObj:Major_OS_Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Minor_OS_Version">
            <tr>
                <td>Minor OS Version</td>
                <td><xsl:value-of select="WinExecutableFileObj:Minor_OS_Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Major_Image_Version">
            <tr>
                <td>Major Image Version</td>
                <td><xsl:value-of select="WinExecutableFileObj:Major_Image_Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Minor_Image_Version">
            <tr>
                <td>Minor Image Version</td>
                <td><xsl:value-of select="WinExecutableFileObj:Minor_Image_Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Major_Subsystem_Version">
            <tr>
                <td>Major Subsystem Version</td>
                <td><xsl:value-of select="WinExecutableFileObj:Major_Subsystem_Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Minor_Subsystem_Version">
            <tr>
                <td>Minor Subsystem Version</td>
                <td><xsl:value-of select="WinExecutableFileObj:Minor_Subsystem_Version"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Win32_Version_Value">
            <tr>
                <td>Win32 Version Value</td>
                <td><xsl:value-of select="WinExecutableFileObj:Win32_Version_Value"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size_Of_Image">
            <tr>
                <td>Size of Image</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size_Of_Image"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size_Of_Headers">
            <tr>
                <td>Size of Headers</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size_Of_Headers"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Checksum">
            <tr>
                <td>Checksum</td>
                <td><xsl:value-of select="WinExecutableFileObj:Checksum"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Subsystem">
            <tr>
                <td>Subsystem</td>
                <td><xsl:value-of select="WinExecutableFileObj:Subsystem"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:DLL_Characteristics">
            <tr>
                <td>DLL Characteristics</td>
                <td><xsl:value-of select="WinExecutableFileObj:DLL_Characteristics"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size_Of_Stack_Reserve">
            <tr>
                <td>Size of Stack Reserve</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size_Of_Stack_Reserve"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size_Of_Stack_Commit">
            <tr>
                <td>Size of Stack Commit</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size_Of_Stack_Commit"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size_Of_Heap_Reserve">
            <tr>
                <td>Size of Heap Reserve</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size_Of_Heap_Reserve"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size_Of_Heap_Commit">
            <tr>
                <td>Size of Heap Commit</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size_Of_Heap_Commit"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Loader_Flags">
            <tr>
                <td>Loader Flags</td>
                <td><xsl:value-of select="WinExecutableFileObj:Loader_Flags"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Number_Of_Rva_And_Sizes">
            <tr>
                <td>Number of RVA and Sizes</td>
                <td><xsl:value-of select="WinExecutableFileObj:Number_Of_Rva_And_Sizes"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Data_Directory">
            <tr>
                <td>Data Directory</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Data_Directory">
                                <xsl:call-template name="processDataDirectory"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Hashes">
            <tr>
                <td>Hashes</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Hashes/Common:Hash">
                                <xsl:call-template name="processHash"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processDataDirectory">
        <xsl:if test="WinExecutableFileObj:Export_Table">
            <tr>
                <td>Export Table</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Export_Table">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr> 
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Import_Table">
            <tr>
                <td>Import Table</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Import_Table">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr> 
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Resource_Table">
            <tr>
                <td>Resource Table</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Resource_Table">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Exception_Table">
            <tr>
                <td>Exception Table</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Exception_Table">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Certificate_Table">
            <tr>
                <td>Certificate Table</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Certificate_Table">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Base_Relocation_Table">
            <tr>
                <td>Base Relocation Table</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Base_Relocation_Table">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr> 
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Debug">
            <tr>
                <td>Debug</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Debug">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr> 
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Architecture">
            <tr>
                <td>Architecture</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Architecture">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Global_Ptr">
            <tr>
                <td>Global Pointer</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Global_Ptr">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:TLS_Table">
            <tr>
                <td>TLS Table</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:TLS_Table">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr> 
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Load_Config_Table">
            <tr>
                <td>Load Config Table</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Load_Config_Table">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr> 
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Bound_Import">
            <tr>
                <td>Bound Import Table</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Bound_Import">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Import_Address_Table">
            <tr>
                <td>Import Address Table</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Import_Address_Table">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr> 
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Delay_Import_Descriptor">
            <tr>
                <td>Delay Import Descriptor</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Delay_Import_Descriptor">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr> 
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:CLR_Runtime_Header">
            <tr>
                <td>CLR Runtime Header</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:CLR_Runtime_Header">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr> 
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Reserved">
            <tr>
                <td>Reserved</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Reserved">
                                <xsl:call-template name="processPEDataDirectoryStruct"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr> 
            <tr bgcolor="#FFFFFF">
                <td></td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processPEDataDirectoryStruct">
        <xsl:if test="WinExecutableFileObj:Virtual_Address">
            <tr>
                <td>Virtual Address</td>
                <td><xsl:value-of select="WinExecutableFileObj:Virtual_Address"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Size">
            <tr>
                <td>Size (bytes)</td>
                <td><xsl:value-of select="WinExecutableFileObj:Size"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processPEImport">
        <xsl:if test="WinExecutableFileObj:File_Name">
            <tr>
                <td>File Name</td>
                <td><xsl:value-of select="WinExecutableFileObj:File_Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Virtual_Address">
            <tr>
                <td>Virtual Address</td>
                <td><xsl:value-of select="WinExecutableFileObj:Virtual_Address"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="@delay_load">
            <tr>
                <td>Delay Load</td>
                <td><xsl:value-of select="@delay_load"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="@initially_visible">
            <tr>
                <td>Initially Visible</td>
                <td><xsl:value-of select="@initially_visible"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Imported_Functions">
            <tr>
                <td>Imported Functions</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Imported_Functions/WinExecutableFileObj:Imported_Function">
                                <xsl:call-template name="processPEImportedFunction"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processPEExports">
        <xsl:if test="WinExecutableFileObj:Exports_Time_Stamp">
            <tr>
                <td>Exports Time Stamp</td>
                <td><xsl:value-of select="WinExecutableFileObj:Exports_Time_Stamp"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Number_Of_Addresses">
            <tr>
                <td>Number of Addresses</td>
                <td><xsl:value-of select="WinExecutableFileObj:Number_Of_Addresses"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Number_Of_Names">
            <tr>
                <td>Number of Names</td>
                <td><xsl:value-of select="WinExecutableFileObj:Number_Of_Names"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Exported_Functions">
            <tr>
                <td>Exported Functions</td>
                <td>
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first-inner-inner-inner" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="WinExecutableFileObj:Exported_Functions/WinExecutableFileObj:Exported_Function">
                                <xsl:call-template name="processPEExportedFunction"/>
                            </xsl:for-each>
                        </tbody>
                    </table> 
                </td>
            </tr>  
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processPEExportedFunction">
        <xsl:if test="WinExecutableFileObj:Function_Name">
            <tr>
                <td>Function Name</td>
                <td><xsl:value-of select="WinExecutableFileObj:Function_Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Entry_Point">
            <tr>
                <td>Entry Point</td>
                <td><xsl:value-of select="WinExecutableFileObj:Entry_Point"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Ordinal">
            <tr>
                <td>Ordinal</td>
                <td><xsl:value-of select="WinExecutableFileObj:Ordinal"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processPEImportedFunction">
        <xsl:if test="WinExecutableFileObj:Function_Name">
            <tr>
                <td>Function Name</td>
                <td><xsl:value-of select="WinExecutableFileObj:Function_Name"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Hint">
            <tr>
                <td>Hint</td>
                <td><xsl:value-of select="WinExecutableFileObj:Hint"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Ordinal">
            <tr>
                <td>Ordinal</td>
                <td><xsl:value-of select="WinExecutableFileObj:Ordinal"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Bound">
            <tr>
                <td>Bound</td>
                <td><xsl:value-of select="WinExecutableFileObj:Bound"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="WinExecutableFileObj:Virtual_Address">
            <tr>
                <td>Virtual Address</td>
                <td><xsl:value-of select="WinExecutableFileObj:Virtual_Address"/></td>
            </tr>
        </xsl:if>
        <!-- Spacer for repeated entries -->
        <tr bgcolor="#FFFFFF">
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template name="processDataDirectoryStruct">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <tr>
                    <td>Virtual Address</td>
                    <td><xsl:value-of select="@Virtual_Address"/></td>
                </tr>
                <tr>
                    <td>Size</td>
                    <td><xsl:value-of select="@Size"/></td>
                </tr>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processStructuredTextGroup">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="Common:Text_Title">
                    <tr>
                        <td>Title</td>
                        <td><xsl:value-of select="Common:Text_Title"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="Common:Text">
                    <tr>
                        <td>Text</td>
                        <td><xsl:value-of select="Common:Text"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="Common:Code_Example_Language">
                    <tr>
                        <td>Code Example Language</td>
                        <td><xsl:value-of select="Common:Code_Example_Language"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="Common:Code">
                    <tr>
                        <td>Code</td>
                        <td><xsl:value-of select="Common:Code"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> 
    </xsl:template>
</xsl:stylesheet>
