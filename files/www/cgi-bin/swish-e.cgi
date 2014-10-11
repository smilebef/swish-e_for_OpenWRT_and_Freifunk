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

                    <label for="searchfield">local swish-e search tool:</label>
                    <input maxlength="200" placeholder="Suchbegriff"  value="'
query=`echo $QUERY_STRING | tr "&" "\n" | grep "query=" | sed "s/query=//" | sed 's/*/?/g' | sed "s/;/?/g" | sed "s/[|]/?/g" | sed "s/[\]/?/g" | sed "s/'//g" | sed "s/%21/!/g" | sed 's/%22/"/g' | sed "s/%23/#/g" | sed "s/%24/?/g"  | sed "s/%26/?/g" | sed "s/%27/'/g"  | sed 's/%28/(/g' | sed "s/%29/)/g" | sed "s/%2A/*/g" | sed "s/%2B/+/g" | sed "s/%2C/,/g" | sed "s/%2D/-/g" | sed "s/%2E/./g" | sed 's;%2F;/;g' | sed 's/%3A/:/g' | sed 's/%3B/;/g' | sed 's/%3C/</g' | sed 's/%3D/=/g'| sed 's/%3E/>/g' | sed 's/%3F/?/g'| sed 's/%5B/[/g' | sed 's/%5C/?/g' | sed 's/%5D/]/g'| sed 's/%5E/^/g' | sed 's/%5F/_/g' | sed 's/%7B/{/g' | sed 's/%7C/?/g'| sed 's/%7D/}/g'| sed 's/%7E/~/g' | sed 's/%60/?/g' | sed 's/%25/%/g' | sed 's/\&quot;/"/g' | sed 's/+/ /g' `

htmlquery=`echo $query | sed 's/"/\&quot;/g'  ` 
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




#query='swish "path or ref to a doc content"'


nix=hslfdsuiroewt
phrase=$nix
phrase=`echo ' '$query' ' | sed   's/^[^"]*"//1' | sed 's/"[^$]*$//1' `
netto=`echo $query | sed 's/"[^"]*"//g' | sed 's/ or / /g' | sed 's/ and / /g' | sed 's/ not / /g' `
brutto=`echo $netto ; echo $phrase ` 
bruttodick=`echo $brutto | sed 's/ [a-zA-Z] / /g' | sed 's/ href / /g' | sed 's/ hr / /g' | sed 's/ ef / /g' | sed 's/^[a-zA-Z] / /g' | sed 's/^href / /g' | sed 's/^hr / /g' | sed 's/^ef / /g' | sed 's/ [a-zA-Z]$/ /g' | sed 's/ href$/ /g' | sed 's/ hr$/ /g' | sed 's/ ef$/ /g'`


#j=0

#for i in $brutto; do
#        export dick$j=`echo  $i | sed 's/^[a-zA-Z]$/'$nix'/g' | sed 's/^href$/'$nix'/g' | sed 's/^hr$/'$nix'/g' | sed 's/^ef$/'$nix'/g'  ` 
#	k=$j
#	max=$max" "$j
#        j=` dc $j 1 add p`
#done  



#echo "Query "$query'<br>'
oldquery=$query
#j=0
#echo "Phrase "$phrase
#for i in $phrase; do
#	export query$j=$i
#	j=` dc $j 1 add p`
#done

# zum Debuggen

echo '<br>'
#echo 'oqu '$oldquery'<br>'
#echo 'qu '$query'<br>'
#echo 'ph '$phrase'<br>'
#echo 'ne '$netto'<br>'
#echo 'br '$brutto'<br>'
#echo 'brd '$bruttodick'<br>'
#echo '<hr>'

oldquery="'"$oldquery"'"
#echo 'oqu '$oldquery'<br>'
#echo '<hr>'
#
# Swish Ausgabe mit swish -f index -x 'Zeichenkette' -w ''Wort''
raw=`        swish-e -f data/indexfiles/merge/index.swish-e -x 'path:=:%p:=:pathtitle:=:%t:=:titledesc:=:%d:=:desc' -w $oldquery   | sed 's/\&/\&amp;/g' | sed  's/</\&lt;/g' | sed 's/\&/\&amp;/g' | sed  's/</\&lt;/g' | sed  's/>/\&gt;/g' | sed  's/path:=:/<hr>\r\npath:=:/g' | sed  's/desc:=:/\r\n<! desc:=:1>/g' `
#raw=`        swish-e -f swish-e/indexfiles/merge/index.swish-e -x '{"path","%p","title","%t","desc","%d"}' -w "'$oldquery'" 
#echo $raw

#   | sed 's/\&/\&amp;/g' | sed  's/</\&lt;/g' | sed  's/>/\&gt;/g' | sed  's/path:=:/<hr>\r\npath:=:/g' | sed  's/desc:=:/\r\n<! desc:=:1>/g' `
#
# wird gefiltert nach HTML-Zeichen &,<,>
# vor path:=: und desc:=: wird umgebrochen,
# aus desc:=: wird <! desc:=:1>
#
# Der Hyperlink wird eingefügt
veryrare=`   echo ''$raw''             |   sed  's/path:=:/<a href="http:\/\//g' | sed  's/:=:pathtitle:=:/">/g'  | sed   's/:=:title/<\/a>/g'  | sed  's/# SWISH format/<!--/g'  | sed 's/seconds <hr>/-->/g' `
#
# Ein <div style> wird eingefuegt und umgebrochen,
rare=`       echo ''$veryrare''        |   sed   '/<! desc:=:1>/ s/\(<! desc:=:1>\)/<div style="font-size:70%; font-family:Verdana">\r\n\1/g' | sed  's/:=:desc/\r\n\r\n<! :=:desc><\/div>\r\n/g'`
# :=:desc wird zu <! :=:desc>
#
# Deaktiviert, sed kann vermutlich nicht so viele Zeichen pro Zeile. So geht es auch.
#mediumrare=` echo ''$rare''            |   sed    '/<! desc:=:1>/ s/\(<! desc:=:1>.\{100,'$zahl'\}\) \([^\$]*\)/ \1 <br>\r\n<! desc:=:2>\2/g' ` 
#medium=`     echo ''$mediumrare''      |   sed    '/<! desc:=:2>/ s/\(<! desc:=:2>.\{'$zahl'\}\)\([^\$]*\)/ \1 <br>\r\n<! desc:=:3>\2/g' `
#mediumwell=` echo ''$medium''          |   sed    '/<! desc:=:3>/ s/\(<! desc:=:3>.\{'$zahl'\}\)/ \1 <br>\r\n<br>\r\n<!--  -->/g' `
#well=`       echo ''$mediumwell'' ` #     |   sed   's/\(^<! desc:=:4>[^$]*$\)//g' `
# gesonderte Darstellung von Phrasen wurde entfernt.
#
# Worte Fett zeichnen.
IFS=$'
'
for line in $rare
	do
	IFS=$' '
	for k in $bruttodick
		do
		line=`echo $line | sed   '/desc:=:/ s/'$k'/<b>'$k'<\/b>/g'`
		done
	echo $line
	#ausgabe=`echo $line  |   sed   "/desc:=:/ s/$dick0/<b>$dick0<\/b>/g" | sed '/desc:=:/ s/'$dick1'/<b>'$dick1'<\/b>/g' | sed '/desc:=:/ s/'$dick2'/<b>'$dick2'<\/b>/g' `
	#echo $ausgabe
	IFS=$'
'
	done
IFS=$' '




echo '
<hr>
<!-- /#footer -->
Powered by OpenWRT + swish-e + (:
</body></html>
'
