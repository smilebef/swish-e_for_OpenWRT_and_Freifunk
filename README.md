swish-e_for_OpenWRT_and_Freifunk
================================

Makefile and some other files to build swish-e for OpenWRT, Freifunk and OLSR.

Dependencies for full Support in Freifunk and OpenWRT:
------------------------------------------------------
smilebef/catdoc_for_OpenWRT_and_Freifunk,

smilebef/xpdf_for_OpenWRT_and_Freifunk


Install:
--------
Get the Repository:

> git clone https://github.com/smilebef/swish-e_for_OpenWRT_and_Freifunk.git

Copy the Folder with all the files to the OpenWRT Source-Code to:

 package/utils/swish-e/

Call
> make menuconfig

Enable swish-e in Utilitys/swish-e and compile it.
> make

Do for RasspberryPI
> dd if=bin/brcm2708/openwrt-brcm2708-bcm2708-sdcard-vfat-ext4.img of=/dev/mmc... bs=10M



