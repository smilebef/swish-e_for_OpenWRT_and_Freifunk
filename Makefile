#
# Copyright (C) 2007-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=swish-e
PKG_VERSION:=2.4.7
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://swish-e.org/distribution/
PKG_MD5SUM:=736db7a65aed48bb3e2587c52833642d
#PKG_BUILD_DIR:= # Wo Compilieren? Das Verzeichnis nach dem Entpacken.
#PKG_CAT:= # Wie entpacken
#PKG_BUILD_DEPENDS:= # Pakete zum bauen aber nicht fuer Laufzeit
#PKG_INSTALL:= #  "1" ruft das original "make install" mit Option PKG_INSTALL_DIR
#PKG_INSTALL_DIR:= # Installationsverzeichniss
#PKG_FIXUP:= # Nicht dokumentiert! Für Crosscompile bugs.

# @SF steht für sourceforge.org
# $(BUILD_DIR) ist das Verzeichniss, wo wget aufgerufen wird.



include $(INCLUDE_DIR)/package.mk


define Package/swish-e
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+zlib +libxml2  +xpdf +catdoc  +luci-app-freifunk-widgets +iwinfo +vdftpd-tls +luci-app-samba +luci-theme-openwrt +e2fsprogs +dosfsck +block-mount +busybox +opkg +base-files +uci +wireless-tools +fstools +mtd +dnsmasq +iw +ip +kmod-usb-storage +kmod-usb2 +olsrd-mod-nameservice +olsrd-mod-jsoninfo
  TITLE:=Simple Web Indexing System for Humans - Enhanced
  URL:=http://swish-e.org
endef

define Package/swish-e/description
	Swish-e is a fast, flexible, and free open source system for indexing collections of Web pages or other files.
	The Maintainer has spezialiced this Package to operate together with olsrd, pdftotext, catdoc.
	In the OLSR-Environment swish-e shall be able to performe a decentral WEB-search system.
	To Synchronize swish-e uses a shell-script (under /www/cgi-bin/). This can be entered in the system crontab.
endef


define Build/Compile
	$(call Build/Compile/Default)
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$(PKG_INSTALL_DIR)" install
endef

define Package/swish-e/install	
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/swish-e/
	$(INSTALL_DIR) $(1)/usr/lib/swish-e/perl
	$(INSTALL_DIR) $(1)/usr/lib/swish-e/perl/SWISH
	$(INSTALL_DIR) $(1)/usr/lib/swish-e/perl/SWISH/Filters
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/swish-e
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/www
	$(INSTALL_DIR) $(1)/www/data
	$(INSTALL_DIR) $(1)/www/swish-e
	$(INSTALL_DIR) $(1)/www/swish-e/doc
	$(INSTALL_DIR) $(1)/www/swish-e/indexfiles
	$(INSTALL_DIR) $(1)/www/swish-e/indexfiles/local
	$(INSTALL_DIR) $(1)/www/swish-e/indexfiles/global
	$(INSTALL_DIR) $(1)/www/swish-e/indexfiles/merge
	$(INSTALL_DIR) $(1)/www/cgi-bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib/
	$(CP)  $(PKG_INSTALL_DIR)/usr/lib/swish-e/* $(1)/usr/lib/swish-e/
	$(INSTALL_DATA)   ./files/etc/uci-defaults/*         $(1)/etc/uci-defaults/
	$(INSTALL_DATA)   ./files/etc/swish-e/* $(1)/etc/swish-e/
	$(INSTALL_DATA)   ./files/www/swish.css $(1)/www/
	$(INSTALL_DATA)   ./files/www/swish-e/index.html $(1)/www/swish-e/
	$(INSTALL_DATA)   ./files/www/swish-e/doc/* $(1)/www/swish-e/doc/
	$(INSTALL_DATA)   ./files/www/swish-e/indexfiles/local/* $(1)/www/swish-e/indexfiles/local/
	$(INSTALL_BIN)    ./files/www/cgi-bin/* $(1)/www/cgi-bin/
	#$(INSTALL_BIN)    ./files/usr/bin/* $(1)/usr/bin/

endef

$(eval $(call BuildPackage,swish-e))
