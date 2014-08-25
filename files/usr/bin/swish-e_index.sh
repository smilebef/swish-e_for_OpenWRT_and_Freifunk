#!/bin/sh

echo Content-type: text/html
echo
echo '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<head>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
<title>Indizierung aller localen Daten</title>
</head>'
echo "<html><body>"
echo
echo "<hr>"
echo "<pre>"



cat /etc/swish-e/swish.conf | sed s/Kotzbrocken/`uci get network.unicast.ipaddr`/ > /var/etc/swish-e.conf



indexdir="/www/swish-e/indexfiles"
logfile="/www/swish-e/swish-e.log"

echo "Beginne mit dem Indizierprozess" > $logfile

Liste=`cd $indexdir/global/ && ls` 2>&1 >> $logfile

Listemerge=""
for i in $Liste; 
do
	Listemerge=$Listemerge" $indexdir/global/$i/index.swish-e"   2>&1 >> $logfile
done

echo "Listemerge = "$Listemerge 2>&1 >> $logfile

Listemerge=$Listemerge" $indexdir/local/index.swish-e "

echo `rm $indexdir/merge/index.swish-e  2>&1 >> $logfile`
echo `rm $indexdir/merge/index.swish-e.prop  2>&1 >> $logfile`


#echo '<a href="/">Zur&uuml;ck</a> <br />'
echo "Beginne mit Indizieren, erstelle Prüfsummen und merge externe indexfiles zusammen. <br />"
echo 'Der Stand der Indizierung kann/muss unter <a href="/swish-e/swish-e.log">Logdatei</a> eingesehen werden. <br />'
echo 'Die abschliessende Meldung muss lauten "indizieren erfolgreich abgeschlossen"... <br />'
echo `swish-e -e -c /var/etc/swish-e.conf -f /www/swish-e/indexfiles/local/index.swish-e -i /www/*  2>&1 >> $logfile && md5sum /www/swish-e/indexfiles/local/index.swish-e > /www/swish-e/indexfiles/local/index.swish-e.md5sums && md5sum /www/swish-e/indexfiles/local/index.swish-e.prop >> /www/swish-e/indexfiles/local/index.swish-e.md5sums && swish-e -e -M $Listemerge $indexdir/merge/index.swish-e 2>&1 >> $logfile && echo "indizieren erfolgreich abgeschlossen" >> $logfile &`
echo "... Indizieren abgeschlossen ."
#echo "Erzeuge Md5sum ..."
#echo `md5sum /www/swish-e/indexfiles/local/index.swish-e > /www/swish-e/indexfiles/local/index.swish-e.md5sums`
#echo `md5sum /www/swish-e/indexfiles/local/index.swish-e.prop >> /www/swish-e/indexfiles/local/index.swish-e.md5sums`
echo "</pre>"
#echo "<br>... Md5sum erneuert.<br>"
echo "<hr>"

#echo "<hr>"
#echo "<pre>"
#echo "Mergen der Indexdateien ..."


#echo `swish-e -e -M $Listemerge $indexdir/merge/index.swish-e 2>&1 >> /www/swish-e/swish-e.log`
#echo "... Indexfiles zusammengef&uuml;gt."
#echo "</pre>"
#echo "<hr>"
echo "<br>"

echo "</html></body>"

