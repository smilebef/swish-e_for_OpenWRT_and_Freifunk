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
	Liste=`cat /var/run/services_olsr | grep -i swish | grep -i -v own | cut -d# -f2`
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

mergen=0

for i in $Liste;
do
	echo "Verarbeitet wird:"
	echo $i
        if [ -e $indexdir/global/$i ]; then
		echo "Verzeichnis existiert."
	else
		echo "Verzeichnis existiert nicht, wird erstellt..."
                mkdir $indexdir/global/$i
	fi
	echo "Download von md5-file..."
        wget http://$i/swish-e/indexfiles/local/index.swish-e.md5sums -O $indexdir/$i/index.swish-e.md5sum
        if [ ! `md5sum -c  $indexdir/$i/index.swish-e.md5` ]; then
		mergen=1
		echo "F&uuml;r Verzeichniss: "$indexdir/global/$i                                                                       
		echo "Prüfsumme nicht OK, erneuere die Dateien..."
		echo "index.swish-e..."
		echo `wget http://$i/swish-e/indexfiles/local/index.swish-e -O $indexdir/global/$i/index.swish-e 2>&1`
		echo "index.swish-e.prop..."
		echo `wget http://$i/swish-e/indexfiles/local/index.swish-e.prop -O $indexdir/global/$i/index.swish-e.prop 2>&1`
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


Listemerge=$Listemerge" $indexdir/local/index.swish-e "

echo "Listemerge = "$Listemerge


echo "beginne mergen..."
if [ mergen ]; then                                                                
	        echo "beginne mergen..."                                                                                                       
	        rm $indexdir/merge/* 
		echo `swish-e -e -M $Listemerge $indexdir/merge/index.swish-e`
		echo "...ende mergen."
else                                                                               
	        echo "Nix gemacht!"                                                        
fi       
echo "...Ende Prozedur Mergen."

echo "</pre>"
echo "</body></html>"
echo

