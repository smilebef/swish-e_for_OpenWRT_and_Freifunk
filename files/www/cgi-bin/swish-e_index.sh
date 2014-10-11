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
echo
lockfile="/var/tmp/swish-index.lock"

if [ -f $lockfile ]; then
	echo "Already running. Exiting."
	exit 1
else
	touch $lockfile
fi
		      

cat /etc/swish-e/swish.conf | sed s/Kotzbrocken/`uci get network.unicast.ipaddr`/ > /var/etc/swish-e.conf



indexdir="/www/data/indexfiles"
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

if [ ! -d $indexdir ]; then
	mkdir $indexdir;
fi
if [ ! -d $indexdir/local ]; then
	mkdir $indexdir/local;
fi
if [ ! -d $indexdir/global ]; then
	mkdir $indexdir/global
fi
if [ ! -d $indexdir/merge ]; then
	mkdir $indexdir/merge
fi


echo `rm $indexdir/local/index.swish-e.neu  2>&1 >> $logfile`
echo `rm $indexdir/local/index.swish-e.neu.prop  2>&1 >> $logfile`

echo `rm $indexdir/local/index.swish-e.neuer  2>&1 >> $logfile`
echo `rm $indexdir/local/index.swish-e.neuer.prop  2>&1 >> $logfile`

echo `rm $indexdir/merge/index.swish-e.neu  2>&1 >> $logfile`
echo `rm $indexdir/merge/index.swish-e.neu.prop  2>&1 >> $logfile`


echo 'Ber&uuml;hre Timestamp.'
touch $indexdir/local/timestamp 2>&1 >> $logfile

echo 'Pr&uuml;fe ob schon eine Indexdatei existiert.'
if [ -e $indexdir/local/index.swish-e ]; then 

echo 'Ja, sie existert. <br />
Also indiziere inkrementell. <br />
Beginne mit Indizieren, erstelle Pr&uuml;fsummen und merge externe indexfiles zusammen. <br />
Der Stand der Indizierung kann/muss unter <a href="/swish-e/swish-e.log">Logdatei</a> eingesehen werden. <br />
Die abschliessende Meldung muss lauten "indizieren erfolgreich abgeschlossen"... <br />'

echo `swish-e -e -c /var/etc/swish-e.conf -N $indexdir/local/timestamp -f $indexdir/local/index.swish-e.neu -i /www/*  2>&1 >> $logfile  &&   swish-e -e -M "$indexdir/local/index.swish-e $indexdir/local/index.swish-e.neu" $indexdir/local/index.swish-e.neuer 2>&1 >> $logfile && mv $indexdir/local/index.swish-e.neuer $indexdir/local/index.swish-e 2>&1 >> $logfile && mv $indexdir/local/index.swish-e.neuer.prop $indexdir/local/index.swish-e.prop 2>&1 >> $logfile  &&  md5sum $indexdir/local/index.swish-e > $indexdir/local/index.swish-e.md5sums && md5sum $indexdir/local/index.swish-e.prop >> $indexdir/local/index.swish-e.md5sums && swish-e -e -M $Listemerge $indexdir/merge/index.swish-e.neu 2>&1 >> $logfile && mv $indexdir/merge/index.swish-e.neu $indexdir/merge/index.swish-e 2>&1 >> $logfile && mv $indexdir/merge/index.swish-e.neu.prop $indexdir/merge/index.swish-e.prop 2>&1 >> $logfile && echo "indizieren erfolgreich abgeschlossen" >> $logfile &`

echo '... Indizieren abgeschlossen .'
else

echo 'Nein, sie existert nicht.  <br />
Also indiziere neu. <br /> 
Beginne mit Indizieren, erstelle Prüfsummen und merge externe indexfiles zusammen. <br />
Der Stand der Indizierung kann/muss unter <a href="/swish-e/swish-e.log">Logdatei</a> eingesehen werden. <br />
Die abschliessende Meldung muss lauten "indizieren erfolgreich abgeschlossen"... <br />'

echo `swish-e -e -c /var/etc/swish-e.conf -f $indexdir/local/index.swish-e.neu -i /www/*  2>&1 >> $logfile  && mv  $indexdir/local/index.swish-e.neu  $indexdir/local/index.swish-e && mv  $indexdir/local/index.swish-e.neu.prop  $indexdir/local/index.swish-e.prop && md5sum $indexdir/local/index.swish-e > $indexdir/local/index.swish-e.md5sums && md5sum $indexdir/local/index.swish-e.prop >> $indexdir/local/index.swish-e.md5sums  && swish-e -e -M $Listemerge $indexdir/merge/index.swish-e.neu 2>&1 >> $logfile && mv $indexdir/merge/index.swish-e.neu $indexdir/merge/index.swish-e 2>&1 >> $logfile && mv $indexdir/merge/index.swish-e.neu.prop $indexdir/merge/index.swish-e.prop 2>&1 >> $logfile  && echo "indizieren erfolgreich abgeschlossen" >> $logfile &`

echo '... Indizieren abgeschlossen .'
fi



rm $lockfile

echo '</pre>
<hr>
<br>
</html></body>'

