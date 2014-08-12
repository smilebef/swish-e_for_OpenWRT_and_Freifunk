swish-e_for_OpenWRT_and_Freifunk
================================

Makefile and some other files to build swish-e for OpenWRT, Freifunk and OLSR.

This Package have some dependencies.
In the Makefile you can find the entry dependencies. (xpdf,olsr,freifunk-widget, catdoc).
Not all dependencies are needed.


Get the Repository:
git clone https://github.com/smilebef/swish-e_for_OpenWRT_and_Freifunk.git

Copy this files to the OpenWRT Source-Code in a directory:
package/utils/swish-e/
and compile it.

Before compiling you must make menuconfig and make defconfig.

