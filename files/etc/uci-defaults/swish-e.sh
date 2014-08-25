#!/bin/sh

errlogfile=/var/log/smilie

echo "beginn debuggen" >> $errlogfile

echo "Schreiben auf index_user.html" >> $errlogfile

echo '
<hr />
<br />
<a href="/cgi-bin/swish-e.cgi"><h1>SWISH-e Suche  </h1></a>
<br />
<hr />
<br />
<a href="/data/"><h1>Auf dem Datentr&auml;ger st&ouml;bern</h1></a>
<br />
<hr />
<br />

<h1>Erl&auml;uterungen zum Konzept dieses Fileservers</h1>
<br />
Dieser Web/Fileserver wurde speziell f&uuml;r die Verwendung im Umfeld von Freifunk entwickelt.<br />
<b>Achtung! Dieser Server ist mit der IP-Adresse 104.130.3.112 vorkonfiguriert.<br />
Achtung! Die Partition 1 des ersten USB-Laufwerks wird öffentlich unter /www/data eingeh&auml;ngt!</b>
Der OLSRD sollte von Anfang an mit Hilfe von vorkonfigurierten 104/8er IP-Adressen im Netz sichtbar sein.
Diese Adressen wurden vom Autor bereitgestellt und sind demnach zum Anfang  gleich.<br/>
Dies ermöglicht den sofortigen Einsatz im Freifunk-Netz.
Die Unicast-Adresse muss im Zuge der Installation  noch individuell konfiguriert werden.<br/>
Die Anycast-Adresse sollte so bleiben.
<br />
<h3>Konzept zur dezentralen Suche</h3>
Dieser Fileserver soll sich in dem Umfeld freier und dezentraler Netze eingliedern.
Am Beispiel der Bahn, der Post und von Google kann man sehen wie wichtig es ist, dass Macht nicht unbegrenzt anwachsen darf. 
Selbst bei staatlichen Monopolen sind entgleissungen zu beobachten.
Die große Anzahl von Initiativen f&uuml;r dezentrale Strukturen, sind ein un&uuml;bersehbarer Fakt schwindender Akzeptanz f&uuml;r Zentralismus. 
Das Ziel soll eine Methode sein, die abseits von zentraler Zensur und Kontrolle die Grundrechte  der B&uuml;rger st&auml;rkt.
Es hat sich einfach herausgestellt, dass es Priorit&auml;ten gibt, welche in einer Gesellschafft nicht &uuml;bergangen werden sollten.
Demokratie ist ein nat&uuml;rliches Recht und muß best&auml;rkt werden.
Dieser File-Server wurde speziell f&uuml;r ein dezentrales Umfeld entwickelt,
daf&uuml;r dass er im Inselbetrieb genau so wie im großen Freifunk-Netz arbeitet.
Im Inselbetrieb erm&ouml:glicht er die Volltextsuche in den eigenen Dateien. Im Freifunk-Netz publiziert er mittels OLSRD seinen Service und synchronisiert seine Indexfiles mit benachbarten Web/File-Servern.
<h3>Technik der dezentralen Suche in diesem Fall</h3>
Die Technik der dezentralen Suche steckt in ihren Kinderschuhen.
Die Basis dieser Technologie orientiert sie sich an der geschickten Verwendung von <b>UNICAST und ANYCAST Adressen in Verbindung mit dem OLSRD.</b><br />
Anicast-Server werden bereits vielfach bei großen Server-Diensten angewendet.
Der OLSRD mit seinem <b>OLSRD-nameservice-plugin</b>(speziell die Dienste services bzw. service-file) sollen für die syncronisation der Daten sorgen. Die Technik des OLSRD ist recht neu. Wir werden sehen, ob diese sich behaupten kann.<br />

<h2>Konfiguration des Servers</h2>
Achtung, schaut bitte erst nach ob diverse Schritte nicht schon automatisch vom Installations-Skript eingerichtet wurden.

<h3>Konfiguration der Adressen ANYCAST/UNICAST</h3>
<b>Achtung!</b> Das Tool ifconfig ist weder in der Lage mehrerer IP-Adressen auf einem Interface hinzuzufügen, noch diese anzuzeigen.
ip ist das entsprechende Tool (siehe: ip a).<br /><br />

Wenn der User das vorgesehene Konzept beibehalten will, müssen mindestens zwei IP-Adressen auf dem Interface (eth0) vergeben werden.
<ul>
<li> Eine davon ist individuell: <b>Unicast</b> (siehe http://ip.berlin.freifunk.net/ip) .</li>
<li> Die andere ist vereinheitlicht bzw. gleich: <b>Anycast</b>.</li>
</ul>
Das initiale Installationscript (/etc/uci-default/swish-e.sh) hat, (wenn alles nach Plan l&auml;uft) das Default-Interface (lan) nach Unicast umbenannt und ein weiteres Interface Anicast erzeugt.<br />

Der Server wurde f&uuml;r den Berliner Raum entwickelt und benutzt IP-Adressen aus seinem IP-Bereich.
Diese Adressen müssen f&uuml;r fremde Netzen angepasst werden.
Als Anycast-Adresse wurde 104.21.0.7/32 reserviert und vom Installations-Skript eingerichtet.
Beim Aufruf einer Anycast-Adresse wird der Computer dank Routingmechanismen mit dem n&auml;chst gelegenen Server mit dieser IP-Adresse verbunden. <br />

Die Unicast-Adresse wurde vom Installations-Skript auf 104.130.3.112/8 gesetzt.
Die Unicast-Adresse ist im Grunde jedem selbst überlassen. Diese muss w&auml;rend der Installation individuell bei den lokalen Kommunities (f&uuml;r Berlin siehe http://ip.berlin.freifunk.net/ip) bezogen/registriert und eingerichtet werden.<br />

Beim Einrichten der IP-Adressen ist auf die Netzmaske zu achten.
Die Unicast-Adresse bekommt die Netztypische (in Berlin eine) 8er/255.0.0.0 Netzmaske.
Die Anicast-Adresse erh&auml;lt jedoch immer eine 32er/255.255.255.255 Netzmaske.<br />


<h3>Konfiguration der OLSR-Services</h3>
F&uuml;r die Arbeit mit Anycast und f&uuml;r die Syncronisation verschiedener Fileserver m&uuml;ssen nun zwei Dienste mittels OLSRD annonciert werden.
Unter Dienste/OLSR/Plugins/olsrd_nameservice.so kann man den Service einrichten.<br />
Dies ist Definitionssache. Wir einigen uns auf zwei Dienste:
<ul>
<li>Der Dienst <b>swish-e</b> wird zum Synchronisieren der Server untereinander (annoncieren der Unicast-IP) ben&ouml;tigt.</li>
<li>Der Dienst <b>Suchen</b> wird zum Suchen (annoncieren der ANYCAST-IP) ben&ouml;tigt.</li>
</ul>
Die Option "service" im nameservice-plugin bekommt einen Eintrag wie folgt:<br />
<b>"http://104.21.0.7:80/cgi-bin/swish-e.cgi|tcp|Web/File-Server mit Volltext-Suche (swish-e)" </b>.<br />
Dies hat das Installations-Skript schon f&uuml;r Sie erledigt.
<h3>Konfiguration der OLSRD</h3>
Nun folgt die Frage wie man den OLSRD konfigueriert.
Dem OLSRD wird als Interface die UNICAST-Adresse(/8) zugewiesen und das ANYCAST-Interface(/32) wird per HNA annonziert.
Dies hat das Installations-Skript schon f&uuml;r Sie erledigt.
<br /><br />
<hr />
<br />
<h1>Eine M&ouml;glichkeit zum Einrichten einer eigenen Webseite</h1>
<br />
<hr />
<br />
Es ist m&ouml;glich die Luci-Seite <b>"/www/index.html"</b> beliebig umzubenennen und eine eigene Seite an diese Stelle zu platzieren.
Die umbenannte Luci-Seite k&ouml;nnte dann mittels eines Links (siehe google: selfhtml) auf der eigenen Seite referenzieren.
<br /><br />
<hr />
<br />
<h1>Einrichten von Datentr&auml;gern</h1>
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
Bei den Servern handelt es sich prim&auml;r nicht um besonders leistungsf&auml;hige Programme sondern um besonders sparsame Programme.
OpenWRT-Packete wie block-mount, samba-server, vsftpd, uhttpd bilden derzeit die Grundlage der Software.
Diese Programme k&ouml;nnen letztlich nach Vorlieben ersetzt oder erg&auml;nzt werden.
Die Zugriffsrechte sind ebenfalls beliebig zuteilbar.
Um hier einen Anfang zu machen habe ich mir folgendes gedacht.
Das block-mount Tool mountet einen Datentr&auml;ger standardmä&szlig;ig nach /mnt/sda1 (Erster scsi-Datentr&aumlMger, erste Partition).
Dies könnten wir so lassen. Fakt ist jedoch, dass <b>swish-e</b> alle Daten unter <b>/www</b> indiziert.
Es w&auml;re also klug, das Verzeichnis, welches &ouml;ffentlich gefunden werden soll unter /www (Beispiel: <b>/www/daten</b>) zu verlinken.
Dort wird es auch durch <b>uhttpd</b> angeboten.

<h3>FTP, HTTP, Samba</h3>
Jedes dieser Programme hat eine eigene Konfigurationsdatei und damit eigene Regeln und eigene Daten-Verzeichnisse.<br/>
Hier kann vielseitig konfiguriert werden.<br/>
Die Daten eines USB-Stick zum Beispiel liegen unter <b>"/mnt/sda1"</b>,<br />
die Daten des FTP-Servers liegen zum Beispiel unter <b>"/home/ftp"</b>,<br />
die Webseite des HTTP-Servers liegt unter <b>"/www"</b> und <br />
der Samba-Server ... vielleicht unter <b>/mnt/sda1</b>?<br />
Jetzt kann man geschickt Verzeichnisse untereinander verlinken.<br />
<b>ln /mnt/sda1/www  /www/daten</b> <br />
Zugriffssrechte w&auml;ren ebenfalls interessant.
Details folgen.
<br /><br />
<hr />
<br />
<h3>Der /www Verzeichnissbaum.</h3>
<dl>
<dt>/www</dt>
<dd>Alle hier eingefügten Daten werden &ouml;ffentlich.</dd>
<dt>/www/swish-e/</dt>
<dd>Unterverzeichniss f&uuml;r &ouml;ffentliche Daten von swish-e</dd>
<dt>/www/swish-e/indexfiles/</dt>
<dd>Hier liegen die &ouml;ffentlichen Indexfiles von swish-e. Diese Installation ist noch nicht f&uuml;r private Daten vorbereitet.</dd>
<dt>/www/swish-e/indexfiles/local/</dt>
<dd>Hier liegt die Indexdatei aller unter /www gefundenen und indizierten lokalen &ouml;ffentlich zug&auml;nglichen Daten.</dd>
<dt>/www/swish-e/indexfiles/"IPs"/</dt>
<dd>Hier liegen die Indexdateien aller von fremden Computern gefundenen nicht lokalen &ouml;ffentlich zug&auml;nglichen Daten.</dd>
<dt>/www/swish-e/doc/</dt>
<dd>Hier liegt die lokale Doku von swish-e. Sie wurde dem original swish-e packet entnommen.</dd>
<dt>/www/swish-e/indexfiles/merge/</dt>
<dd>Hier liegt die zu einer Datei zusammengefasste Indexdatei aller verfügbaren Indexdateien von fremden Computern und von der lokalen Maschine.</dd>
</dl>
<br /><br />
<hr />
<br />
<h3>Von Scripten genutzte Definitionen.</h3>
<dl>
<dt>services_file=/var/run/services_olsr</dt>
<dd>Diese Datei wird zur Synchronisation der Index-Dateien ausgewertet. </dd>
<dt>olsr-nameservice-plugin: service=Suche</dt>
<dd>Der Service-Eintrag "Swish-e + Suche" wird zur Synchronisation der Index-Dateien benötigt und kann zur Anycast-Suche verwendet werden.</dd>
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
uci set network.anycast.ipaddr=104.21.0.7 2>> $errlogfile
uci set network.anycast.netmask=255.255.255.255 2>> $errlogfile

uci set network.unicast=interface 2>> $errlogfile
uci set network.unicast.ifname=$ifname 2>> $errlogfile
uci set network.unicast.proto=static 2>> $errlogfile
uci set network.unicast.ipaddr=104.130.3.112 2>> $errlogfile
uci set network.unicast.netmask=255.0.0.0 2>> $errlogfile

uci commit network 2>> $errlogfile


cp /etc/config/olsrd /var/log/olsrd-swish-debug0 2>> $errlogfile


echo "Beginn olsrd config..." >> $errlogfile

ziffer=`uci show olsrd | grep olsrd_nameservice |  sed  's/..library=olsrd_nameservice.so.*//' | sed s/olsrd.@LoadPlugin.//` 2>> $errlogfile

echo "olsrd configuration ziffer=$ziffer :" >> $errlogfile

uci set      olsrd.@LoadPlugin[$ziffer].services_file="/var/run/services_olsr" 2>> $errlogfile
uci add_list olsrd.@LoadPlugin[$ziffer].service="http://104.21.0.7:80/cgi-bin/swish-e.cgi|tcp|Swish-e" 2>> $errlogfile
uci set      olsrd.@LoadPlugin[$ziffer].ignore=0 2>> $errlogfile
uci set      olsrd.@Interface[-1].interface="unicast" 2>> $errlogfile
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
uci set olsrd.@Hna4[-1].netaddr=104.21.0.7 2>> $errlogfile
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


