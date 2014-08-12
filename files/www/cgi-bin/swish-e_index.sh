#!/bin/sh

echo Content-type: text/html
echo
echo '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<head>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
<title>Indizierung aller localen Daten</title>
</head>'



echo "<html><body>"
echo "Begin der Indizierung<br>"
echo
echo "<hr>"
echo "<pre>"
echo `swish-e -e -c /etc/swish-e/swish.config -f /www/swish-e/indexfiles/local/index.swish-e -i /www/*`
echo "Erzeuge md5sum ..."
echo `md5sum /www/swish-e/indexfiles/local/index.swish-e > /www/swish-e/indexfiles/local/index.swish-e.md5sums`
echo `md5sum /www/swish-e/indexfiles/local/index.swish-e.prop >> /www/swish-e/indexfiles/local/index.swish-e.md5sums`
echo "</pre>"
echo "<br>md5sum erneuert<br>"
echo "<hr>"
echo "</html></body>"

