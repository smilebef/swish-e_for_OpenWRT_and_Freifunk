#!/bin/sh

echo "Content-type: text/html"
echo

echo '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<head>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
<title>Synchronisierung der erreichbaren Server</title>
</head>'
echo "<html><body>"
echo "<pre>"
echo "Beginn Prozedur Synchronisieren..."
indexdir="/www/swish-e/indexfiles"
services_file="/var/run/services_olsr"

if [ -f $services_file ]; 
then
	Liste=`cat /var/run/services_olsr | grep swish | grep -v own | cut -d# -f2`
else
	echo "service_file in olsr_nameservice-plugin noch nicht konfiguriert!"
	echo "als service_file wird erwartet: $service_file"
	echo "Abbruch!"
	exit 0
fi


echo "Liste alt: "`ls $indexdir/global/`
echo "Liste neu: "$Liste
echo "Verzeichnisse werden nicht automatisch bereinigt!"


if [ $Liste == "" ];
then
	echo "Liste ist leer!"
	echo "Entweder ist kein weiterer Service unter OLSR-namservice-plugin konfiguriert oder es gibt keinen weiteren swish-e-server."
	echo "Abbruch!"
	exit 0
fi



echo  "beginne Synchronisiere..."

for i in $Liste;
do
	echo "Verarbeitet wird:"
	echo $i
        if [ -e $indexdir/global/$i ]; then
                mkdir $indexdir/global/$i
	fi
	echo "Download von md5-file..."
        wget http://$i/swish-e/indexfiles/local/index.swish-e.md5sums -O $indexdir/$i/index.swish-e.md5sum
        if [ ! md5sum -c --status $indexdir/$i/index.swish-e.md5 ]; then
		echo "Prüfsumme nicht OK, erneuere die Dateien..."
		echo "index.swish-e..."
		wget http://$i/swish-e/indexfiles/local/index.swish-e -O $indexdir/$i/index.swish-e
		echo "index.swish-e.prop..."
		wget http://$i/swish-e/indexfiles/local/index.swish-e.prop -O $indexdir/$i/index.swish-e.prop
	fi
done
echo "...ende synchronisieren."
echo "...Ende Prozedur Synchronisieren."
echo "Beginn der Prozedur Mergen..."

Listemerge=""
for i in $Liste; 
do
	Listemerge=$Listemerge" $indexdir/global/$i/index.swish-e"
done

echo "Listemerge = "$Listemerge

Listemerge=$Listemerge" $indexdir/local/index.swish-e "

echo "beginne mergen..."
echo `swish-e -e -M $Listelang $indexdir/merge/index.swish-e`
echo "...ende mergen."
echo "...Ende Prozedur Mergen."

echo "</pre>"
echo "</body></html>"
echo

