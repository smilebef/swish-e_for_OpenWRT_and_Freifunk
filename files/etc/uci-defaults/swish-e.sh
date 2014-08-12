#!/bin/sh

ln /www/swish-e/indexfiles/local/index.swish-e /www/swish-e/indexfiles/merge/index.swish-e
ln /www/swish-e/indexfiles/local/index.swish-e.prop /www/swish-e/indexfiles/merge/index.swish-e.prop
ln /www/swish-e/indexfiles/local/index.swish-e.md5sums /www/swish-e/indexfiles/merge/index.swish-e.md5sums


echo '
<hr />
<br />
<a href="/cgi-bin/swish-e.cgi"><h1>SWISH-e Suche</h1></a>
<br />
<hr />
<br />
<a href="/data/"><h1>In den Daten st&ouml;bern</h1></a>
<br />
<hr />
<br />
<h1>Erl&auml;uterungen zum Konzept dieses Fileservers</h1>
<br />
Dieser Fileserver wurde speziell für die Verwendung im Umfeld von Freifunk geschaffen.
<h3>Konzept zur dezentralen Suche</h3>
Der Grundgedanke eine Umgebung zur Dezentralen Suche zu schaffen, kam mir, als ich begriff, wie wichtig es ist große Monopole, ob staatlichen Ursprungs oder privaten Ursprungs zu brechen bzw. zu unterwandern.
Die dezentrale Suche ist ein wesentlicher Bestandteil dieser Bewegung. Sie schafft Konkurenz zu den Medien und zum Internet.
<h3>Technik der dezentralen Suche in diesem Fall</h3>
Die Technik dazu tendiert nach langem Überlegen in eine Richtung.
Kleinste Server sollen Großes leisten können. Wie kann soetwas realisiert werden?<br />
Zum einen mit der Technik der <b>UNICAST/ANYCAST</b> Adressen.<br />
Sollte sich der OLSRD als Leistungsfähig bewähren, dann mit dem Dienst-Service aus dem <b>OLSRD-nameservice-plugin</b>: services bzw. service-file.<br />
In dieser Kombination ist eine Syncronisation von Index-Daten und eine Verfügbarmachung dieses Such-Dienstes möglich.
Und genau hier setzen wir an.
<h2>Konfiguration des Servers</h2>
Die Konfiguration gliedert sich in mehrere Schritte.
<h3>Konfiguration der Adressen ANYCAST/UNICAST</h3>
Es werden zwei Adressen auf einem Interface (Bsp.: LAN) vergeben:
<ul>
<li> Eine davon ist individuell: <b>Unicast</b>.</li>
<li> Eine davon ist vereinheitlicht bzw. gleich: <b>Anycast</b>.</li>
</ul>
Beim Aufruf einer ANYCAST-Adresse wird der Computer dank Routingmechanismen mit dem nächst gelegenen ANYCAST-Server verbunden.
F&uuml;r den Berliner Freifunk stelle ich aus dem 104er Netz eine Adresse aus denen für mich registrierten IP-Adressenbereich zur Verfügung.
104.21.0.7 Diese Adresse kann/sollte als ANYCAST Adresse (nur für die Berliner Freifunk-Umgebung) eingerichtet werden.
Die Unicast-Adresse ist jedem selbst überlassen. Diese muss individuell bei den lokalen Kommunities bezogen/registriert werden.
<h3>Konfiguration der OLSR-Services</h3>
F&uuml;r die Arbeit mit Anycast und f&uuml;r die Syncronisation verschiedener Fileserver m&uuml;ssen nun zwei Dienste mittels OLSRD annonciert werden.
Unter Dienste/OLSR/Plugins/olsrd_nameservice.so kann man den Service einrichten.<br />
Dies ist Definitionssache. Wir einigen uns auf zwei Dienste:
<ul>
<li>Der Dienst <b>swish-e</b> wird zum Synchronisieren der Server untereinander (annoncieren der Unicast-IP) benötigt.</li>
<li>Der Dienst <b>Suchen</b> wird zum Suchen (annoncieren der ANYCAST-IP) benötigt.</li>
</ul>
Die Option "service" im nameservice-plugin bekommt einen Eintrag wie folgt:<br />
<b>"104.45.1.34|tcp|swish-e"</b>.<br />
Dieser Eintrag soll zum Zwecke der Pflege und Datensyncronisation die UNICAST-Adresse annoncieren.<br />
Die ANICAST-Adresse wird ebenfalls mittels dem Nameservice-plugin unter service annonciert:<br />
<b>"104.21.0.7|tcp|Suchen"</b>.<br />
<h3>Konfiguration der OLSRD</h3>
Nun folgt die Frage wie man den OLSRD konfigueriert.
Hier gibt es mehrere Möglichkeiten:
<ol>
<li>Die erste Möglichkeit ist, den OLSRD das UNICAST-Interface zuzuteien und das ANYCAST-Interface per HNA zu annonzieren.</li>
<li>Die zweite Möglichkeit ist es beide Adressen dem OLSRD zuzuteilen.</li>
<li>Die dritte Möglichkeit ist es die Anycast-Adresse dem OLSRD zuzuteilen und die Unicast-Adresse per HNA zu annonzieren.</li>
</ol>
Welche Variante die bessere/richtige muß noch in der Praxis getestet werden.
<br /><br />
<hr />
<br />
<h1>Eine Möglichkeit zum Einrichten einer eigenen Webseite</h1>
<br />
<hr />
<br />
Es ist möglich die Luci-Seite <b>"/www/index.html"</b> beliebig umzubenennen und eine eigene Seite an diese Stelle zu platzieren.
Die umbenannte Luci-Seite könnte dann mittels eines Links (siehe google: selfhtml) auf der eigenen Seite referenzieren.
<br /><br />
<hr />
<br />
<h1>Einrichten von Datenträgern</h1>
<br />
<hr />
<br />
Nun stellt sich die Frage, wie man am besten einen Datenträger einrichtet. <br />
Es gibt zur Auswahl:
<ul>
<li> (S)FTP </li>
<li> HTTP(S) </li>
<li> Samba </li>
</ul>
Bei den Servern handelt es sich primär nicht um besonders leistungsfähige Programme sondern um besonders sparsame Programme.
OpenWRT-Packete wie block-mount, samba-server, vsftpd, uhttpd bilden derzeit die Grundlage der Software.
Diese Programme k&ouml;nnen letztlich nach Vorlieben ersetzt oder ergänzt werden.
Die Zugriffsrechte sind ebenfalls beliebig zuteilbar.
Um hier einen Anfang zu machen habe ich mir folgendes gedacht.
Das block-mount Tool mountet einen Datenträger standardmä&szlig;ig nach /mnt/sda1 (Erster scsi-Datenträger, erste Partition).
Dies könnten wir so lassen. Fakt ist jedoch, dass <b>swish-e</b> alle Daten unter <b>/www</b> indiziert.
Es wäre also klug, das Verzeichnis, welches öffentlich gefunden werden soll unter /www (Beispiel: <b>/www/daten</b>) zu verlinken.
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
Zugriffssrechte wären ebenfalls interessant.
Details folgen.
<br /><br />
<hr />
<br />
<h3>Der /www Verzeichnissbaum.</h3>
<dl>
<dt>/www</dt>
<dd>Alle hier eingefügten Daten werden öffentlich.</dd>
<dt>/www/swish-e/</dt>
<dd>Unterverzeichniss f&uuml;r &ouml;ffentliche Daten von swish-e</dd>
<dt>/www/swish-e/indexfiles/</dt>
<dd>Hier liegen die &ouml;ffentlichen Indexfiles von swish-e. Diese Installation ist noch nicht f&uuml;r private Daten vorbereitet.</dd>
<dt>/www/swish-e/indexfiles/local/</dt>
<dd>Hier liegt die Indexdatei aller unter /www gefundenen und indizierten lokalen &ouml;ffentlich zugänglichen Daten.</dd>
<dt>/www/swish-e/indexfiles/"IPs"/</dt>
<dd>Hier liegen die Indexdateien aller von fremden Computern gefundenen nicht lokalen &ouml;ffentlich zugänglichen Daten.</dd>
<dt>/www/swish-e/doc/</dt>
<dd>Hier liegt die lokale Doku von swish-e. Sie wurde dem original swish-e packet entnommen.</dd>
<dt>/www/swish-e/indexfiles/merge/</dt>
<dd>Hier liegt die zu einer Datei zusammengefasste Indexdatei aller verfügbaren Indexdateien von fremden Computern und von der lokalen Maschine.</dd>
</dl>
<br /><br />
<hr />
<br />
<h3>Diverse Dateien und Einstellungen.</h3>
<dl>
<dt>services_file=/var/run/services_olsr</dt>
<dd>Diese Datei wird vom Script zur Synchronisation unter olsr ausgewertet. </dd>
<dt>service=swish-e</dt>
<dd>Der Service "swish-e" wird ebenfalls zur Synchronisation verwendet.</dd>
<dt>service=Suche</dt>
<dd>Der Service "Suche" kann zur Anycast-Suche verwendet werden.</dd>
</dl>
<br /><br />
<hr />
<br />

' > /www/luci-static/index_user.html

uci set freifunk.community.DefaultText=disabled && uci commit


