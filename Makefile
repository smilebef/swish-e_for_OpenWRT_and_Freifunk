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
	DEPENDS:=+zlib +libxml2 +xpdf +catdoc
	# zu freifunk4swish #   +luci-app-freifunk-widgets +iwinfo +vdftpd-tls +luci-app-samba +luci-theme-openwrt +e2fsprogs +dosfsck +block-mount +busybox +opkg +base-files +uci +wireless-tools +fstools +mtd +dnsmasq +iw +ip +kmod-usb-storage +kmod-usb2 
	# +olsrd-mod-nameservice +olsrd-mod-jsoninfo +CONFIG_BUSYBOX_CONFIG_DC
	TITLE:=Simple Web Indexing System for Humans - Enhanced
	URL:=http://swish-e.org
endef

define Package/swish-e/description
	Swish-e is a fast, flexible, and free open source system for indexing collections of Web pages or other files.
	The Maintainer has spezialiced this Package to operate together with olsrd, pdftotext, catdoc.
	In the OLSR-Environment swish-e shall be able to performe a decentral WEB-search system.
	To Synchronize swish-e uses a shell-script (under /www/cgi-bin/). This can be entered in the system crontab.
endef


define Package/swish-e4Freifunk
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+swish-e +luci-app-freifunk-widgets +iwinfo +vdftpd-tls +luci-app-samba +luci-theme-openwrt +e2fsprogs +dosfsck +block-mount +busybox +opkg +base-files +uci +wireless-tools +fstools +mtd +dnsmasq +iw +ip +kmod-usb-storage +kmod-usb2 +luci-app-olsr-services +luci-mod-admin-full +luci-ssl +luci-mod-freifunk +luci-lib-json +luci-app-freifunk-widgets
	TITLE:=special configuration for Freifunk
endef



define Build/Compile
	$(call Build/Compile/Default)
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$(PKG_INSTALL_DIR)" install
endef


define Package/swish-e/install	
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/swish-e/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig/
	$(INSTALL_DIR) $(1)/usr/lib/swish-e/perl
	$(INSTALL_DIR) $(1)/usr/lib/swish-e/perl/SWISH
	$(INSTALL_DIR) $(1)/usr/lib/swish-e/perl/SWISH/Filters
	$(INSTALL_DIR) $(1)/usr/include/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/swish-e
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/*.a $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/*.la $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/libswish-e.so.2.0.0 $(1)/usr/lib/
	$(LN) /usr/lib/libswish-e.so.2.0.0 $(1)/usr/lib/libswish-e.so.2
	$(LN) /usr/lib/libswish-e.so.2.0.0 $(1)/usr/lib/libswish-e.so
	$(CP) /usr/lib/swish-e/* $(1)/usr/lib/swish-e/
	$(INSTALL_DATA)   $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(INSTALL_DATA)   $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/* $(1)/usr/lib/pkgconfig/
	#$(INSTALL_DATA)   ./files/etc/uci-defaults/*         $(1)/etc/uci-defaults/
	$(INSTALL_DATA)   ./files/etc/swish-e/* $(1)/etc/swish-e/
endef

define Package/swish-e4Freifunk/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/swish-e
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/www
	$(INSTALL_DIR) $(1)/www/data
	$(INSTALL_DIR) $(1)/www/swish-e
	$(INSTALL_DIR) $(1)/www/swish-e/doc
	$(INSTALL_DIR) $(1)/www/data/indexfiles
	$(INSTALL_DIR) $(1)/www/data/indexfiles/local
	$(INSTALL_DIR) $(1)/www/data/indexfiles/global
	$(INSTALL_DIR) $(1)/www/data/indexfiles/merge
	$(INSTALL_DIR) $(1)/www/cgi-bin
	#$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	#$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/*.a $(1)/usr/lib/
	#$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/*.la $(1)/usr/lib/
	#$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/libswish-e.so.2.0.0 $(1)/usr/lib/
	#$(LN) /usr/lib/libswish-e.so.2.0.0 $(1)/usr/lib/libswish-e.so.2
	#$(LN) /usr/lib/libswish-e.so.2.0.0 $(1)/usr/lib/libswish-e.so
	#$(CP) /usr/lib/swish-e/* $(1)/usr/lib/swish-e/
	#$(INSTALL_DATA)   $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	#$(INSTALL_DATA)   $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/* $(1)/usr/lib/pkgconfig/
	$(INSTALL_DATA)   ./files/etc/uci-defaults/*         $(1)/etc/uci-defaults/
	$(INSTALL_DATA)   ./files/etc/swish-e/* $(1)/etc/swish-e/
	$(INSTALL_DATA)   ./files/www/swish.css $(1)/www/
	$(INSTALL_DATA)   ./files/www/swish-e/index.html $(1)/www/swish-e/
	$(INSTALL_DATA)   ./files/www/swish-e/doc/* $(1)/www/swish-e/doc/
	##$(INSTALL_DATA)   ./files/www/data/indexfiles/local/* $(1)/www/data/indexfiles/local/
	$(INSTALL_BIN)    ./files/www/cgi-bin/* $(1)/www/cgi-bin/
	##$(INSTALL_BIN)    ./files/usr/bin/* $(1)/usr/bin/
endef

$(eval $(call BuildPackage,swish-e))
$(eval $(call BuildPackage,swish-e4Freifunk))

