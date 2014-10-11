#!/bin/sh

services_file=/var/run/services_olsr

if [ -f $services_file ]; then
	Liste=`cat /var/run/services_olsr |grep swish | grep -v own | cut -d# -f2`

fi



for i in $Liste; do
	echo $i
        if [ -e /www/swish-e/indexfiles/$i ]; then
                mkdir /www/swish-e/indexfiles/$i
	fi
        wget http://$i/swish-e/indexfiles/local/index.swish-e.md5 -O /www/swish-e/indexfiles/$i/index.swish-e.md5
	wget http://$i/swish-e/indexfiles/local/index.swish-e.propmd5 -O /www/swish-e/indexfiles/$i/index.swish-e.prop.md5
        if [ ! md5sum -c /www/swish-e/indexfiles/$i/index.swish-e.md5 ]; then
                wget http://$i/swish-e/indexfiles/local/index.swish-e -O /www/swish-e/indexfiles/$i/index.swish-e
	fi
			
        if [ ! md5sum -c /www/swish-e/indexfiles/$i/index.swish-e.prop.md5 ]; then
                wget http://$i/swish-e/indexfiles/local/index.swish-e.prop -O /www/swish-e/indexfiles/$i/index.swish-e.prop
        fi

done
