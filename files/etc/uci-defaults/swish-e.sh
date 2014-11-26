#!/bin/sh

errlogfile=/var/log/smilie

echo "beginn debuggen" >> $errlogfile

echo "Schreiben auf index_user.html" >> $errlogfile

echo '
<hr />
<br />
<a href="/cgi-bin/swish-e.cgi"><h1>SWISH-e Suche  </h1></a>
<br />
<br />
<a href="/data/"><h1>Auf dem Datentr&auml;ger st&ouml;bern</h1></a>
<br />
<hr />

Das Firmware Image f&uuml;r Raspberry Pi gibt es 
<a href="http://10.230.4.2/data/OpenWRT/CC/brcm2708/openwrt-brcm2708-sdcard-vfat-ext4.img"> hier </a>. <br/>
Unter Linux wird das Image geschrieben mit: <br/>
dd if=openwrt-brcm2708-sdcard-vfat-ext4.img of=/dev/mmcblk0 bs=10M <br/>
<hr /><br/>
<h1>&Uuml;ber diesen Server...</h1>
<br/>
<h3>Erl&auml;uterungen zum Konzept dieses Fileservers</h3>

Dieser Web/Fileserver wurde speziell f&uuml;r die Verwendung im Umfeld von Freifunk entwickelt.<br />
Im Freifunk-Netz publiziert er mittels OLSRD seinen Service (swish-e) und syncronisiert seine Indexfiles mit umliegenden Servern, wenn auf diesen die gleiche Firmware installiert ist.<br/>
Im Inselbetrieb erm&ouml;glicht er die Volltextsuche in den eigenen Dateien.
<br/>
<b>Achtung!</b> Dieser Server wurde mit der IP-Adresse <b>10.230.4.2</b> vorkonfiguriert, nicht wie sonst 192.168....<br />
Dieses Vorgehen ist dank SD-Card (siehe Raspberry Pi) im Fehlerfall unproblematisch.<br/>
<b>Achtung!</b> Wenn Sie die Partition eines USB-Laufwerks unter /www/data einh&auml;ngen wird diese im Netz sofort ver&ouml;ffentlicht!<br/>
Dem OLSRD wurde von Anfang an das Interface UNICAST zugewiesen.
Dieses hat die f&uuml;r FF-Berlin typische 10.230/16er IP-Adresse.<br/>
Die nicht nur so bezeichneten Unicast-IP-Adresse verh&auml;lt sich nach erster Inbetriebnahme wie eine Anycast-Adresse also (Link-Local).<br/>
Diese wurde vom Autor bereitgestellt und ermöglicht den sofortigen Einsatz im berliner Freifunk-Netz.<br/>
Die Unicast-Adresse muss im Zuge der weiteren Installation individuell umkonfiguriert werden.<br/>
Die ebenfalls nicht nur so genannte Anycast-Adresse sollte beibehalten werden.
<br />

<h3>Die hier angewandte Technik der dezentralen Suche.</h3>
Es wird eine Methode verwendet auf Grundlage von UNICAST und ANYCAST Adressen in Verbindung mit dem OLSRD.<br />
Bei der Eingabe einer Anicast-Adresse im URL-Feld des Browsers wird der Browser über die Routing-Mechanismen zum nächstgelegenen Server mit dieser Adresse verbunden. Eben gerade bei einer mehrfach vergebenen Adresse. <br />
Der OLSRD mit seinem OLSRD-nameservice-plugin (services/service-file) publizieren den Dienst "swish-e". 
Dies wird zur Syncroniation und zur weiteren Verarbeitung durch Skripte benötigt.
<br /> Es wird also mit Hilfe der Anycast-Adresse eine Suchanfrage abgesendet.<br />
Die Pfade des Such-Ergebnisses beinhalten dann jedoch die Unicast-Adresse.<br />

<h2>Konfiguration des Servers</h2>
<h3>Konfiguration der Adressen ANYCAST/UNICAST</h3>
Das Tool "ifconfig" ist nicht in der Lage mehrerer IP-Adressen auf einem Interface hinzuzufügen bzw. anzuzeigen.<br />
Zu diesem Zweck bitte "ip" oder Luci verwenden.<br />
Es müssen mindestens zwei IP-Adressen auf dem (Lan-)Interface eth0 vergeben werden.
<ul>
<li> <b>Unicast</b> 10.230.4.2/16 muß  individuell angepasst werden, siehe <b>http://ip.berlin.freifunk.net/ip</b> .</li>
<li> <b>Anycast</b> bleibt unverändert <b>10.230.4.1/32</b>.</li>
</ul>
Der Server wurde f&uuml;r den Berliner Raum entwickelt und benutzt IP-Adressen aus diesem IP-Bereich.
Diese Adressen müssen f&uuml;r Netze außerhalb von Berlin angepasst werden.

Beim Einrichten der IP-Adressen ist auf die Netzmaske zu achten.
Die Unicast-Adresse bekommt die Netztypische (in Berlin eine) 8er/255.255.0.0 Netzmaske.
Die Anicast-Adresse erh&auml;lt jedoch immer eine 32er/255.255.255.255 Netzmaske.<br />


<h3>Konfiguration der OLSR-Services</h3>
Unter Dienste/OLSR/Plugins/olsrd_nameservice.so muss nun ein Dienst annonciert werden.<br />
<ul>
<li>Option "service" erhält den Eintrag:<b>"http://10.230.4.1:80/cgi-bin/swish-e.cgi|tcp|Web/File-Server mit Volltext-Suche (swish-e)" </b>. </li>
</ul>
Dies hat hoffentlich das Installations-Skript schon f&uuml;r Sie erledigt.
<h3>Konfiguration von OLSRD</h3>
Unter Dienste/OLSR wird das Interface zugewiesen und weiter unter HNA werden weiterhin vorhandene Netzwerke annonziert.
<ul><li>
Das Netzwerk-Interface Unicast wird dem OLSRD als Interface zugewiesen.</li><li>
Das ANYCAST-Interface(/32) wird per HNA annonziert.</li></ul>
Dies hat hoffentlich das Installations-Skript schon f&uuml;r Sie erledigt.
<br />

<h3>Eine M&ouml;glichkeit zum Einrichten einer eigenen Webseite</h3>
Es ist m&ouml;glich die Luci-Seite <b>"/www/index.html"</b> beliebig umzubenennen und eine eigene Seite an diese Stelle zu platzieren.
Die umbenannte Luci-Seite k&ouml;nnte dann mittels eines Links (siehe google: selfhtml) auf der eigenen Seite referenzieren.
<br /><br />
<hr />
<br />
<h1>Einrichten von Datentr&auml;gern. Under Construction!</h1>
<br />
<hr />
<br />
Nun stellt sich die Frage, wie man am besten einen Datentr&auml;ger einrichtet. <br />
Es gibt zur Auswahl:
<ul>
<li> (S)FTP </li>
<li> HTTP(S) </li>
<li> Samba </li>
</ul>
Bei der genutzten Software handelt es sich prim&auml;r um besonders kleine und leichte Programme. Die Leistungsfähigkeit ist demnach stak begrentzt.
OpenWRT-Packete wie block-mount, samba-server, vsftpd, uhttpd bilden derzeit die Grundlage des Servers.
Diese Programme k&ouml;nnen individuell im Nachhinein ersetzt oder erg&auml;nzt werden.
Benutzer und Benutzergruppen wurden noch nicht installier. 
Das block-mount Tool mountet einen Datentr&auml;ger nach OpenWRT-Standard nach /mnt/sda1 (Erster scsi-Datentr&auml;ger, erste Partition).
Dies wurde abgewandelt zu /www/data, da <b>swish-e</b> alle Daten unter <b>/www</b> indiziert und uhttpd die Daten unter /www ver&ouml;ffentlicht.
<hr />
<br />
<h3>Der /www Verzeichnissbaum.</h3>
<dl>
<dt>/www</dt>
<dd>Alle hier eingefügten Daten werden &ouml;ffentlich.</dd>
<dt>/www/swish-e/</dt>
<dd>Unterverzeichniss f&uuml;r diverse Dateien von swish-e</dd>
<dt>/www/data/</dt>
<dd>Hier werden USB-Sticks veröffentlicht. Wenn externe Datentr&auml;ger hier eingebunden werden, werden Dateien, welche sich eingentlich in diesem Verzeichniss befinden ausgeblendet. Das machen wir und zu nutze f&uuml;r die Indexfiles, welche bei eingebundenem Datentr&auml; andere sein m&uuml;ssen als bei einem nicht eingebundenen Datentr&auml;ger.</dd>
<dt>/www/data/indexfiles/</dt>
<dd>Hier liegen die &ouml;ffentlichen Indexfiles von swish-e.</dd>
<dt>/www/daten/indexfiles/local/</dt>
<dd>Hier liegt die Indexdatei aller unter /www gefundenen und indizierten lokalen &ouml;ffentlich zug&auml;nglichen Daten.</dd>
<dt>/www/daten/indexfiles/global/"IPs"/</dt>
<dd>Hier liegen die Indexdateien aller von fremden Computern gefundenen nicht lokalen &ouml;ffentlich zug&auml;nglichen Daten.</dd>
<dt>/www/daten/indexfiles/merge/</dt>
<dd>Hier liegt die Indexdatei, welche aus localen und globalen Dateien zusammengefügt wurden. Diese Dateien werden zur eigentlichen Suche verwendet.</dd>
<dt>/www/swish-e/doc/</dt>
<dd>Hier liegt die lokale Doku von swish-e. Sie wurde dem original swish-e packet entnommen.</dd>
</dl>
<br /><br />
<hr />
<br />
<h3>Von Scripten genutzte Definitionen.</h3>
<dl>
<dt>services_file=/var/run/services_olsr</dt>
<dd>Diese Datei wird zur Syncronisation der Index-Dateien ausgewertet. </dd>
<dt>olsr-nameservice-plugin: service=Suche</dt>
<dd>Der Service-Eintrag "Swish-e + Suche" wird zur Syncronisation der Index-Dateien benötigt und kann zur Anycast-Suche verwendet werden.</dd>
</dl>
<br /><br />
<hr />
<br />
' > /www/luci-static/index_user.html 2>> $errlogfile



echo "Beginn freifunk config..." >> $errlogfile

uci set freifunk.community.DefaultText=disabled 2>> $errlogfile
uci commit freifunk  2>> $errlogfile

echo "Beginn network config..." >> $errlogfile


iface=`uci show network | grep 192.168. | sed s/network.// | sed s/.ipaddr=192.168.*//` 2>> $errlogfile
ifname=`uci get network.$iface.ifname` 2>>  $errlogfile


echo "network configuration iface=$iface ifname=$ifname :" >> $errlogfile

uci rename network.$iface="unicast" 2>> $errlogfile
uci delete network.unicast.type 2>> $errlogfile

uci set network.anycast=interface  2>> $errlogfile
uci set network.anycast.ifname=$ifname 2>> $errlogfile
uci set network.anycast.proto=static 2>> $errlogfile
uci set network.anycast.ipaddr=10.230.4.1 2>> $errlogfile
uci set network.anycast.netmask=255.255.255.255 2>> $errlogfile

uci set network.unicast=interface 2>> $errlogfile
uci set network.unicast.ifname=$ifname 2>> $errlogfile
uci set network.unicast.proto=static 2>> $errlogfile
uci set network.unicast.ipaddr=10.230.4.2 2>> $errlogfile
uci set network.unicast.netmask=255.255.0.0 2>> $errlogfile

uci commit network 2>> $errlogfile


cp /etc/config/olsrd /var/log/olsrd-swish-debug0 2>> $errlogfile


echo "Beginn olsrd config..." >> $errlogfile

ziffer=`uci show olsrd | grep olsrd_nameservice |  sed  's/..library=olsrd_nameservice.so.*//' | sed s/olsrd.@LoadPlugin.//` 2>> $errlogfile

echo "olsrd configuration ziffer=$ziffer :" >> $errlogfile

uci set      olsrd.@LoadPlugin[$ziffer].services_file="/var/run/services_olsr" 2>> $errlogfile
uci add_list olsrd.@LoadPlugin[$ziffer].service="http://10.230.4.1:80/cgi-bin/swish-e.cgi|tcp|Swish-e" 2>> $errlogfile
uci set      olsrd.@LoadPlugin[$ziffer].ignore=0 2>> $errlogfile
uci set      olsrd.@Interface[-1].interface="unicast" 2>> $errlogfile
uci set      olsrd.@Interface[-1].Ipv4Broadcast="255.255.255.255" 2>> $errlogfile
uci set      olsrd.@Interface[-1].ignore=0 2>> $errlogfile
uci commit olsrd 2>> $errlogfile

echo "-geprueft-" >> $errlogfile

ziffer=`uci show olsrd | grep olsrd_arpref |  sed  's/..library=olsrd_arpref.*//' | sed s/olsrd.@LoadPlugin.//` 2>> $errlogfile
echo "olsrd configuration ziffer=$ziffer arp:"  >> $errlogfile
uci set      olsrd.@LoadPlugin[0].ignore=1 2>> $errlogfile
uci commit olsrd 2>> $errlogfile

ziffer=`uci show olsrd | grep olsrd_dyn |  sed  's/..library=olsrd_dyn.*//' | sed s/olsrd.@LoadPlugin.//` 2>> $errlogfile
echo "olsrd configuration ziffer=$ziffer dyn:"  >> $errlogfile
uci set      olsrd.@LoadPlugin[$ziffer].ignore=1 2>> $errlogfile
uci commit olsrd 2>> $errlogfile


ziffer=`uci show olsrd | grep olsrd_httpinfo |  sed  's/..library=olsrd_httpinfo.*//' | sed s/olsrd.@LoadPlugin.//` 2>> $errlogfile
echo "olsrd configuration ziffer=$ziffer httpinfo :"  >> $errlogfile
uci set      olsrd.@LoadPlugin[$ziffer].ignore=1 2>> $errlogfile
uci commit olsrd 2>> $errlogfile


echo "olsrd configuration add jsoninfo :"   >> $errlogfile
uci add olsrd LoadPlugin 2>> $errlogfile
ziffer=-1
uci set      olsrd.@LoadPlugin[$ziffer].library=`ls /usr/lib/olsrd_json* | sed s:/usr/lib/::` 2>> $errlogfile
uci set      olsrd.@LoadPlugin[$ziffer].ignore=0 2>> $errlogfile
uci set      olsrd.@LoadPlugin[$ziffer].accept="127.0.0.1" 2>> $errlogfile
uci set      olsrd.@LoadPlugin[$ziffer].port=9090 2>> $errlogfile
uci set      olsrd.@LoadPlugin[$ziffer].UUIDFile="/etc/olsrd/olsrd.uuid" 2>> $errlogfile
uci commit olsrd 2>> $errlogfile


cp /etc/config/olsrd /var/log/olsrd-swish-debug1 2>> $errlogfile


echo "olsrd configuration Hna4:"  >> $errlogfile
uci add olsrd Hna4
uci set olsrd.@Hna4[-1].netaddr=10.230.4.1 2>> $errlogfile
uci set olsrd.@Hna4[-1].netmask=255.255.255.255 2>> $errlogfile
uci commit olsrd 2>> $errlogfile

cp /etc/config/olsrd /var/log/olsrd-swish-debug2 2>> $errlogfile



echo "olsrd configuration fstab:"  >> $errlogfile
uci add fstab mount 2>> $errlogfile
uci set fstab.@mount[-1].enabled=0 2>> $errlogfile
uci set fstab.@mount[-1].target=/www/data 2>> $errlogfile
uci set fstab.@mount[-1].device=/dev/sda1 2>> $errlogfile
uci set fstab.@mount[-1].fstype=ext4 2>> $errlogfile
uci set fstab.@mount[-1].enabled_fsck=1 2>> $errlogfile
uci commit fstab 2>> $errlogfile

uci commit 2>> $errlogfile



sleep 3


echo "olsr restart:"`/etc/init.d/olsrd restart` 2&1>> $errlogfile

cp /etc/config/olsrd /var/log/olsrd-swish-debug3 2>> $errlogfile

echo "network restart:"`/etc/init.d/network restart`  2&1>> $errlogfile

cp /etc/config/network /var/log/network-swish-debug 2>> $errlogfile

# crontab config

echo "5 4  * * * /www/cgi-bin/swish-e_index.sh" >> /etc/crontabs/root
echo "5 5  * * * /www/cgi-bin/swish-e_sync_olsr.sh" >> /etc/crontabs/root

