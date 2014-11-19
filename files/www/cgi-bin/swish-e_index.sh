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
	echo "ps output is:"
	echo `ps`
	echo "I think Swish-e is already running."
	echo "If not, remove Lockfile "$lockfile" by hand."
	exit 1
else
	touch $lockfile
fi



cat /etc/swish-e/swish.conf | sed s/Kotzbrocken/`uci get network.unicast.ipaddr`/ > /var/etc/swish-e.conf



indexdir="/www/data/indexfiles"
logfile="/www/swish-e/swish-e.log"

echo "Begin with indexing..." > $logfile


Liste=`cd $indexdir/global/ && ls` 2>&1 >> $logfile

Listemerge=""
for i in $Liste; 
do
	if [ -e $indexdir/global/$i/index.swish-e ]; then
		Listemerge=$Listemerge" $indexdir/global/$i/index.swish-e"   2>&1 >> $logfile;
	fi
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


echo 'Touch timestamp file.'
touch $indexdir/local/timestamp 2>&1 >> $logfile

#echo 'Abfrage ob schon eine Indexdatei existiert.'
if [ -e $indexdir/local/index.swish-e ] && [ `cat $indexdir/local/timestamp` == `uci get network.unicast.ipaddr` ]; then 

echo 'Index-file exist and Unicast-IP is the old one. <br />

The following will be done:<br />
Indexing incremental <br />
creation checksum <br />
merging indexfiles.<br />
This can be take some time.
If successfull done the program give back "finished successfull".
The Logfile is located <a href="/swish-e/swish-e.log">hier</a> <br />
... <br />'

echo `swish-e -e -c /var/etc/swish-e.conf -N $indexdir/local/timestamp -f $indexdir/local/index.swish-e.neu -i /www/*  2>&1 >> $logfile  &&   swish-e -e -M "$indexdir/local/index.swish-e $indexdir/local/index.swish-e.neu" $indexdir/local/index.swish-e.neuer 2>&1 >> $logfile && mv $indexdir/local/index.swish-e.neuer $indexdir/local/index.swish-e 2>&1 >> $logfile && mv $indexdir/local/index.swish-e.neuer.prop $indexdir/local/index.swish-e.prop 2>&1 >> $logfile  &&  md5sum $indexdir/local/index.swish-e > $indexdir/local/index.swish-e.md5sums && md5sum $indexdir/local/index.swish-e.prop >> $indexdir/local/index.swish-e.md5sums && swish-e -e -M $Listemerge $indexdir/merge/index.swish-e.neu 2>&1 >> $logfile && mv $indexdir/merge/index.swish-e.neu $indexdir/merge/index.swish-e 2>&1 >> $logfile && mv $indexdir/merge/index.swish-e.neu.prop $indexdir/merge/index.swish-e.prop 2>&1 >> $logfile && echo "indizieren erfolgreich abgeschlossen" >> $logfile &`

echo '...finished successfull.'

else

echo 'Indexfile does not exist or Unicast-IP has been changed. <br />
Indizing new. <br /> 
The following will be done:<br />
Indexing incremental <br />
creation checksum <br />
merging indexfiles.<br />
This can be take some time.
If successfull done the program give back "finished successfull".
The Logfile is located <a href="/swish-e/swish-e.log">hier</a> <br />
... <br />'

uci get network.unicast.ipaddr > $indexdir/local/timestamp

echo `swish-e -e -c /var/etc/swish-e.conf -f $indexdir/local/index.swish-e.neu -i /www/*  2>&1 >> $logfile  && mv  $indexdir/local/index.swish-e.neu  $indexdir/local/index.swish-e && mv  $indexdir/local/index.swish-e.neu.prop  $indexdir/local/index.swish-e.prop && md5sum $indexdir/local/index.swish-e > $indexdir/local/index.swish-e.md5sums && md5sum $indexdir/local/index.swish-e.prop >> $indexdir/local/index.swish-e.md5sums  && swish-e -e -M $Listemerge $indexdir/merge/index.swish-e.neu 2>&1 >> $logfile && mv $indexdir/merge/index.swish-e.neu $indexdir/merge/index.swish-e 2>&1 >> $logfile && mv $indexdir/merge/index.swish-e.neu.prop $indexdir/merge/index.swish-e.prop 2>&1 >> $logfile  && echo "indizieren erfolgreich abgeschlossen" >> $logfile &`

echo '... finished successfull .'

fi



rm $lockfile

echo '</pre>
<hr>
<br>
</html></body>'

