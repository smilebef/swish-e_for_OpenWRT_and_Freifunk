#!/bin/sh

echo Content-type: text/html
echo
echo '
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
        
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-US">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
    <link rel="stylesheet" type="text/css" href="/swish.css" media="screen" title="swish css" />
    <link rel="shortcut icon"  href="/favicon.ico" type="image/x-icon" />
    
    <link rel="Last" href="../swish-e/doc/filter.html" />
    <link rel="Prev" href="../swish-e/doc/swish-3.0.html" />
    <link rel="Up" href="." />
    <link rel="Next" href="." />
    <link rel="Start" href="." />
    <link rel="First" href="." />

<title>Swish-e :: SWISH-LIBRARY - Interface to the Swish-e C library</title>
</head>
<body>
<!-- noindex -->
<!-- For non-visual user agents: -->
<div id="top"><a href="#main-copy" class="doNotDisplay doNotPrint">Skip to main content.</a></div>

<div id="header">
 <div class="superHeader">
  <span>Related Sites:</span>
    <a href="http://swishewiki.org/" title="swishe wiki">swish-e wiki</a> |
    <a href="http://www.xmlsoft.org/" title="libxml2 home page">libxml2</a> |
    <a href="http://www.zlib.net/" title="zlib home page">zlib</a> |
    <a href="http://www.foolabs.com/xpdf/" title="xpdf home page">xpdf</a> |
    <a href="http://dev.swish-e.org/browser" title="browse source code">Subversion</a>
   </div>

   <div class="midHeader">
        <h1 class="headerTitle" lang="la">Swish-e</h1>
        <div class="headerSubTitle">Simple Web Indexing System for Humans - Enhanced</div>

        <br class="doNotDisplay doNotPrint" />

        <div class="headerLinks">
          <span class="doNotDisplay">Tools:</span>
              <!-- dont know what platform, so link to download page -->
              <a  href="/"><h1>Luci</h1></a>
		<!CGI-script von smilie/ 
		swish-e.css bei doc/swish-e/ entnommen.>
        </div>
      </div>
    </div>

<!-- noindex -->
<div class="subHeader">
    <table width='100%'>
        <tr>
            <td align='left'>
                <a href="http://swish-e.org/index.html">home</a> |
                <a href="http://swish-e.org/support.html">support</a> |
                <a href="http://swish-e.org/download/index.html">download</a>
            </td>
            <td align='right'>
                <form method="get"
                    action="/cgi-bin/swish-e.cgi" 
                    spellcheck="true" 
                    enctype="application/x-www-form-urlencoded" 
                    class="srchform"> 

                    <label for="searchfield">swish-e search local for</label>
                    <input maxlength="200" placeholder="Suchbegriff"  value="'
query=`echo $QUERY_STRING | tr "&" "\n" | grep "query=" | sed "s/query=//" |sed "s/*/?/g" | sed "s/;/?/g" | sed "s/[|]/?/g" | sed "s/[\]/?/g" | sed "s/'//g" | sed "s/%21/!/g" | sed 's/%22/"/g' | sed "s/%23/#/g" | sed "s/%24/?/g"  | sed "s/%26/?/g" | sed "s/%27/'/g"  | sed 's/%28/(/g' | sed "s/%29/)/g" | sed "s/%2A/*/g" | sed "s/%2B/+/g" | sed "s/%2C/,/g" | sed "s/%2D/-/g" | sed "s/%2E/./g" | sed 's;%2F;/;g' | sed 's/%3A/:/g' | sed 's/%3B/;/g' | sed 's/%3C/</g' | sed 's/%3D/=/g'| sed 's/%3E/>/g' | sed 's/%3F/?/g'| sed 's/%5B/[/g' | sed 's/%5C/?/g' | sed 's/%5D/]/g'| sed 's/%5E/^/g' | sed 's/%5F/_/g' | sed 's/%7B/{/g' | sed 's/%7C/?/g'| sed 's/%7D/}/g'| sed 's/%7E/~/g' | sed 's/%60/?/g' | sed 's/%25/%/g'`
htmlquery=`echo $query | sed 's/"/\&quot;/g'` 
echo $htmlquery
echo '"
                    id="searchfield"  size="30" name="query"  type="text" alt="Search input field" />
                </form>

            </td>            
        </tr>
        <tr>
        <td>
<hr>
        </td>
        <td>                                                                                                                                   
<hr>                                                                                                                                           
        </td>  
        </tr>

        <tr>
        <td align='left'>
              <form action="swish-e_sync_olsr.sh">
                  <input type="submit"                                                                                                             
                  value="Indexdateien im OLSR-Netz jetzt syncronisieren" >
              </form>
        </td>
        <td align='right'>
        <form action="swish-e_index.sh">
              <input type="submit"
               value="Datenbestand (txt,html,doc,xls,ppt,pdf) jetzt indizieren"  >
               </form>
        </td>
        </tr>
    </table>
</div>
<!-- index -->
'
#query=`echo $QUERY_STRING | tr "&" "\n" | grep "query=" | sed "s/query=//" |sed "s/*/?/g" | sed "s/;/?/g" | sed "s/[|]/?/g" | sed "s/[\]/?/g" | sed "s/'//g" | sed "s/%21/!/g" | sed 's/%22/"/g' | sed "s/%23/#/g" | sed "s/%24/?/g"  | sed "s/%26/?/g" | sed "s/%27/'/g"  | sed 's/%28/(/g' | sed "s/%29/)/g" | sed "s/%2A/*/g" | sed "s/%2B/+/g" | sed "s/%2C/,/g" | sed "s/%2D/-/g" | sed "s/%2E/./g" | sed 's;%2F;/;g' | sed 's/%3A/:/g' | sed 's/%3B/;/g' | sed 's/%3C/</g' | sed 's/%3D/=/g'| sed 's/%3E/>/g' | sed 's/%3F/?/g'| sed 's/%5B/[/g' | sed 's/%5C/?/g' | sed 's/%5D/]/g'| sed 's/%5E/^/g' | sed 's/%5F/_/g' | sed 's/%7B/{/g' | sed 's/%7C/?/g'| sed 's/%7D/}/g'| sed 's/%7E/~/g' | sed 's/%60/?/g' | sed 's/%25/%/g'`
#htmlquery=`echo $query | sed 's/"/\&quot;/g'`

#echo "Query" $query
#echo "HTMLQuery" $htmlquery

'
<table border="0" ><tr><th width="100%" align="left">Locale Suche nach:</th><th><a  href="/">Luci</a></th></tr></table>
<em> '$query'
</em>
<!hr>'


#echo $htmlquery
echo '

<!hr>
<p><pre>
'
#for i in swish-e/indexfiles/local/*[^prop];
#i=swish-e/indexfiles/local/index.swish-e
#    do
    #ii=`echo $i | sed "s;swish-e/indexfiles/local/;;1"`
    #echo "Indexfile: "$ii
    #ausgabe=`swish-e  -f swish-e/indexfiles/$ii -x '\<br\>%c -\> \<a href="%p"\>%t\</a\>\<br\>\n\<blockquote\>Groesse: %l  Ranking: %r\</blockquote\>' -w "'"$query"'" | sed 's;/www;;1' | sed 's;#;"<br>#;1'`
    #ausgabe=`swish-e  -f swish-e/indexfiles/merge/index.swish-e -x '\<br\>%c. Rang: \<em\>%r\</em\> -\> \<a href="%p"\>%t\</a\>   Groesse: %l \<br\>\n' -w "'"$query"'" | sed 's;/./;/;g' | sed 's;/www;;1' | sed 's;#;"<br># ;1'`
    #echo $ausgabe
#    done
echo `swish-e  -f swish-e/indexfiles/merge/index.swish-e -x '\<br\>%c. Rang: \<em\>%r\</em\> -\> \<a href="%p"\>%t\</a\>   Groesse: %l \<br\>\n' -w "'"$query"'" | sed 's;/./;/;g' | sed 's;/www;;1' | sed 's;#;"<br># ;1'`
echo '
</pre></p>
<hr>
<!-- /#footer -->
Powered by OpenWRT + swish-e + (:
</body></html>'
