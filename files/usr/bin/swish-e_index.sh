#!/bin/sh


swish-e -c /etc/swish-e/swish.config -f /www/swish-e/indexfiles/local/index.swish-e -i ./*

md5sum /www/swish-e/indexfiles/local/index.swish-e > /www/swish-e/indexfiles/local/index.swish-e.md5sums
md5sum /www/swish-e/indexfiles/local/index.swish-e.prop >> /www/swish-e/indexfiles/local/index.swish-e.md5sums