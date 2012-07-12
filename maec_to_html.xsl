<?xml version="1.0" encoding="UTF-8"?>
<!--
MAEC XML to HTML transform v0.9
Compatible with MAEC Schema v1.1 output

Updated 8/19/2011
ikirillov@mitre.org
-->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:maec="http://maec.mitre.org/XMLSchema/maec-core-1"
    xmlns:metadata="http://xml/metadataSharing.xsd">
    
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
                    color: #669;
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
                    #object_label {
                    width:200px;
                    background: #e8edff;
                    border-top: 1px solid #ccc;
                    border-left: 1px solid #ccc;
                    border-right: 1px solid #ccc;
                    padding: 5px;
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
                        <xsl:if test="//maec:Pools/maec:Action_Collection_Pool">
                            <h2><a name="actions">Actions</a></h2>
                            <div id="content">
                                <xsl:call-template name="processActions"/>
                            </div>
                        </xsl:if>
                        <h2><a name="objects">Objects</a></h2>
                        <div id="content">
                            <xsl:call-template name="processObjects"/>
                            <xsl:call-template name="processAllObjects"/>
                        </div>
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
                 <table id="hor-minimalist-a" width="100%">
                     <thead>
                         <tr>
                             <th scope="col">Analysis Method</th>
                             <th scope="col">Start Datetime</th>
                             <th scope="col">Complete Datetime</th>
                             <th scope="col">Update Datetime</th>
                         </tr>
                     </thead>
                     <TR>
                         <xsl:choose>
                             <xsl:when test="@analysis_method">
                                 <TD><xsl:value-of select="@analysis_method"/></TD>
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
                             <xsl:when test="@update_datetime">
                                 <TD><xsl:value-of select="@update_datetime"/></TD>
                             </xsl:when>
                             <xsl:otherwise>
                                 <TD>N/A</TD>
                             </xsl:otherwise>
                         </xsl:choose>
                     </TR>
                 </table>
                 <br/>
                 
                 <xsl:if test="maec:Description">
                     <h3>Description</h3><br/>
                     <div id="section">
                         <xsl:for-each select="maec:Description">
                             <xsl:call-template name="processDescription"/>
                         </xsl:for-each>
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
                                 <xsl:for-each select="maec:Analysts/maec:Analyst">
                                     <tr>
                                         <td>Name</td>
                                         <td><xsl:value-of select="."/></td>
                                     </tr> 
                                 </xsl:for-each>
                             </tbody>
                         </table><br/>
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
                                 <xsl:if test="maec:Source/maec:Organization_Name">
                                     <tr>
                                         <td>Organization Name</td>
                                         <td><xsl:value-of select="maec:Source/maec:Organization_Name"/></td>
                                     </tr>
                                 </xsl:if>
                                 <xsl:if test="maec:Source/maec:POC">
                                     <tr>
                                         <td>Point of Contact</td>
                                         <td><xsl:value-of select="maec:Source/maec:POC"/></td>
                                     </tr>
                                 </xsl:if>
                                 <xsl:if test="maec:Source/maec:URI">
                                     <tr>
                                         <td>URL</td>
                                         <td><xsl:value-of select="maec:Source/maec:URI/metadata:uriString"/></td>
                                     </tr>
                                 </xsl:if>
                             </tbody>
                         </table> <br/>
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
                 
                 <xsl:if test="maec:Tools_Used">
                     <h3>Tools Used</h3><br/>
                         <xsl:for-each select="maec:Tools_Used/maec:Tool">
                             <b>Tool</b>
                             <div id="section">
                             <table id="one-column-emphasis">
                                 <colgroup>
                                     <col class="oce-first" />
                                 </colgroup>
                                 <tbody>
                                     <tr>
                                         <td>Name</td>
                                         <td><xsl:value-of select="maec:Name"/></td>
                                     </tr>
                                     <xsl:if test="maec:Version">
                                         <tr>
                                             <td>Version</td>
                                             <td><xsl:value-of select="maec:Version"/></td>
                                         </tr>
                                     </xsl:if>
                                     <xsl:if test="maec:Vendor">
                                         <tr>
                                             <td>Vendor</td>
                                             <td><xsl:value-of select="maec:Vendor"/></td>
                                         </tr>
                                     </xsl:if>
                                     <xsl:if test="maec:Organization">
                                         <tr>
                                             <td>Organization</td>
                                             <td><xsl:value-of select="maec:Organization"/></td>
                                         </tr>
                                     </xsl:if>
                                 </tbody>
                             </table> <br/>
                             </div>
                         </xsl:for-each>
                 </xsl:if>
                 
                 <xsl:if test="maec:Notes">
                     <h3>Notes</h3><br/>
                     <div id="section">
                         <xsl:for-each select="maec:Notes/maec:Note">
                             <li><xsl:value-of select="."/></li>
                         </xsl:for-each> <br/>
                     </div>
                 </xsl:if>
                 
                     
                 <h3>Subject(s)</h3><br/>
                    <xsl:for-each select="maec:Subject">
                        <xsl:for-each select="key('objectID',maec:Object_Reference/@object_id)">
                            <xsl:call-template name="processObject"/><br/>
                        </xsl:for-each>
                        <xsl:for-each select="maec:Object">
                            <xsl:call-template name="processObject"/><br/>
                        </xsl:for-each>
                    </xsl:for-each>
                </div>
            </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="processActions">
            <xsl:for-each select="//maec:Actions">
                <xsl:variable name="imgVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <div id="actionsHeader" style="cursor: pointer;" onclick="toggleDiv('{concat(replace(@name,' ','_'),'_Header')}', '{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>All Actions</b>
                </div>
                <div id="{concat(replace(@name,' ','_'),'_Header')}" style="overflow:hidden; display:none;">
                    <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                        <COLGROUP>
                            <COL width="60%"/>
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
                                    Ordinal Position
                                </TH>
                                <TH class="header">
                                    Successful
                                </TH>
                                <TH class="header">
                                    Timestamp
                                </TH>
                            </TR>
                        </THEAD>
                        <TBODY>
                            <xsl:for-each select="//maec:Actions/maec:Action">
                                <xsl:sort select="@type" order="ascending"/>
                                <xsl:choose>
                                    <xsl:when test="position() mod 2">
                                        <xsl:call-template name="processActionOdd"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="processActionEven"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </TBODY>
                    </TABLE>    
                </div>
            </xsl:for-each>
        
            <xsl:for-each select="//maec:Pools/maec:Action_Collection_Pool/maec:Action_Collection">
                <xsl:variable name="imgVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <div id="actionHeader" style="cursor: pointer;" onclick="toggleDiv('{concat(replace(@name,' ','_'),'_Header')}', '{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b><xsl:value-of select="@name"/></b>
                           </div>
                           <div id="{concat(replace(@name,' ','_'),'_Header')}" style="overflow:hidden; display:none;">
                                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                                    <COLGROUP>
                                        <COL width="60%"/>
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
                                                Ordinal Position
                                            </TH>
                                            <TH class="header">
                                                Successful
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
                                                    <xsl:call-template name="processActionOdd"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:call-template name="processActionEven"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </TBODY>
                                </TABLE>    
                            </div>
            </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="processActionEven">
        <TR class="even">
            <TD>
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="fileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <xsl:value-of select="@action_name"/>
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <xsl:if test="maec:Description">
                        <br/>
                        <div id="section">
                                    <span style="font-weight:bold;">Description</span> 
                                    <h3>Description</h3><br/>
                                    <xsl:for-each select="maec:Description">
                                        <xsl:call-template name="processDescription"/>
                                    </xsl:for-each>
                        </div>
                    </xsl:if>
                    
                    <!--<xsl:if test="maec:Action_Initiator">
                        <div id="section">
                        <TR class="expand-child even">
                        <TD colspan="6" style="display: none; border-style:solid; border-width:1px; border-color:#808080">
                        <span style="font-weight:bold;">Initiator</span> 
                        
                        <xsl:if test="maec:Action_Initiator/@type">
                        <table id="one-column-emphasis">
                        <colgroup>
                        <col class="oce-first" />
                        </colgroup>
                        <tbody>
                        <tr>
                        <td>Type</td>
                        <td><xsl:value-of select="maec:Action_Initiator/@type"/></td>
                        </tr>
                        </tbody>
                        </table><br/>
                        </xsl:if>
                        <xsl:for-each select="key('objectID',maec:Action_Initiator/maec:Initiator_Object/@object_id)">
                        <xsl:call-template name="processObject"/><br/>
                        </xsl:for-each>
                        </TD>
                        </TR>
                        </div>
                        </xsl:if>-->
                    
                    <xsl:if test="maec:Action_Implementation">
                        <br/>
                        <xsl:for-each select="maec:Action_Implementation">      
                               <xsl:call-template name="processActionImp"/>
                        </xsl:for-each>
                    </xsl:if>   
                    
                    <xsl:if test="maec:Objects">
                        <br/>
                        <h3>Objects</h3><br/>
                        <xsl:for-each select="maec:Objects/maec:Object_Reference">
                            <xsl:for-each select="key('objectID',@object_id)">
                                <xsl:call-template name="processObjectFull"/><br/>
                            </xsl:for-each>
                            <xsl:for-each select="maec:Objects/maec:Object">
                                <xsl:call-template name="processObjectFull"/><br/>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:if>
                    
                    <xsl:if test="maec:Effects">
                        <br/>
                        <xsl:for-each select="maec:Effects/maec:Effect">
                                <xsl:call-template name="processEffect"/><br/>
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
                <xsl:when test="@successful">
                    <xsl:value-of select="@successful"/>
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
        </TR>
    </xsl:template>
    
    <xsl:template name="processActionOdd">
        <TR class="odd">
            <TD>
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="fileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <xsl:value-of select="@action_name"/>
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <xsl:if test="maec:Description">
                        <div id="section">
                            <span style="font-weight:bold;">Description</span> 
                            <h3>Description</h3><br/>
                            <xsl:for-each select="maec:Description">
                                <xsl:call-template name="processDescription"/>
                            </xsl:for-each>
                        </div>
                    </xsl:if>
                    
                    <!--<xsl:if test="maec:Action_Initiator">
                        <div id="section">
                        <TR class="expand-child even">
                        <TD colspan="6" style="display: none; border-style:solid; border-width:1px; border-color:#808080">
                        <span style="font-weight:bold;">Initiator</span> 
                        
                        <xsl:if test="maec:Action_Initiator/@type">
                        <table id="one-column-emphasis">
                        <colgroup>
                        <col class="oce-first" />
                        </colgroup>
                        <tbody>
                        <tr>
                        <td>Type</td>
                        <td><xsl:value-of select="maec:Action_Initiator/@type"/></td>
                        </tr>
                        </tbody>
                        </table><br/>
                        </xsl:if>
                        <xsl:for-each select="key('objectID',maec:Action_Initiator/maec:Initiator_Object/@object_id)">
                        <xsl:call-template name="processObject"/><br/>
                        </xsl:for-each>
                        </TD>
                        </TR>
                        </div>
                        </xsl:if>-->
                    
                    <xsl:if test="maec:Action_Implementation">
                        <xsl:for-each select="maec:Action_Implementation">      
                            <xsl:call-template name="processActionImp"/>
                        </xsl:for-each>
                    </xsl:if>   
                    
                    <xsl:if test="maec:Objects">
                        <h3>Objects</h3><br/>
                        <xsl:for-each select="maec:Objects/maec:Object_Reference">
                            <xsl:for-each select="key('objectID',@object_id)">
                                <xsl:call-template name="processObjectFull"/><br/>
                            </xsl:for-each>
                            <xsl:for-each select="maec:Objects/maec:Object">
                                <xsl:call-template name="processObjectFull"/><br/>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:if>
                    
                    <xsl:if test="maec:Effects">
                        <xsl:for-each select="maec:Effects/maec:Effect">
                            <xsl:call-template name="processEffect"/><br/>
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
                    <xsl:when test="@successful">
                        <xsl:value-of select="@successful"/>
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
        </TR>
    </xsl:template>
    
    <xsl:template name="processEffect">
            <xsl:if test="maec:Description">
                <div id="section">
                    <span style="font-weight:bold;">Description</span> <br/>
                    <xsl:for-each select="maec:Description">
                        <xsl:call-template name="processDescription"/>
                    </xsl:for-each>
                </div>
            </xsl:if>
            <xsl:if test="maec:Affected_Objects">
                <span style="font-weight:bold;">Affected Objects</span> <br/><br/>
                <xsl:for-each select="maec:Affected_Objects/maec:Affected_Object">
                    <xsl:if test="@effect_type">
                        <span style="font-style:italic;"> <xsl:value-of select="replace(@effect_type,'_',' ')"/></span>
                    </xsl:if>
                    <xsl:for-each select="maec:Object_Reference">
                        <xsl:for-each select="key('objectID',@object_id)">
                            <xsl:call-template name="processObjectFull"/><br/>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="maec:Constituent_Effects">
                <span style="font-weight:bold;">Constituent Effects</span><br/>
                <xsl:for-each select="maec:Constituent_Effects/maec:Effect_Reference">
                    <xsl:for-each select="key('effectID',@effect_id)">
                        <xsl:call-template name="processEffect"/><br/>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="maec:Vulnerability_Exploit">
                <span style="font-weight:bold;">Exploited Vulnerability</span><br/>
                <table id="one-column-emphasis">
                    <colgroup>
                        <col class="oce-first" />
                    </colgroup>
                    <tbody>
                        <xsl:if test="maec:Vulnerability_Exploit/@vulnerability_type">
                            <tr>
                                <td>Vulnerability Type</td>
                                <td><xsl:value-of select="maec:Vulnerability_Exploit/@vulnerability_type"/></td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="maec:Vulnerability_Exploit/maec:Known_Exploit/@cve_id">
                            <tr>
                                <td>CVE ID</td>
                                <td><xsl:value-of select="maec:Vulnerability_Exploit/maec:Known_Exploit/@cve_id"/></td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="maec:Vulnerability_Exploit/maec:Known_Exploit/@cve_id">
                            <tr>
                                <td>CVE Description</td>
                                <td><xsl:value-of select="maec:Vulnerability_Exploit/maec:Known_Exploit/maec:CVE_Description"/></td>
                            </tr>
                        </xsl:if>
                    </tbody>
                </table><br/>
            </xsl:if>
    </xsl:template>
    
    <xsl:template name="processFileActionAttributes">
        <b>File Action Attributes</b>
        <div id="section">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:Existing_File_Name">
                        <tr>
                            <td>Existing File Name</td>
                            <td><xsl:value-of select="maec:Existing_File_Name"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Destination_File_Name">
                        <tr>
                            <td>Destination File Name</td>
                            <td><xsl:value-of select="maec:Destination_File_Name"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Access_Mode">
                        <tr>
                            <td>Access Mode</td>
                            <td><xsl:value-of select="maec:Access_Mode"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Flags">
                        <tr>
                            <td>Flags</td>
                            <td><xsl:value-of select="maec:Flags"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Open_Mode">
                        <tr>
                            <td>Open Mode</td>
                            <td><xsl:value-of select="maec:Open_Mode"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:File_Attributes">
                        <tr>
                            <td>File Att</td>
                            <td><xsl:value-of select="maec:Open_Mode"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table><br/>
        </div>
    </xsl:template>
    
    <xsl:template name="processIPCActionAttributes">
        <b>IPC Action Attributes</b>
        <div id="section">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:Initial_Owner">
                        <tr>
                            <td>Initial Owner</td>
                            <td><xsl:value-of select="maec:Initial_Owner"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Thread_ID">
                        <tr>
                            <td>Thread ID</td>
                            <td><xsl:value-of select="maec:Thread_ID"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Target_PID">
                        <tr>
                            <td>Target Process ID (PID)</td>
                            <td><xsl:value-of select="maec:Target_PID"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Start_Address">
                        <tr>
                            <td>Start Address</td>
                            <td><xsl:value-of select="maec:Start_Address"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table><br/>
        </div>
    </xsl:template>
    
    <xsl:template name="processProcessActionAttributes">
        <b>Process Action Attributes</b>
        <div id="section">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:Process_Base_Address">
                        <tr>
                            <td>Process Base Address</td>
                            <td><xsl:value-of select="maec:Process_Base_Address"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Thread_ID">
                        <tr>
                            <td>Thread ID</td>
                            <td><xsl:value-of select="maec:Thread_ID"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Start_Address">
                        <tr>
                            <td>Start Address</td>
                            <td><xsl:value-of select="maec:Start_Address"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Creation_Flags">
                        <tr>
                            <td>Creation Flags</td>
                            <td><xsl:value-of select="maec:Creation_Flags"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:User_Name">
                        <tr>
                            <td>User Name</td>
                            <td><xsl:value-of select="maec:User_Name"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Target_PID">
                        <tr>
                            <td>Target Process ID (PID)</td>
                            <td><xsl:value-of select="maec:Target_PID"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table><br/>
        </div>
    </xsl:template>
    
    <xsl:template name="processMemoryActionAttributes">
        <b>Memory Action Attributes</b>
        <div id="section">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:Start_Address">
                        <tr>
                            <td>Start Address</td>
                            <td><xsl:value-of select="maec:Start_Address"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Source_Address">
                        <tr>
                            <td>Source Address</td>
                            <td><xsl:value-of select="maec:Source_Address"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Destination_Address">
                        <tr>
                            <td>Destination Address</td>
                            <td><xsl:value-of select="maec:Destination_Address"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Page_Base_Address">
                        <tr>
                            <td>Destination Address</td>
                            <td><xsl:value-of select="maec:Page_Base_Address"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Target_PID">
                        <tr>
                            <td>Target Process ID (PID)</td>
                            <td><xsl:value-of select="maec:Target_PID"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Requested_Address">
                        <tr>
                            <td>Requested Address</td>
                            <td><xsl:value-of select="maec:Requested_Address"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table><br/>
        </div>
    </xsl:template>
    
    <xsl:template name="processRegistryActionAttributes">
        <b>Registry Action Attributes</b>
        <div id="section">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:Enumerated_Subkeys">
                        <tr>
                            <td>Enumerated Subkeys</td>
                            <td><xsl:value-of select="maec:Start_Address"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Enumerated_Values">
                        <tr>
                            <td>Enumerated Values</td>
                            <td><xsl:value-of select="maec:Enumerated_Values"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table><br/>
        </div>
    </xsl:template>
    
    <xsl:template name="processNetworkActionAttributes">
        <b>Network Action Attributes</b>
        <div id="section">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:Enumerated_Subkeys">
                        <tr>
                            <td>Internal Port</td>
                            <td><xsl:value-of select="maec:Internal_Port"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:External_Port">
                        <tr>
                            <td>External Port</td>
                            <td><xsl:value-of select="maec:External_Port"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Internal_IP_Address">
                        <tr>
                            <td>Internal IP Address</td>
                            <td><xsl:value-of select="maec:Internal_IP_Address"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:External_IP_Address">
                        <tr>
                            <td>External IP Address</td>
                            <td><xsl:value-of select="maec:External_IP_Address"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Host_Name">
                        <tr>
                            <td>Host Name</td>
                            <td><xsl:value-of select="maec:Host_Name"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Buffer_Length">
                        <tr>
                            <td>Buffer Length</td>
                            <td><xsl:value-of select="maec:Buffer_Length"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table><br/>
            <xsl:if test="maec:Data_Sent">
                Data Sent
                <xsl:for-each select="maec:Data_Sent">
                    <xsl:call-template name="processDataType"/>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="maec:Data_Received">
                Data Received
                <xsl:for-each select="maec:Data_Received">
                    <xsl:call-template name="processDataType"/>
                </xsl:for-each>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template name="processModuleActionAttributes">
        <b>Module Action Attributes</b>
        <div id="section">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:Function_Name">
                        <tr>
                            <td>Function Name</td>
                            <td><xsl:value-of select="maec:Function_Name"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Flags">
                        <tr>
                            <td>Flags</td>
                            <td><xsl:value-of select="maec:Flags"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table><br/>
        </div>
    </xsl:template>
    
    <xsl:template name="processServiceActionAttributes">
        <b>Service/Daemon Action Attributes</b>
        <div id="section">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:Options">
                        <tr>
                            <td>Options</td>
                            <td><xsl:value-of select="maec:Options"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Start_Type">
                        <tr>
                            <td>Start_Type</td>
                            <td><xsl:value-of select="maec:Start_Type"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Desired_Access_Type">
                        <tr>
                            <td>Desired Access Type</td>
                            <td><xsl:value-of select="maec:Desired_Access_Type"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table><br/>
            <xsl:if test="maec:Enumerated_Daemons">
                Enumerated Services/Daemons
                <xsl:for-each select="maec:Enumerated_Daemons/maec:Daemon_Reference">
                    <xsl:for-each select="key('objectID',@object_id)">
                        <xsl:call-template name="processObject"/><br/>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template name="processSystemActionAttributes">
        <b>System Action Attributes</b>
        <div id="section">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:Computer_Name">
                        <tr>
                            <td>Computer Name</td>
                            <td><xsl:value-of select="maec:Computer_Name"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Local_Time">
                        <tr>
                            <td>Local Time</td>
                            <td><xsl:value-of select="maec:Local_Time"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table><br/>
        </div>
    </xsl:template>
    
    <xsl:template name="processInternetActionAttributes">
        <b>Internet Action Attributes</b>
        <div id="section">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:URL_Connected">
                        <tr>
                            <td>URL</td>
                            <td><xsl:value-of select="maec:URL_Connected/metadata:uriString"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table><br/>
        </div>
    </xsl:template>
    
    <xsl:template name="processActionImp">
        <span style="font-weight:bold;">Implementation</span> 
        <div id="section">
            <xsl:if test="@type">
                <table id="one-column-emphasis">
                    <colgroup>
                        <col class="oce-first" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <td>Type</td>
                            <td><xsl:value-of select="@type"/></td>
                        </tr>
                    </tbody>
                </table><br/>
            </xsl:if>
            
            <xsl:if test="maec:API_Call">
                <b>API Call Implementation</b>
                <table id="one-column-emphasis">
                    <colgroup>
                        <col class="oce-first" />
                    </colgroup>
                    <tbody>
                        <xsl:if test="maec:API_Call/@apifunction_name">
                            <tr>
                                <td>Function Name</td>
                                <td><xsl:value-of select="maec:API_Call/@apifunction_name"/></td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="maec:API_Call/maec:Address">
                            <tr>
                                <td>Address</td>
                                <td><xsl:value-of select="maec:API_Call/maec:Address"/></td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="maec:API_Call/maec:Return_Value">
                            <tr>
                                <td>Return Value</td>
                                <td><xsl:value-of select="maec:API_Call/maec:Return_Value"/></td>
                            </tr>
                        </xsl:if>
                    </tbody>
                </table><br/>
                <b>Parameters</b>
                <table id="one-column-emphasis">
                    <colgroup>
                        <col class="oce-first" />
                    </colgroup>
                    <tbody>
                        <xsl:for-each select="maec:API_Call/maec:APICall_Parameter">
                            <tr>
                                <td><xsl:value-of select="maec:Name"/></td>
                                <td><xsl:value-of select="maec:Value"/></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table><br/>
            </xsl:if>
            <xsl:if test="maec:Code">
                <xsl:for-each select="maec:Code">
                    <b>Code Implementation</b>
                    <xsl:call-template name="processCodeType"/>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="maec:Platform">
                <b>Platform</b>
                <table id="one-column-emphasis">
                    <colgroup>
                        <col class="oce-first" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <td>CPE Name</td>
                            <td><xsl:value-of select="maec:Platform/@cpe_name"/></td>
                        </tr>
                    </tbody>
                </table>
            </xsl:if>
            <xsl:if test="maec:Data_Read">
                <b>Data Read</b>
                <xsl:for-each select="maec:Data_Read">
                    <xsl:call-template name="processDataType"/>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="maec:Data_Written">
                <b>Data Written</b>
                <xsl:for-each select="maec:Data_Written">
                    <xsl:call-template name="processDataType"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:File_System_Action_Attributes">
                <xsl:for-each select="maec:File_System_Action_Attributes">
                    <xsl:call-template name="processFileActionAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:IPC_Action_Attributes">
                <xsl:for-each select="maec:IPC_Action_Attributes">
                    <xsl:call-template name="processIPCActionAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Process_Action_Attributes">
                <xsl:for-each select="maec:Process_Action_Attributes">
                    <xsl:call-template name="processProcessActionAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Memory_Action_Attributes">
                <xsl:for-each select="maec:Memory_Action_Attributes">
                    <xsl:call-template name="processMemoryActionAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Registry_Action_Attributes">
                <xsl:for-each select="maec:Registry_Action_Attributes">
                    <xsl:call-template name="processRegistryActionAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Network_Action_Attributes">
                <xsl:for-each select="maec:Network_Action_Attributes">
                    <xsl:call-template name="processNetworkActionAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Module_Action_Attributes">
                <xsl:for-each select="maec:Module_Action_Attributes">
                    <xsl:call-template name="processNetworkActionAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Daemon_Action_Attributes">
                <xsl:for-each select="maec:Daemon_Action_Attributes">
                    <xsl:call-template name="processServiceActionAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:System_Action_Attributes">
                <xsl:for-each select="maec:System_Action_Attributes">
                    <xsl:call-template name="processSystemActionAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Internet_Action_Attributes">
                <xsl:for-each select="maec:Internet_Action_Attributes">
                    <xsl:call-template name="processInternetActionAttributes"/>
                </xsl:for-each>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template name="processDataType">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
        <tbody>
            <xsl:if test="@format">
                <tr>
                    <td>Data Format</td>
                    <td><xsl:value-of select="@format"/></td>
                </tr>
            </xsl:if>
            <xsl:if test="maec:Data_Size">
                <tr>
                    <td>Data Size</td>
                    <td><xsl:value-of select="maec:Data_Size"/></td>
                </tr>
            </xsl:if>
            <xsl:if test="maec:Data_Segment">
                <tr>
                    <td>Data</td>
                    <td><xsl:value-of select="maec:Data_Segment"/></td>
                </tr>
            </xsl:if>
        </tbody>
        </table><br/>
    </xsl:template>
    
    <xsl:template name="processCodeType">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="@codetype">
                    <tr>
                        <td>Type of Code</td>
                        <td><xsl:value-of select="@codetype"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@language">
                    <tr>
                        <td>Programming Language</td>
                        <td><xsl:value-of select="@language"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@start_address">
                    <tr>
                        <td>Start Address</td>
                        <td><xsl:value-of select="@start_address"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@processor_family">
                    <tr>
                        <td>Processor Family (architecture)</td>
                        <td><xsl:value-of select="@processor_family"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="@xorpattern">
                    <tr>
                        <td>XOR Pattern (for encoded code)</td>
                        <td><xsl:value-of select="@xorpattern"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Code_Segment">
                    <tr>
                        <td>Code Segment (raw)</td>
                        <td><xsl:value-of select="maec:Code_Segment"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Code_Segment_XOR">
                    <tr>
                        <td>Code Segment (XOR encoded)</td>
                        <td><xsl:value-of select="maec:Code_Segment_XOR"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table><br/>
        <xsl:if test="maec:External_File">
            <xsl:for-each select="maec:External_File">
                <xsl:call-template name="processObject"/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processObjects">
        <xsl:call-template name="processFileObjects"/>
        <xsl:call-template name="processRegistryObjects"/>
        <xsl:call-template name="processProcessObjects"/>
        <xsl:call-template name="processIPCObjects"/>
        <xsl:call-template name="processNetworkObjects"/>
        <xsl:call-template name="processModuleObjects"/>
        <xsl:call-template name="processInternetObjects"/>
        <xsl:call-template name="processServiceObjects"/>
        <xsl:call-template name="processMemoryObjects"/>
    </xsl:template>
    
    <xsl:template name="processAllObjects">
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
                            Object Name
                        </TH>
                    </TR>
                </THEAD>
                <TBODY>
                   <xsl:for-each select="//maec:Object">
                       <xsl:sort select="@type" order="ascending"/>
                       <xsl:choose>
                           <xsl:when test="position() mod 2">
                               <xsl:call-template name="processObjOdd"/>
                           </xsl:when>
                           <xsl:otherwise>
                               <xsl:call-template name="processObjEven"/>
                           </xsl:otherwise>
                       </xsl:choose>
                   </xsl:for-each>
                </TBODY>
            </TABLE>
        </div>
    </xsl:template>
    
    <xsl:template name="processFileObjects">
        <xsl:if test="key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='File' or key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Directory' or key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Pipe'">
            <div id="fileObjHeader" style="cursor: pointer;" onclick="toggleDiv('fileObjContent', 'fileObjSpan')">
                <span id="fileObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>Affected File System Objects</b>
            </div>
            <div id="fileObjContent" style="overflow:hidden; display:none;">
                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                    <COLGROUP>
                        <COL width="60%"/>
                        <COL width="20%"/>
                        <COL width="20%"/>
                    </COLGROUP>
                    
                    <THEAD>
                        <TR>
                            <TH class="header">
                                Object Type
                            </TH>
                            <TH class="header">
                                Object Name
                            </TH>
                            <TH class="header">
                                Effect
                            </TH>
                        </TR>
                    </THEAD>
                    <TBODY>
                        
                        <xsl:for-each select="//maec:Affected_Object">
                            <xsl:sort select="@effect_type" order="ascending"/>
                            <xsl:if test="key('objectID',maec:Object_Reference/@object_id)/@type='File' or key('objectID',maec:Object_Reference/@object_id)/@type='Directory' or key('objectID',maec:Object_Reference/@object_id)/@type='Pipe'">
                                <xsl:choose>
                                    <xsl:when test="position() mod 2">
                                        <xsl:call-template name="processAffectedObjOdd"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="processAffectedObjEven"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </TBODY>
                </TABLE>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processRegistryObjects">
        <xsl:if test="key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Key/Key Group'">
            <div id="regObjHeader" style="cursor: pointer;" onclick="toggleDiv('regObjContent', 'regObjSpan')">
                <span id="regObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>Affected Registry Objects</b>
            </div>
            <div id="regObjContent" style="overflow:hidden; display:none;">
              <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                  <COLGROUP>
                      <COL width="60%"/>
                      <COL width="20%"/>
                      <COL width="20%"/>
                  </COLGROUP>
                  
                  <THEAD>
                      <TR>
                          <TH class="header">
                              Object Type
                          </TH>
                          <TH class="header">
                              Object Name
                          </TH>
                          <TH class="header">
                              Effect
                          </TH>
                      </TR>
                  </THEAD>
                  <TBODY>
                      
                      <xsl:for-each select="//maec:Affected_Object">
                          <xsl:sort select="@effect_type" order="ascending"/>
                          <xsl:if test="key('objectID',maec:Object_Reference/@object_id)/@type='Key/Key Group'">
                              <xsl:choose>
                                  <xsl:when test="position() mod 2">
                                      <xsl:call-template name="processAffectedObjOdd"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                      <xsl:call-template name="processAffectedObjEven"/>
                                  </xsl:otherwise>
                              </xsl:choose>
                          </xsl:if>
                      </xsl:for-each>
                  </TBODY>
              </TABLE>
              </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processNetworkObjects">
        <xsl:if test="key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Socket'">
            <div id="netObjHeader" style="cursor: pointer;" onclick="toggleDiv('netObjContent', 'netObjSpan')">
                <span id="netObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>Affected Network Objects</b>
            </div>
            <div id="netObjContent" style="overflow:hidden; display:none;">
                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                    <COLGROUP>
                        <COL width="60%"/>
                        <COL width="20%"/>
                        <COL width="20%"/>
                    </COLGROUP>
                    
                    <THEAD>
                        <TR>
                            <TH class="header">
                                Object Type
                            </TH>
                            <TH class="header">
                                Object Name
                            </TH>
                            <TH class="header">
                                Effect
                            </TH>
                        </TR>
                    </THEAD>
                    <TBODY>
                        
                        <xsl:for-each select="//maec:Affected_Object">
                            <xsl:sort select="@effect_type" order="ascending"/>
                            <xsl:if test="key('objectID',maec:Object_Reference/@object_id)/@type='Socket'">
                                <xsl:choose>
                                    <xsl:when test="position() mod 2">
                                        <xsl:call-template name="processAffectedObjOdd"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="processAffectedObjEven"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </TBODY>
                </TABLE>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processServiceObjects">
        <xsl:if test="key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Service/Daemon'">
            <div id="servObjHeader" style="cursor: pointer;" onclick="toggleDiv('servObjContent', 'servObjSpan')">
                <span id="servObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span>  <b>Affected Service/Daemon Objects</b>
            </div>
            <div id="servObjContent" style="overflow:hidden; display:none;">
                 <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                     <COLGROUP>
                         <COL width="60%"/>
                         <COL width="20%"/>
                         <COL width="20%"/>
                     </COLGROUP>
                     
                     <THEAD>
                         <TR>
                             <TH class="header">
                                 Object Type
                             </TH>
                             <TH class="header">
                                 Object Name
                             </TH>
                             <TH class="header">
                                 Effect
                             </TH>
                         </TR>
                     </THEAD>
                     <TBODY>
                         
                         <xsl:for-each select="//maec:Affected_Object">
                             <xsl:sort select="@effect_type" order="ascending"/>
                             <xsl:if test="key('objectID',maec:Object_Reference/@object_id)/@type='Service/Daemon'">
                                 <xsl:choose>
                                     <xsl:when test="position() mod 2">
                                         <xsl:call-template name="processAffectedObjOdd"/>
                                     </xsl:when>
                                     <xsl:otherwise>
                                         <xsl:call-template name="processAffectedObjEven"/>
                                     </xsl:otherwise>
                                 </xsl:choose>
                             </xsl:if>
                         </xsl:for-each>
                     </TBODY>
                 </TABLE>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processMemoryObjects">
        <xsl:if test="key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Heap' or key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Memory Page'">
            <div id="memObjHeader" style="cursor: pointer;" onclick="toggleDiv('memObjContent', 'memObjSpan')">
                <span id="memObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>Affected Memory Objects</b>
            </div>
            <div id="memObjContent" style="overflow:hidden; display:none;">
                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                    <COLGROUP>
                        <COL width="60%"/>
                        <COL width="20%"/>
                        <COL width="20%"/>
                    </COLGROUP>
                    
                    <THEAD>
                        <TR>
                            <TH class="header">
                                Object Type
                            </TH>
                            <TH class="header">
                                Object Name
                            </TH>
                            <TH class="header">
                                Effect
                            </TH>
                        </TR>
                    </THEAD>
                    <TBODY>
                        <xsl:for-each select="//maec:Affected_Object">
                            <xsl:sort select="@effect_type" order="ascending"/>
                            <xsl:if test="key('objectID',maec:Object_Reference/@object_id)/@type='Heap' or key('objectID',maec:Object_Reference/@object_id)/@type='Memory Page'">
                                <xsl:choose>
                                    <xsl:when test="position() mod 2">
                                        <xsl:call-template name="processAffectedObjOdd"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="processAffectedObjEven"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </TBODY>
                </TABLE>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processInternetObjects">
        <xsl:if test="key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='URL' or key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='URI'">
            <div id="intObjHeader" style="cursor: pointer;" onclick="toggleDiv('intObjContent', 'intObjSpan')">
                <span id="intObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>Affected Internet Objects</b>
            </div>
            <div id="intObjContent" style="overflow:hidden; display:none;">
                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                    <COLGROUP>
                        <COL width="60%"/>
                        <COL width="20%"/>
                        <COL width="20%"/>
                    </COLGROUP>
                    
                    <THEAD>
                        <TR>
                            <TH class="header">
                                Object Type
                            </TH>
                            <TH class="header">
                                Object Name
                            </TH>
                            <TH class="header">
                                Effect
                            </TH>
                        </TR>
                    </THEAD>
                    <TBODY>
                        
                        <xsl:for-each select="//maec:Affected_Object">
                            <xsl:sort select="@effect_type" order="ascending"/>
                            <xsl:if test="key('objectID',maec:Object_Reference/@object_id)/@type='URL' or key('objectID',maec:Object_Reference/@object_id)/@type='URI'">
                                <xsl:choose>
                                    <xsl:when test="position() mod 2">
                                        <xsl:call-template name="processAffectedObjOdd"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="processAffectedObjEven"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </TBODY>
                </TABLE>
            </div>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="processModuleObjects">
        <xsl:if test="key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Library'">
            <div id="modObjHeader" style="cursor: pointer;" onclick="toggleDiv('modObjContent', 'modObjSpan')">
                <span id="modObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>Affected Module Objects</b>
            </div>
            <div id="modObjContent" style="overflow:hidden; display:none;">
                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                    <COLGROUP>
                        <COL width="60%"/>
                        <COL width="20%"/>
                        <COL width="20%"/>
                    </COLGROUP>
                    
                    <THEAD>
                        <TR>
                            <TH class="header">
                                Object Type
                            </TH>
                            <TH class="header">
                                Object Name
                            </TH>
                            <TH class="header">
                                Effect
                            </TH>
                        </TR>
                    </THEAD>
                    <TBODY>
                        
                        <xsl:for-each select="//maec:Affected_Object">
                            <xsl:sort select="@effect_type" order="ascending"/>
                            <xsl:if test="key('objectID',maec:Object_Reference/@object_id)/@type='Library'">
                                <xsl:choose>
                                    <xsl:when test="position() mod 2">
                                        <xsl:call-template name="processAffectedObjOdd"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="processAffectedObjEven"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </TBODY>
                </TABLE>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processProcessObjects">
        <xsl:if test="key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Process'">
            <div id="procObjHeader" style="cursor: pointer;" onclick="toggleDiv('procObjContent', 'procObjSpan')">
                <span id="procObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>Affected Process Objects</b>
            </div>
            <div id="procObjContent" style="overflow:hidden; display:none;">
                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                    <COLGROUP>
                        <COL width="60%"/>
                        <COL width="20%"/>
                        <COL width="20%"/>
                    </COLGROUP>
                    
                    <THEAD>
                        <TR>
                            <TH class="header">
                                Object Type
                            </TH>
                            <TH class="header">
                                Object Name
                            </TH>
                            <TH class="header">
                                Effect
                            </TH>
                        </TR>
                    </THEAD>
                    <TBODY>
                        
                        <xsl:for-each select="//maec:Affected_Object">
                            <xsl:sort select="@effect_type" order="ascending"/>
                            <xsl:if test="key('objectID',maec:Object_Reference/@object_id)/@type='Process'">
                                <xsl:choose>
                                    <xsl:when test="position() mod 2">
                                        <xsl:call-template name="processAffectedObjOdd"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="processAffectedObjEven"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </TBODY>
                </TABLE>
           </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processIPCObjects">
        <xsl:if test="key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Mutex' or key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Thread' or key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Event'">
            <div id="ipcObjHeader" style="cursor: pointer;" onclick="toggleDiv('ipcObjContent', 'ipcObjSpan')">
                <span id="ipcObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>Affected IPC Objects</b>
            </div>
            <div id="ipcObjContent" style="overflow:hidden; display:none;">
                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                    <COLGROUP>
                        <COL width="60%"/>
                        <COL width="20%"/>
                        <COL width="20%"/>
                    </COLGROUP>
                    
                    <THEAD>
                        <TR>
                            <TH class="header">
                                Object Type
                            </TH>
                            <TH class="header">
                                Object Name
                            </TH>
                            <TH class="header">
                                Effect
                            </TH>
                        </TR>
                    </THEAD>
                    <TBODY>
                        
                        <xsl:for-each select="//maec:Affected_Object">
                            <xsl:sort select="@effect_type" order="ascending"/>
                            <xsl:if test="key('objectID',maec:Object_Reference/@object_id)/@type='Mutex' or key('objectID',maec:Object_Reference/@object_id)/@type='Thread' or key('objectID',maec:Object_Reference/@object_id)/@type='Event'">
                                <xsl:choose>
                                    <xsl:when test="position() mod 2">
                                        <xsl:call-template name="processAffectedObjOdd"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="processAffectedObjEven"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </TBODY>
                </TABLE>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processGUIObjects">
        <xsl:if test="key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Window' or key('objectID',//maec:Affected_Object/maec:Object_Reference/@object_id)/@type='Dialog'">
            <div id="guiObjHeader" style="cursor: pointer;" onclick="toggleDiv('guiObjContent', 'guiObjSpan')">
                <span id="guiObjSpan" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <b>Affected GUI Objects</b>
            </div>
            <div id="guiObjContent" style="overflow:hidden; display:none;">
                <TABLE class="grid tablesorter" cellspacing="0" style="width: auto;">
                    <COLGROUP>
                        <COL width="60%"/>
                        <COL width="20%"/>
                        <COL width="20%"/>
                    </COLGROUP>
                    
                    <THEAD>
                        <TR>
                            <TH style="margin:10px;" class="header">
                                Object Type
                            </TH>
                            <TH class="header">
                                Object Name
                            </TH>
                            <TH class="header">
                                Effect
                            </TH>
                        </TR>
                    </THEAD>
                    <TBODY>
                        
                        <xsl:for-each select="//maec:Affected_Object">
                            <xsl:sort select="@effect_type" order="ascending"/>
                            <xsl:if test="key('objectID',maec:Object_Reference/@object_id)/@type='Window' or key('objectID',maec:Object_Reference/@object_id)/@type='Dialog'">
                                <xsl:choose>
                                    <xsl:when test="position() mod 2">
                                        <xsl:call-template name="processAffectedObjOdd"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="processAffectedObjEven"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </TBODY>
                </TABLE>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processAffectedObjOdd">
        <TR class="odd">
            <TD>
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="fileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <xsl:value-of select="key('objectID',maec:Object_Reference/@object_id)/@type"/>
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <xsl:for-each select="key('objectID',maec:Object_Reference/@object_id)">
                        <xsl:call-template name="processObjectFull"/><br/>
                    </xsl:for-each>
                </div>
            </TD>
            <TD>                    
                <xsl:choose>
                    <xsl:when test="key('objectID',maec:Object_Reference/@object_id)/@object_name">
                        <xsl:value-of select="key('objectID',maec:Object_Reference/@object_id)/@object_name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        N/A
                    </xsl:otherwise>
                </xsl:choose>
            </TD>
            
            <TD>                    
                <xsl:choose>
                    <xsl:when test="@effect_type">
                        <xsl:value-of select="replace(@effect_type, '_', ' ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        N/A
                    </xsl:otherwise>
                </xsl:choose>
            </TD>
        </TR>
    </xsl:template>
    
    <xsl:template name="processAffectedObjEven">
        <TR class="even">
            <TD>
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="fileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <xsl:value-of select="key('objectID',maec:Object_Reference/@object_id)/@type"/>
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <xsl:for-each select="key('objectID',maec:Object_Reference/@object_id)">
                        <xsl:call-template name="processObjectFull"/><br/>
                    </xsl:for-each>
                </div>
            </TD>
            <TD>                    
                <xsl:choose>
                    <xsl:when test="key('objectID',maec:Object_Reference/@object_id)/@object_name">
                        <xsl:value-of select="key('objectID',maec:Object_Reference/@object_id)/@object_name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        N/A
                    </xsl:otherwise>
                </xsl:choose>
            </TD>
            
            <TD>                    
                <xsl:choose>
                    <xsl:when test="@effect_type">
                        <xsl:value-of select="replace(@effect_type, '_', ' ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        N/A
                    </xsl:otherwise>
                </xsl:choose>
            </TD>
        </TR>
    </xsl:template>
    
    <xsl:template name="processObjOdd">
        <TR class="odd">
            <TD>
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="fileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <xsl:value-of select="@type"/>
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <xsl:call-template name="processObjectFull"/><br/>
                </div>
            </TD>
            <TD>                    
                <xsl:choose>
                    <xsl:when test="@object_name">
                        <xsl:value-of select="@object_name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        N/A
                    </xsl:otherwise>
                </xsl:choose>
            </TD>
        </TR>
    </xsl:template>
    
    <xsl:template name="processObjEven">
        <TR class="even">
            <TD>
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="fileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> <xsl:value-of select="@type"/>
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                        <xsl:call-template name="processObjectFull"/><br/>
                </div>
            </TD>
            <TD>                    
                <xsl:choose>
                    <xsl:when test="@object_name">
                        <xsl:value-of select="@object_name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        N/A
                    </xsl:otherwise>
                </xsl:choose>
            </TD>
        </TR>
    </xsl:template>
    
    <xsl:template name="processObjectFull">
        <div id="object_label"><xsl:value-of select="@type"/> Object</div>
        <div id="container">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:choose>
                        <xsl:when test="@object_name">
                            <tr>
                                <td>Object Name</td>
                                <td><xsl:value-of select="@object_name"/></td>
                            </tr>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="@permanent">
                            <tr>
                                <td>Object Permanence</td>
                                <td><xsl:value-of select="@permanent"/></td>
                            </tr>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="maec:Object_Size">
                            <tr>
                                <td>Object Size (<xsl:value-of select="maec:Object_Size/@units"/>)</td>
                                <td><xsl:value-of select="maec:Object_Size"/></td>
                            </tr>
                        </xsl:when>
                    </xsl:choose>       
                </tbody>
            </table> <br/>
            
            <xsl:if test="maec:File_System_Object_Attributes">
                    <xsl:for-each select="maec:File_System_Object_Attributes">
                        <xsl:call-template name="processFileObjectAttributes"/>
                    </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:GUI_Object_Attributes">
                <xsl:for-each select="maec:GUI_Object_Attributes">
                    <xsl:call-template name="processGUIObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:IPC_Object_Attributes">
                <xsl:for-each select="maec:IPC_Object_Attributes">
                    <xsl:call-template name="processIPCObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Internet_Object_Attributes">
                <xsl:for-each select="maec:Internet_Object_Attributes">
                    <xsl:call-template name="processInternetObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Module_Object_Attributes">
                <xsl:for-each select="maec:Module_Object_Attributes">
                    <xsl:call-template name="processModuleObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Registry_Object_Attributes">
                <xsl:for-each select="maec:Registry_Object_Attributes">
                    <xsl:call-template name="processRegistryObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Process_Object_Attributes">
                <xsl:for-each select="maec:Process_Object_Attributes">
                    <xsl:call-template name="processProcessObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Memory_Object_Attributes">
                <xsl:for-each select="maec:Process_Object_Attributes">
                    <xsl:call-template name="processMemoryObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Network_Object_Attributes">
                <xsl:for-each select="maec:Network_Object_Attributes">
                    <xsl:call-template name="processNetworkObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Daemon_Object_Attributes">
                <xsl:for-each select="maec:Daemon_Object_Attributes">
                    <xsl:call-template name="processDaemonObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Custom_Object_Attributes">
                <xsl:for-each select="maec:Custom_Object_Attributes">
                    <xsl:call-template name="processDaemonObjectAttributes"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:if test="maec:Classifications">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="classifications" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> AV Classifications
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="maec:Classifications/maec:Classification">
                                <tr>
                                    <td><xsl:value-of select="metadata:companyName"/></td>
                                    <td><xsl:value-of select="metadata:classificationName"/></td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </xsl:if>
            
            <xsl:for-each select="maec:Associated_Code">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="associatedCode" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Associated Code
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <xsl:call-template name="processAssociatedCode"/>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="processObject">
        <div id="object_label"><xsl:value-of select="@type"/> Object</div>
        <div id="container">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:choose>
                        <xsl:when test="@object_name">
                            <tr>
                                 <td>Object Name</td>
                                 <td><xsl:value-of select="@object_name"/></td>
                            </tr>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                       <xsl:when test="@permanent">
                            <tr>
                                <td>Object Permanence</td>
                                <td><xsl:value-of select="@permanent"/></td>
                            </tr>
                       </xsl:when>
                    </xsl:choose>
                        <xsl:choose>
                            <xsl:when test="maec:Object_Size">
                                <tr>
                                    <td>Object Size (<xsl:value-of select="maec:Object_Size/@units"/>)</td>
                                    <td><xsl:value-of select="maec:Object_Size"/></td>
                                </tr>
                            </xsl:when>
                        </xsl:choose>       
                </tbody>
            </table> <br/>
            
            <xsl:if test="maec:File_System_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="fileObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> File Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:for-each select="maec:File_System_Object_Attributes">
                            <xsl:call-template name="processFileObjectAttributes"/>
                    </xsl:for-each>
                </div>
            </xsl:if>

            <xsl:if test="maec:GUI_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="guiObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}', '{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> GUI Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                  <xsl:for-each select="maec:GUI_Object_Attributes">
                          <xsl:call-template name="processGUIObjectAttributes"/>
                  </xsl:for-each>
                </div>
            </xsl:if>

            <xsl:if test="maec:IPC_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="ipcObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> IPC Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:for-each select="maec:IPC_Object_Attributes">
                            <xsl:call-template name="processIPCObjectAttributes"/>
                    </xsl:for-each>
                </div>
            </xsl:if>

            <xsl:if test="maec:Internet_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="intObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}', '{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Internet Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:for-each select="maec:Internet_Object_Attributes">
                            <xsl:call-template name="processInternetObjectAttributes"/>
                    </xsl:for-each>
                </div>
            </xsl:if>

            <xsl:if test="maec:Module_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="modObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}', '{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Module Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:for-each select="maec:Module_Object_Attributes">
                            <xsl:call-template name="processModuleObjectAttributes"/>
                    </xsl:for-each>
                </div>
            </xsl:if>
            
            <xsl:if test="maec:Registry_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="regObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Registry Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 20px;">
                    <br/>
                    <xsl:for-each select="maec:Registry_Object_Attributes">
                            <xsl:call-template name="processRegistryObjectAttributes"/>
                    </xsl:for-each>
                </div>
            </xsl:if>
            
            <xsl:if test="maec:Process_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="procObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Process Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:for-each select="maec:Process_Object_Attributes">
                            <xsl:call-template name="processProcessObjectAttributes"/>
                    </xsl:for-each>
                </div>
            </xsl:if>

            <xsl:if test="maec:Memory_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="memObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Memory Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:for-each select="maec:Memory_Object_Attributes">
                            <xsl:call-template name="processMemoryObjectAttributes"/>
                    </xsl:for-each>
                </div>
            </xsl:if>
            
            <xsl:if test="maec:Network_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="netObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Network Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:for-each select="maec:Network_Object_Attributes">
                            <xsl:call-template name="processNetworkObjectAttributes"/>                  
                    </xsl:for-each>
                </div>
            </xsl:if>

            <xsl:if test="maec:Daemon_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="servObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Service Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:for-each select="maec:Daemon_Object_Attributes">
                            <xsl:call-template name="processDaemonObjectAttributes"/>
                    </xsl:for-each>
                </div>
            </xsl:if>
            
            <xsl:if test="maec:Custom_Object_Attributes">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="custObjAtt" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Custom Object Attributes
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <br/>
                    <xsl:for-each select="maec:Custom_Object_Attributes">
                            <xsl:call-template name="processCustomObjectAttributes"/>
                    </xsl:for-each>
                </div>
            </xsl:if>
            
            
            <xsl:if test="maec:Classifications">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="classifications" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> AV Classifications
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first" />
                        </colgroup>
                        <tbody>
                            <xsl:for-each select="maec:Classifications/maec:Classification">
                                <tr>
                                    <td><xsl:value-of select="metadata:companyName"/></td>
                                    <td><xsl:value-of select="metadata:classificationName"/></td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </xsl:if>
            
            <xsl:for-each select="maec:Associated_Code">
                <xsl:variable name="contentVar" select="concat(count(ancestor::node()), '00000000', count(preceding::node()))"/>
                <xsl:variable name="imgVar" select="generate-id()"/>
                <div id="associatedCode" style="cursor: pointer;" onclick="toggleDiv('{$contentVar}','{$imgVar}')">
                    <span id="{$imgVar}" style="font-weight:bold; margin:5px; color:#BD9C8C;">+</span> Associated Code
                </div>
                <div id="{$contentVar}" style="overflow:hidden; display:none; padding:0px 7px;">
                    <xsl:call-template name="processAssociatedCode"/>
                </div>
            </xsl:for-each>
            
        </div>
    </xsl:template>
    
    <xsl:template name="processObjectSecondary">
        <div id="object_label"><xsl:value-of select="@type"/> Object</div>
        <div id="container">
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:choose>
                        <xsl:when test="@object_name">
                            <tr>
                                <td>Object Name</td>
                                <td><xsl:value-of select="@object_name"/></td>
                            </tr>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="@permanent">
                            <tr>
                                <td>Object Permanence</td>
                                <td><xsl:value-of select="@permanent"/></td>
                            </tr>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="maec:Object_Size">
                            <tr>
                                <td>Object Size (<xsl:value-of select="maec:Object_Size/@units"/>)</td>
                                <td><xsl:value-of select="maec:Object_Size"/></td>
                            </tr>
                        </xsl:when>
                    </xsl:choose>       
                </tbody>
            </table> <br/>
            
            <xsl:for-each select="maec:File_System_Object_Attributes">
                <xsl:call-template name="processFileObjectAttributes"/>
            </xsl:for-each>
            
            <xsl:for-each select="maec:GUI_Object_Attributes">
                <xsl:call-template name="processGUIObjectAttributes"/>
            </xsl:for-each>
            
            <xsl:for-each select="maec:IPC_Object_Attributes">
                <xsl:call-template name="processIPCObjectAttributes"/>
            </xsl:for-each>
            
            <xsl:for-each select="maec:Internet_Object_Attributes">
                <xsl:call-template name="processInternetObjectAttributes"/>
            </xsl:for-each>
            
            <xsl:for-each select="maec:Module_Object_Attributes">
                <xsl:call-template name="processModuleObjectAttributes"/>
            </xsl:for-each>
            
            <xsl:for-each select="maec:Registry_Object_Attributes">
                <xsl:call-template name="processRegistryObjectAttributes"/>
            </xsl:for-each>
            
            <xsl:for-each select="maec:Process_Object_Attributes">
                <xsl:call-template name="processProcessObjectAttributesSecondary"/>
            </xsl:for-each>
            
            <xsl:for-each select="maec:Memory_Object_Attributes">
                <xsl:call-template name="processMemoryObjectAttributes"/>
            </xsl:for-each>
            
            <xsl:for-each select="maec:Network_Object_Attributes">
                <xsl:call-template name="processNetworkObjectAttributes"/>
            </xsl:for-each>
            
            <xsl:for-each select="maec:Daemon_Object_Attributes">
                <xsl:call-template name="processDaemonObjectAttributes"/>
            </xsl:for-each>
            
            <xsl:for-each select="maec:Custom_Object_Attributes">
                <xsl:call-template name="processCustomObjectAttributes"/>
            </xsl:for-each>
            
            <xsl:if test="maec:Classifications">
                <b>AV Classifications</b>
                <table id="one-column-emphasis">
                    <colgroup>
                        <col class="oce-first" />
                    </colgroup>
                    <tbody>
                        <xsl:for-each select="maec:Classifications/maec:Classification">
                            <tr>
                                <td><xsl:value-of select="metadata:companyName"/></td>
                                <td><xsl:value-of select="metadata:classificationName"/></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table> <br/>
            </xsl:if>
            
            <xsl:for-each select="maec:Associated_Code">
                <xsl:call-template name="processAssociatedCode"/>
            </xsl:for-each>
            
        </div>
    </xsl:template>
    
    
    <xsl:template name="processFileObjectAttributes">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:File_Type">
                    <tr>
                        <td>File Type (general)</td>
                        <td><xsl:value-of select="maec:File_Type/@type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:File_Type/maec:TrID_Type">
                    <tr>
                        <td>File Type (TrID)</td>
                        <td><xsl:value-of select="maec:File_Type/maec:TrID_Type/maec:TriD_ID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Path">
                    <tr>
                        <td>Path</td>
                        <td><xsl:value-of select="maec:Path"/></td>
                    </tr>
                </xsl:if>
               <xsl:if test="maec:DateTime_Created">
                   <tr>
                       <td>Date/Time Created</td>
                       <td><xsl:value-of select="maec:DateTime_Created"/></td>
                   </tr>
               </xsl:if>
                <xsl:if test="maec:DateTime_Modified">
                    <tr>
                        <td>Date/Time Modified</td>
                        <td><xsl:value-of select="maec:DateTime_Modified"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Permissions">
                    <tr>
                        <td>Permissions</td>
                        <td><xsl:value-of select="maec:Permissions"/></td>
                    </tr>
                </xsl:if>
            </tbody>
            <xsl:if test="maec:Security_Attributes">
                <tr>
                    <td>Security Attributes</td>
                    <td><xsl:value-of select="maec:Security_Attributes"/></td>
                </tr>
            </xsl:if>
            <xsl:if test="maec:Origin">
                <tr>
                    <td>External Origin (url)</td>
                    <td><xsl:value-of select="maec:Origin/metadata:uriString"/></td>
                </tr>
            </xsl:if>
        </table> 
        <xsl:if test="maec:Hashes">
            <br/>
            <b>Hashes</b>
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:for-each select="maec:Hashes/maec:Hash">
                       <tr>
                           <xsl:choose>
                               <xsl:when test="@other_type">
                                   <td><xsl:value-of select="@other_type"/></td>
                               </xsl:when>
                               <xsl:otherwise>
                                   <td><xsl:value-of select="@type"/></td>
                               </xsl:otherwise>
                           </xsl:choose>
                           <td><xsl:value-of select="maec:Hash_Value"/></td>
                       </tr>
                    </xsl:for-each>
                </tbody>
            </table> 
        </xsl:if>
        <xsl:if test="maec:File_Type_Attributes">
            <br/>
            <xsl:for-each select="maec:File_Type_Attributes">
                <xsl:call-template name="processFileTypeAttributes"/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processFileTypeAttributes">
        <xsl:if test="maec:PE_Binary_Attributes">
            <xsl:for-each select="maec:PE_Binary_Attributes">
                <span style="font-weight:bold;">PE Binary Attributes</span> 
                <table id="one-column-emphasis">
                    <colgroup>
                        <col class="oce-first" />
                    </colgroup>
                    <tbody>
                        <xsl:if test="@type">
                            <tr>
                                <td>Type</td>
                                <td><xsl:value-of select="@type"/></td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="@dll_count">
                            <tr>
                                <td>DLL Count</td>
                                <td><xsl:value-of select="@dll_count"/></td>
                            </tr>
                        </xsl:if>
                    </tbody>
                </table> <br/>
                
                <xsl:if test="maec:Version_Block">
                    <span>Version Block</span> 
                    <table id="one-column-emphasis">
                        <colgroup>
                            <col class="oce-first" />
                        </colgroup>
                        <tbody>
                            <xsl:if test="maec:Internal_Name">
                                <tr>
                                    <td>Internal Name</td>
                                    <td><xsl:value-of select="maec:Internal_Name"/></td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="maec:Product_Name">
                                <tr>
                                    <td>Product Name</td>
                                    <td><xsl:value-of select="maec:Product_Name"/></td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="maec:Company_Name">
                                <tr>
                                    <td>Company Name</td>
                                    <td><xsl:value-of select="maec:Company_Name"/></td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="maec:Legal_Copyright">
                                <tr>
                                    <td>Legal Copyright</td>
                                    <td><xsl:value-of select="maec:Legal_Copyright"/></td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="maec:Product_Version_Text">
                                <tr>
                                    <td>Product Version Text</td>
                                    <td><xsl:value-of select="maec:Product_Version_Text"/></td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="maec:File_Description">
                                <tr>
                                    <td>File Description</td>
                                    <td><xsl:value-of select="maec:File_Description"/></td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="maec:File_Version_Text">
                                <tr>
                                    <td>File Version Text</td>
                                    <td><xsl:value-of select="maec:File_Version_Text"/></td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="maec:Original_File_Name">
                                <tr>
                                    <td>Original File Name</td>
                                    <td><xsl:value-of select="maec:Original_File_Name"/></td>
                                </tr>
                            </xsl:if>
                        </tbody>
                    </table> <br/>
                </xsl:if>
                
                <xsl:if test="maec:Headers">
                    <span>Headers</span> 
                    <xsl:for-each select="maec:Headers">
                      <xsl:if test="maec:DOS_Header">
                          <b>DOS Header</b>
                          <xsl:for-each select="maec:DOS_Header">
                              <xsl:for-each select="maec:Hashes">
                                  <xsl:call-template name="processHashes"/>
                              </xsl:for-each>
                              <table id="one-column-emphasis">
                                  <colgroup>
                                      <col class="oce-first" />
                                  </colgroup>
                                  <tbody>
                                      <xsl:if test="maec:signature">
                                          <tr>
                                              <td>signature</td>
                                              <td><xsl:value-of select="maec:signature"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:lastsize">
                                          <tr>
                                              <td>last size</td>
                                              <td><xsl:value-of select="maec:lastsize"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:nblocks">
                                          <tr>
                                              <td>nblocks</td>
                                              <td><xsl:value-of select="maec:nblocks"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:nreloc">
                                          <tr>
                                              <td>nreloc</td>
                                              <td><xsl:value-of select="maec:nreloc"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:Product_Version_Text">
                                          <tr>
                                              <td>hdrsize</td>
                                              <td><xsl:value-of select="maec:hdrsize"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:minalloc">
                                          <tr>
                                              <td>minalloc</td>
                                              <td><xsl:value-of select="maec:minalloc"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:maxalloc">
                                          <tr>
                                              <td>maxalloc</td>
                                              <td><xsl:value-of select="maec:maxalloc"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:checksum">
                                          <tr>
                                              <td>checksum</td>
                                              <td><xsl:value-of select="maec:checksum"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:relocpos">
                                          <tr>
                                              <td>relocpos</td>
                                              <td><xsl:value-of select="maec:relocpos"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:noverlay">
                                          <tr>
                                              <td>noverlay</td>
                                              <td><xsl:value-of select="maec:noverlay"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:reserved1">
                                          <tr>
                                              <td>reserved1</td>
                                              <td><xsl:value-of select="maec:reserved1"/></td>
                                          </tr>
                                      </xsl:if>
                                      
                                      <xsl:if test="maec:oem_id">
                                          <tr>
                                              <td>oem id</td>
                                              <td><xsl:value-of select="maec:oem_id"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:oem_info">
                                          <tr>
                                              <td>oem info</td>
                                              <td><xsl:value-of select="maec:oem_info"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:reserved2">
                                          <tr>
                                              <td>reserved2</td>
                                              <td><xsl:value-of select="maec:reserved2"/></td>
                                          </tr>
                                      </xsl:if>
                                      <xsl:if test="maec:e_lfanew">
                                          <tr>
                                              <td>e_lfanew</td>
                                              <td><xsl:value-of select="maec:e_lfanew"/></td>
                                          </tr>
                                      </xsl:if>
                                  </tbody>
                              </table> <br/>  
                          </xsl:for-each>
                      </xsl:if>
                        <xsl:if test="maec:PE_Header">
                            <b>PE Header</b>
                            <xsl:for-each select="maec:PE_Header">
                                <table id="one-column-emphasis">
                                    <colgroup>
                                        <col class="oce-first" />
                                    </colgroup>
                                    <tbody>
                                        <xsl:if test="maec:Entropy">
                                            <tr>
                                                <td>Entropy</td>
                                                <td><xsl:value-of select="maec:Entropy"/></td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="maec:Signature">
                                            <tr>
                                                <td>Signature</td>
                                                <td><xsl:value-of select="maec:Signature"/></td>
                                            </tr>
                                        </xsl:if>
                                    </tbody>
                                </table>
                                <xsl:for-each select="maec:Hashes">
                                    <xsl:call-template name="processHashes"/>
                                </xsl:for-each>
                                <xsl:if test="maec:File_Header">
                                    <b>File/COFF Header</b>
                                    <xsl:for-each select="maec:File_Header">
                                        <xsl:for-each select="maec:Hashes">
                                            <xsl:call-template name="processHashes"/>
                                        </xsl:for-each>
                                        <table id="one-column-emphasis">
                                            <colgroup>
                                                <col class="oce-first" />
                                            </colgroup>
                                            <tbody>
                                                <xsl:if test="maec:Machine">
                                                    <tr>
                                                        <td>Machine</td>
                                                        <td><xsl:value-of select="maec:Machine"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Number_Of_Sections">
                                                    <tr>
                                                        <td>Number of Sections</td>
                                                        <td><xsl:value-of select="maec:Number_Of_Sections"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Time_Date_Stamp">
                                                    <tr>
                                                        <td>Time/Date Stamp</td>
                                                        <td><xsl:value-of select="maec:Time_Date_Stamp"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Pointer_To_Symbol_Table">
                                                    <tr>
                                                        <td>Pointer to Symbol Table</td>
                                                        <td><xsl:value-of select="maec:Pointer_To_Symbol_Table"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Number_Of_Symbols">
                                                    <tr>
                                                        <td>Number of Symbols</td>
                                                        <td><xsl:value-of select="maec:Number_Of_Symbols"/></td>
                                                    </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table> <br/>  
                                    </xsl:for-each>
                                </xsl:if>
                                <xsl:if test="maec:Optional_Header">
                                    <b>Optional Header</b>
                                    <xsl:for-each select="maec:Optional_Header">
                                        <xsl:for-each select="maec:Hashes">
                                            <xsl:call-template name="processHashes"/>
                                        </xsl:for-each>
                                        <table id="one-column-emphasis">
                                            <colgroup>
                                                <col class="oce-first" />
                                            </colgroup>
                                            <tbody>
                                                <xsl:if test="maec:Major_Linker_Version">
                                                    <tr>
                                                        <td>Major Linker Version</td>
                                                        <td><xsl:value-of select="maec:Major_Linker_Version"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Minor_Linker_Version">
                                                    <tr>
                                                        <td>Minor Linker Version</td>
                                                        <td><xsl:value-of select="maec:Minor_Linker_Version"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Size_Of_Code">
                                                    <tr>
                                                        <td>Size of Code</td>
                                                        <td><xsl:value-of select="maec:Size_Of_Code"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Size_Of_Initialized_Data">
                                                    <tr>
                                                        <td>Size of Initialized Data</td>
                                                        <td><xsl:value-of select="maec:Size_Of_Initialized_Data"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Size_Of_Uninitialized_Data">
                                                    <tr>
                                                        <td>Size Of Uninitialized Data</td>
                                                        <td><xsl:value-of select="maec:Size_Of_Uninitialized_Data"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Size_Of_Uninitialized_Data">
                                                    <tr>
                                                        <td>Size Of Uninitialized Data</td>
                                                        <td><xsl:value-of select="maec:Size_Of_Uninitialized_Data"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Address_Of_Entry_Point">
                                                    <tr>
                                                        <td>Address of Entry Point</td>
                                                        <td><xsl:value-of select="maec:Address_Of_Entry_Point"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Base_Of_Code">
                                                    <tr>
                                                        <td>Base of Code</td>
                                                        <td><xsl:value-of select="maec:Base_Of_Code"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Image_Base">
                                                    <tr>
                                                        <td>Image Base</td>
                                                        <td><xsl:value-of select="maec:Image_Base"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Section_Alignment">
                                                    <tr>
                                                        <td>Section Alignment</td>
                                                        <td><xsl:value-of select="maec:Section_Alignment"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:File_Alignment">
                                                    <tr>
                                                        <td>File Alignment</td>
                                                        <td><xsl:value-of select="maec:File_Alignment"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Major_OS_Version">
                                                    <tr>
                                                        <td>Major OS Versions</td>
                                                        <td><xsl:value-of select="maec:Major_OS_Version"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Minor_OS_Version">
                                                    <tr>
                                                        <td>Minor OS Version</td>
                                                        <td><xsl:value-of select="maec:Minor_OS_Version"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Major_Image_Version">
                                                    <tr>
                                                        <td>Major Image Version</td>
                                                        <td><xsl:value-of select="maec:Major_Image_Version"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Minor_Image_Version">
                                                    <tr>
                                                        <td>Minor Image Version</td>
                                                        <td><xsl:value-of select="maec:Minor_Image_Version"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Major_Subsystem_Version">
                                                    <tr>
                                                        <td>Major Susbsystem Version</td>
                                                        <td><xsl:value-of select="maec:Major_Subsystem_Version"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Minor_Subsystem_Version">
                                                    <tr>
                                                        <td>Minor Subsystem Version</td>
                                                        <td><xsl:value-of select="maec:Minor_Subsystem_Version"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Reserved">
                                                    <tr>
                                                        <td>Reserved</td>
                                                        <td><xsl:value-of select="maec:Reserved"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Reserved">
                                                    <tr>
                                                        <td>Reserved</td>
                                                        <td><xsl:value-of select="maec:Reserved"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Size_Of_Image">
                                                    <tr>
                                                        <td>Size of Image</td>
                                                        <td><xsl:value-of select="maec:Size_Of_Image"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Size_Of_Headers">
                                                    <tr>
                                                        <td>Size of Headers</td>
                                                        <td><xsl:value-of select="maec:Size_Of_Headers"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Checksum">
                                                    <tr>
                                                        <td>Checksum</td>
                                                        <td><xsl:value-of select="maec:Checksum"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Subsystem">
                                                    <tr>
                                                        <td>Subsystem</td>
                                                        <td><xsl:value-of select="maec:Subsystem"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:DLL_Characteristics">
                                                    <tr>
                                                        <td>DLL Characteristics</td>
                                                        <td><xsl:value-of select="maec:DLL_Characteristics"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Size_Of_Stack_Reserve">
                                                    <tr>
                                                        <td>Size of Stack Reserve</td>
                                                        <td><xsl:value-of select="maec:Size_Of_Stack_Reserve"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Size_Of_Stack_Commit">
                                                    <tr>
                                                        <td>Size of Stack Commit</td>
                                                        <td><xsl:value-of select="maec:Size_Of_Stack_Commit"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Size_Of_Heap_Reserve">
                                                    <tr>
                                                        <td>Size of Heap Reserve</td>
                                                        <td><xsl:value-of select="maec:Size_Of_Heap_Reserve"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Size_Of_Heap_Commit">
                                                    <tr>
                                                        <td>Size of Heap Commit</td>
                                                        <td><xsl:value-of select="maec:Size_Of_Heap_Commit"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Loader_Flags">
                                                    <tr>
                                                        <td>Loader Flags</td>
                                                        <td><xsl:value-of select="maec:Loader_Flags"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Number_Of_RVA_And_Sizes">
                                                    <tr>
                                                        <td>Number of RVA and Sizes</td>
                                                        <td><xsl:value-of select="maec:Number_Of_RVA_And_Sizes"/></td>
                                                    </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table> <br/>  
                                        <xsl:if test="maec:Data_Directory">
                                            <b>Data Directory</b>
                                            <xsl:for-each select="maec:Data_Directory">
                                                <xsl:for-each select="maec:Export_Symbols">
                                                    Export Symbols
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Import_Symbols">
                                                    Import Symbols
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Resources">
                                                    Resources
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Exception">
                                                    Exception
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Security">
                                                    Security
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Base_Relocation">
                                                    Base Relocation
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Debug">
                                                    Debug
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Architecture">
                                                    Architecture
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Copyright_String">
                                                    Copyright String
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Unknown">
                                                    Unknown
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Thread_Local_Storage">
                                                    Thread Local Storage
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Local_Configuration">
                                                    Local Configuration
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Import_Address_Table">
                                                    Import Address Table
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:Delay_Import">
                                                    Delay Import
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="maec:COM_Descriptor">
                                                    COM Descriptor
                                                    <xsl:call-template name="processDataDirectoryStruct"/>
                                                </xsl:for-each>
                                            </xsl:for-each>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:if>

                            </xsl:for-each>
                        </xsl:if>  
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="maec:Strings">
                    <span>Strings</span>
                    <xsl:for-each select="maec:Strings/maec:String">
                        <table id="one-column-emphasis">
                            <colgroup>
                                <col class="oce-first" />
                            </colgroup>
                            <tbody>
                                <xsl:if test="@address">
                                    <tr>
                                        <td>Address</td>
                                        <td><xsl:value-of select="@address"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="@encoding">
                                    <tr>
                                        <td>Encoding</td>
                                        <td><xsl:value-of select="@encoding"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="@length">
                                    <tr>
                                        <td>Length (characters)</td>
                                        <td><xsl:value-of select="@length"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="maec:String_Value">
                                    <tr>
                                        <td>Value</td>
                                        <td><xsl:value-of select="maec:String_Value"/></td>
                                    </tr>
                                </xsl:if>
                            </tbody>
                        </table><br/>
                        <xsl:if test="maec:Hashes">
                            <xsl:for-each select="maec:Hashes">
                                <xsl:call-template name="processHashes"/>
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
                
                <xsl:if test="maec:Imports">
                    <span>Imports</span>
                    <table id="hor-minimalist-a">
                        <thead>
                            <tr>
                                <th scope="col">Type</th>
                                <th scope="col">Delay Load</th>
                                <th scope="col">File Name</th>
                                <th scope="col">Virtual Address</th>
                            </tr>
                        </thead>
                    <xsl:for-each select="maec:Imports/maec:Import">
                        <TR>
                            <xsl:choose>
                                <xsl:when test="@type">
                                     <td><xsl:value-of select="@type"/></td>
                                </xsl:when>
                                <xsl:otherwise>
                                    <td>N/A</td>
                                </xsl:otherwise>
                             </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="@delay_load">
                                    <td><xsl:value-of select="@delay_load"/></td>
                                </xsl:when>
                                <xsl:otherwise>
                                    <td>N/A</td>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="maec:File_Name">
                                    <td><xsl:value-of select="maec:File_Name"/></td>
                                </xsl:when>
                                <xsl:otherwise>
                                    <td>N/A</td>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="maec:Virtual_Address">
                                    <td><xsl:value-of select="maec:Virtual_Address"/></td>
                                </xsl:when>
                                <xsl:otherwise>
                                    <td>N/A</td>
                                </xsl:otherwise>
                            </xsl:choose>
                        </TR>  
                    </xsl:for-each>
                    </table>
                    
                    <xsl:if test="maec:Imports/maec:Import/maec:Imported_Functions">
                        <span>Imported Functions</span>
                    </xsl:if>
                    
                    <xsl:for-each select="maec:Imports/maec:Import">
                        <xsl:if test="maec:Imported_Functions">
                            <table id="one-column-emphasis">
                                <colgroup>
                                    <col class="oce-first" />
                                </colgroup>
                                <tbody>
                                    <xsl:if test="maec:File_Name">
                                        <tr>
                                            <td>File Name</td>
                                            <td><xsl:value-of select="maec:File_Name"/></td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:for-each select="maec:Imported_Functions/maec:Imported_Function">
                                                <xsl:if test="maec:Function_Name">
                                                    <tr>
                                                        <td>Function Name</td>
                                                        <td><xsl:value-of select="maec:Function_Name"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Virtual_Address">
                                                    <tr>
                                                        <td>Virtual Address</td>
                                                        <td><xsl:value-of select="maec:Virtual_Address"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Hint">
                                                    <tr>
                                                        <td>Hint</td>
                                                        <td><xsl:value-of select="maec:Hint"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="maec:Ordinal">
                                                    <tr>
                                                        <td>Ordinal</td>
                                                        <td><xsl:value-of select="maec:Ordinal"/></td>
                                                    </tr>
                                                </xsl:if>
                                        </xsl:for-each>
                                </tbody>
                            </table> <br/> 
                          </xsl:if>
                      </xsl:for-each>
                    </xsl:if>

                <xsl:if test="maec:Exports">
                    <span>Exports</span>
                    <table id="hor-minimalist-a">
                        <thead>
                            <tr>
                                <th scope="col">Function Name</th>
                                <th scope="col">Entry Point</th>
                                <th scope="col">Ordinal</th>
                            </tr>
                        </thead>
                        <TR>
                            <xsl:for-each select="maec:Exports/maec:Export">
                                <xsl:choose>
                                    <xsl:when test="maec:Function_Name">
                                        <td><xsl:value-of select="maec:Function_Name"/></td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td>N/A</td>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:choose>
                                    <xsl:when test="maec:Entry_Point">
                                        <td><xsl:value-of select="maec:Entry_Point"/></td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td>N/A</td>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:choose>
                                    <xsl:when test="maec:Ordinal">
                                        <td><xsl:value-of select="maec:Ordinal"/></td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td>N/A</td>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>   
                        </TR>
                    </table>
                </xsl:if>
                
                <xsl:if test="maec:Resources">
                    <span>Resources</span>
                    <xsl:for-each select="maec:Resources/maec:Resource">
                        Resource
                        <table id="one-column-emphasis">
                            <colgroup>
                                <col class="oce-first" />
                            </colgroup>
                            <tbody>
                                <xsl:if test="@type">
                                    <tr>
                                        <td>Type</td>
                                        <td><xsl:value-of select="@type"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="maec:Name">
                                    <tr>
                                        <td>Name</td>
                                        <td><xsl:value-of select="maec:Name"/></td>
                                    </tr>
                                </xsl:if>
                            </tbody>
                        </table>
                        <br/>
                        <xsl:if test="maec:Hashes">
                            <xsl:for-each select="maec:Hashes">
                                <xsl:call-template name="processHashes"/>
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:for-each>        
                    <br/>        
                </xsl:if>
                
                <xsl:if test="maec:Sections">
                    <span>Sections</span>
                    <xsl:for-each select="maec:Sections/maec:Sections">
                        <xsl:if test="maec:Header_Hashes">
                            Header Hashes
                            <xsl:for-each select="maec:Header_Hashes">
                                <xsl:call-template name="processHashes"/>
                            </xsl:for-each>
                        </xsl:if>
                        
                        <xsl:if test="maec:Data_Hashes">
                            Header Hashes
                            <xsl:for-each select="maec:Header_Hashes">
                                <xsl:call-template name="processHashes"/>
                            </xsl:for-each>
                        </xsl:if>
                        
                        <table id="one-column-emphasis">
                            <colgroup>
                                <col class="oce-first" />
                            </colgroup>
                            <tbody>
                                <xsl:if test="maec:Section_Name">
                                    <tr>
                                        <td>Name</td>
                                        <td><xsl:value-of select="maec:Section_Name"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="maec:Entropy">
                                    <tr>
                                        <td>Entropy</td>
                                        <td><xsl:value-of select="maec:Entropy"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="maec:Virtual_Address">
                                    <tr>
                                        <td>Virtual Address</td>
                                        <td><xsl:value-of select="maec:Virtual_Address"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="maec:Virtual_Address">
                                    <tr>
                                        <td>Virtual Size</td>
                                        <td><xsl:value-of select="maec:Virtual_Size"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="maec:Flags">
                                    <tr>
                                        <td>Flags</td>
                                        <td><xsl:value-of select="maec:Flags"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="maec:Relocations">
                                    <tr>
                                        <td>Relocations</td>
                                        <td><xsl:value-of select="maec:Relocations"/></td>
                                    </tr>
                                </xsl:if>
                            </tbody>
                        </table>
                    </xsl:for-each>        
                    <br/>        
                </xsl:if>
                
                <xsl:if test="maec:Digital_Certificates">
                    <span>Digital Certificates</span>
                    <table id="hor-minimalist-a">
                        <thead>
                            <tr>
                                <th scope="col">Issuer</th>
                                <th scope="col">Validity</th>
                            </tr>
                        </thead>
                        <TR>
                         <xsl:for-each select="maec:Digital_Certificates/maec:Certificate">
                             <xsl:choose>
                                 <xsl:when test="maec:Ordinal">
                                     <td><xsl:value-of select="maec:Ordinal"/></td>
                                 </xsl:when>
                                 <xsl:otherwise>
                                     <td>N/A</td>
                                 </xsl:otherwise>
                             </xsl:choose>
                             <xsl:choose>
                                 <xsl:when test="@validity">
                                     <td><xsl:value-of select="@validity"/></td>
                                 </xsl:when>
                                 <xsl:otherwise>
                                     <td>N/A</td>
                                 </xsl:otherwise>
                             </xsl:choose>
                             <xsl:choose>
                                 <xsl:when test="maec:Issuer">
                                     <td><xsl:value-of select="maec:Issuer"/></td>
                                 </xsl:when>
                                 <xsl:otherwise>
                                     <td>N/A</td>
                                 </xsl:otherwise>
                             </xsl:choose>
                         </xsl:for-each>
                        </TR>
                     </table>
                    <br/>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
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
    
    <xsl:template name="processHashes">
        <b>Hashes</b>
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:for-each select="maec:Hash">
                    <tr>
                        <xsl:choose>
                            <xsl:when test="@other_type">
                                <td><xsl:value-of select="@other_type"/></td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td><xsl:value-of select="@type"/></td>
                            </xsl:otherwise>
                        </xsl:choose>
                        <td><xsl:value-of select="maec:Hash_Value"/></td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table> <br/>
    </xsl:template>
    
    <xsl:template name="processGUIObjectAttributes">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:Width">
                    <tr>
                        <td>Width</td>
                        <td><xsl:value-of select="maec:Width"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Height">
                    <tr>
                        <td>Height</td>
                        <td><xsl:value-of select="maec:Height"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Window_Display_Name">
                    <tr>
                        <td>Window Display Name</td>
                        <td><xsl:value-of select="maec:Window_Display_Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Parent_Window">
                    <tr>
                        <td>Parent Window</td>
                        <td><xsl:value-of select="maec:Parent_Window"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Parent_Window">
                    <tr>
                        <td>Owner Window</td>
                        <td><xsl:value-of select="maec:Owner_Window"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Box_Text">
                    <tr>
                        <td>Message Box Text</td>
                        <td><xsl:value-of select="maec:Box_Text"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Box_Caption">
                    <tr>
                        <td>Message Box Caption</td>
                        <td><xsl:value-of select="maec:Box_Caption"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> <br/>
    </xsl:template>
    
    <xsl:template name="processIPCObjectAttributes">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:Security_Attributes">
                    <tr>
                        <td>Security Attributes</td>
                        <td><xsl:value-of select="maec:Security_Attributes"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Event_Type">
                    <tr>
                        <td>Event Type</td>
                        <td><xsl:value-of select="maec:Event_Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Thread_ID">
                    <tr>
                        <td>Thread ID</td>
                        <td><xsl:value-of select="maec:Thread_ID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Start_Address">
                    <tr>
                        <td>Start Address</td>
                        <td><xsl:value-of select="maec:Start_Address"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> <br/>
    </xsl:template>
    
    <xsl:template name="processInternetObjectAttributes">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:URI">
                    <tr>
                        <td>URL</td>
                        <td><xsl:value-of select="maec:URI/metadata:uriString"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:AS_Number">
                    <tr>
                        <td>Autonomous System (AS) Number</td>
                        <td><xsl:value-of select="maec:AS_Number"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> <br/>
    </xsl:template>
    
    <xsl:template name="processModuleObjectAttributes">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:Library_Type">
                    <tr>
                        <td>Module/Library Type</td>
                        <td><xsl:value-of select="maec:Library_Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Library_File_Name">
                    <tr>
                        <td>Module/Library File Name</td>
                        <td><xsl:value-of select="maec:Library_File_Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Version">
                    <tr>
                        <td>Module/Library Version</td>
                        <td><xsl:value-of select="maec:Version"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> <br/>
    </xsl:template>
    
    <xsl:template name="processRegistryObjectAttributes">
        <b>Registry Key</b>
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:Hive">
                    <tr>
                        <td>Hive</td>
                        <td><xsl:value-of select="maec:Hive"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Key">
                    <tr>
                        <td>Key</td>
                        <td><xsl:value-of select="maec:Key"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> <br/>
        <xsl:if test="maec:Value">
            <b>Registry Value</b>
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:if test="maec:Value/@type">
                        <tr>
                            <td>Type</td>
                            <td><xsl:value-of select="maec:Value/@type"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Value/maec:Value_Name">
                        <tr>
                            <td>Name</td>
                            <td><xsl:value-of select="maec:Value/maec:Value_Name"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="maec:Value/maec:Value_Data">
                        <tr>
                            <td>Value</td>
                            <td><xsl:value-of select="maec:Value/maec:Value_Data"/></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table> <br/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processProcessObjectAttributes">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:Image_Name">
                    <tr>
                        <td>Image Name</td>
                        <td><xsl:value-of select="maec:Image_name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Current_Directory">
                    <tr>
                        <td>Current Directory</td>
                        <td><xsl:value-of select="maec:Current_Directory"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Command_Line">
                    <tr>
                        <td>Command Line</td>
                        <td><xsl:value-of select="maec:Command_Line"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Security_Attributes">
                    <tr>
                        <td>Security Attributes</td>
                        <td><xsl:value-of select="maec:Security_Attributes"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Process_ID">
                    <tr>
                        <td>Process ID (PID)</td>
                        <td><xsl:value-of select="maec:Process_ID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Start_Username">
                    <tr>
                        <td>Startup Username</td>
                        <td><xsl:value-of select="maec:Start_Username"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Start_Address">
                    <tr>
                        <td>Start Address</td>
                        <td><xsl:value-of select="maec:Start_Address"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> 
        <xsl:if test="maec:Handles">
            <br/>
            <b>Handles</b>
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:for-each select="maec:Handles/maec:Handle">
                        <tr>
                            <td>Name</td>
                            <td><xsl:value-of select="maec:Name"/></td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table> 
        </xsl:if>
        
       <!-- <xsl:if test="maec:Parent_Process">
            <b>Parent Process</b>
            <xsl:for-each select="key('objectID',maec:Parent_Process/@object_id)">
                <xsl:call-template name="processObjectSecondary"/><br/>
            </xsl:for-each>
        </xsl:if>
        <xsl:if test="maec:Child_Processes">
            <b>Child Processes</b>
            <xsl:for-each select="maec:Child_Processes/maec:Child_Process">
                <xsl:for-each select="key('objectID',@object_id)">
                    <xsl:call-template name="processObjectSecondary"/><br/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:if>-->
    </xsl:template>
    
    <xsl:template name="processProcessObjectAttributesSecondary">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:Image_Name">
                    <tr>
                        <td>Image Name</td>
                        <td><xsl:value-of select="maec:Image_name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Current_Directory">
                    <tr>
                        <td>Current Directory</td>
                        <td><xsl:value-of select="maec:Current_Directory"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Command_Line">
                    <tr>
                        <td>Command Line</td>
                        <td><xsl:value-of select="maec:Command_Line"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Security_Attributes">
                    <tr>
                        <td>Security Attributes</td>
                        <td><xsl:value-of select="maec:Security_Attributes"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Process_ID">
                    <tr>
                        <td>Process ID (PID)</td>
                        <td><xsl:value-of select="maec:Process_ID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Start_Username">
                    <tr>
                        <td>Startup Username</td>
                        <td><xsl:value-of select="maec:Start_Username"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Start_Address">
                    <tr>
                        <td>Start Address</td>
                        <td><xsl:value-of select="maec:Start_Address"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> 
        <xsl:if test="maec:Handles">
            <br/>
            <b>Handles</b>
            <table id="one-column-emphasis">
                <colgroup>
                    <col class="oce-first" />
                </colgroup>
                <tbody>
                    <xsl:for-each select="maec:Handles/maec:Handle">
                        <tr>
                            <td>Name</td>
                            <td><xsl:value-of select="maec:Name"/></td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table> 
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processMemoryObjectAttributes">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:Memory_Block_ID">
                    <tr>
                        <td>Memory Block ID</td>
                        <td><xsl:value-of select="maec:Memory_Block_ID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Start_Address">
                    <tr>
                        <td>Start Address</td>
                        <td><xsl:value-of select="maec:Start_Address"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> 
    </xsl:template>
    
    <xsl:template name="processNetworkObjectAttributes">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:Internal_Port">
                    <tr>
                        <td>Internal Port</td>
                        <td><xsl:value-of select="maec:Internal_Port"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:External_Port">
                    <tr>
                        <td>External Port</td>
                        <td><xsl:value-of select="maec:External_Port"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Socket_Type">
                    <tr>
                        <td>Socket Type</td>
                        <td><xsl:value-of select="maec:Socket_Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Socket_ID">
                    <tr>
                        <td>Socket ID</td>
                        <td><xsl:value-of select="maec:Socket_ID"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Internal_IP_Address">
                    <tr>
                        <td>Internal IP Address</td>
                        <td><xsl:value-of select="maec:Internal_IP_Address"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:External_IP_Address">
                    <tr>
                        <td>External IP Address</td>
                        <td><xsl:value-of select="maec:External_IP_Address"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:IP_Protocol">
                    <tr>
                        <td>IP Protocol</td>
                        <td><xsl:value-of select="maec:IP_Protocol"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Application_Layer_Protocol">
                    <tr>
                        <td>Layer 7 (Application) Protocol</td>
                        <td><xsl:value-of select="maec:Application_Layer_Protocol"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> 
    </xsl:template>
    
    <xsl:template name="processDaemonObjectAttributes">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:if test="maec:Service_Type">
                    <tr>
                        <td>Service Type</td>
                        <td><xsl:value-of select="maec:Service_Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Start_Type">
                    <tr>
                        <td>Start Type</td>
                        <td><xsl:value-of select="maec:Start_Type"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Display_Name">
                    <tr>
                        <td>Display_Name</td>
                        <td><xsl:value-of select="maec:Display_Name"/></td>
                    </tr>
                </xsl:if>
                <xsl:if test="maec:Load_Order_Group">
                    <tr>
                        <td>Load Order Group</td>
                        <td><xsl:value-of select="maec:Load_Order_Group"/></td>
                    </tr>
                </xsl:if>
            </tbody>
        </table> 
        <xsl:if test="maec:Daemon_Binary_Object">
            <br/>
            <b>Service/Daemon Binary Object</b>
            <xsl:for-each select="maec:Daemon_Binary_Object">
                <xsl:call-template name="processObject"/><br/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="processCustomObjectAttributes">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:for-each select="maec:Custom_Attribute">
                    <tr>
                        <td><xsl:value-of select="maec:custom_attribute_name"/></td>
                        <td><xsl:value-of select="."/></td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template name="processAssociatedCode">
        <xsl:for-each select="maec:Associated_Code_Snippet">
            <b>Associated Code Snippet</b>
            <table id="hor-minimalist-a">
                <thead>
                    <tr>
                        <th scope="col">Code Type</th>
                        <th scope="col">Language</th>
                        <th scope="col">Start Address</th>
                        <th scope="col">Processor Family</th>
                        <th scope="col">XOR Pattern</th>
                    </tr>
                    <xsl:choose>
                        <xsl:when test="maec:Code_Snippet/@codetype">
                            <td><xsl:value-of select="maec:Code_Snippet/@codetype"/></td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td>N/A</td>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="maec:Code_Snippet/@language">
                            <td><xsl:value-of select="maec:Code_Snippet/@language"/></td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td>N/A</td>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="maec:Code_Snippet/@start_address">
                            <td><xsl:value-of select="maec:Code_Snippet/@start_address"/></td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td>N/A</td>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="maec:Code_Snippet/@processor_family">
                            <td><xsl:value-of select="maec:Code_Snippet/@processor_family"/></td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td>N/A</td>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="maec:Code_Snippet/@xor_pattern">
                            <td><xsl:value-of select="maec:Code_Snippet/@xor_pattern"/></td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td>N/A</td>
                        </xsl:otherwise>
                    </xsl:choose>
                </thead>
            </table> <br/>
            <xsl:if test="maec:Nature_Of_Relationship">
                <xsl:value-of select="maec:Nature_Of_Relationship"/>
            </xsl:if>
            <xsl:if test="maec:Code_Snippet/maec:Code_Segment">
                <div id="inner_container">
                    <xsl:value-of select="maec:Code_Snippet/maec:Code_Segment"/>
                </div> <br/>
            </xsl:if>
            <xsl:if test="maec:Code_Snippet/maec:Code_Segment_XOR">
                <div id="inner_container">
                    <xsl:value-of select="maec:Code_Snippet/maec:Code_Segment_XOR"/>
                </div> <br/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="processDescription">
        <table id="one-column-emphasis">
            <colgroup>
                <col class="oce-first" />
            </colgroup>
            <tbody>
                <xsl:for-each select="maec:Text_Title">
                    <tr>
                        <td>Title</td>
                        <td><xsl:value-of select="."/></td>
                    </tr>
                </xsl:for-each>
                <xsl:for-each select="maec:Text">
                    <tr>
                        <td>Text</td>
                        <td><xsl:value-of select="."/></td>
                    </tr>
                </xsl:for-each>
                <xsl:for-each select="maec:Code_Example_Language">
                    <tr>
                        <td>Code Example Language</td>
                        <td><xsl:value-of select="."/></td>
                    </tr>
                </xsl:for-each>
                <xsl:for-each select="maec:Code">
                    <tr>
                        <td>Code</td>
                        <td><xsl:value-of select="."/></td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table> <br/>
    </xsl:template>
</xsl:stylesheet>
