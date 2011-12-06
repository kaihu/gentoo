# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

E_PKG_IUSE="doc nls"

inherit eutils flag-o-matic mercurial autotools

DESCRIPTION="Enna Media Center"
HOMEPAGE="http://enna.geexbox.org/"
#SRC_URI="http://${PN}.geexbox.org/releases/${P}.tar.bz2"
: ${EHG_REPO_URI:=http://hg.geexbox.org/${PN}}

IUSE="nls -cdda cddb dvd curl lirc upnp xml X"

RDEPEND=">=media-libs/libplayer-2.0.0
	>=media-libs/libvalhalla-2.0.0
	>=dev-libs/eina-1.0.0
	>=dev-libs/eet-1.4.0
	>=media-libs/evas-1.0.0
	>=dev-libs/ecore-1.0.0
	>=media-libs/edje-1.0.0
	>=media-libs/elementary-0.7.0
	>=dev-libs/efreet-1.0.0
	>=dev-libs/e_dbus-1.0.0
	>=media-libs/ethumb-0.1.0
	nls? ( sys-devel/gettext )
	cddb? ( media-libs/libcddb )
	xml? ( dev-libs/libxml2 )
	upnp? ( net-libs/gupnp )
	curl? ( net-misc/curl )
	lirc? ( app-misc/lirc )
"
#	>=dev-libs/embryo-0.9.9.063

DEPEND="${RDEPEND}"

#TODO:
#an interface to VDR via SVDRP protocol
#libsvdrp (http://hg.geexbox.org/libsvdrp/)

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

src_unpack() {
	mercurial_src_unpack
	cd ${S}
	sh ./autogen.sh
}

src_configure() {
	local myconf="
		--enable-activity-tv
		$(use_enable nls)
		$(use_enable cddb libcddb)
		$(use_enable curl libcurl)
		$(use_enable dvd browser-dvd)
		$(use_enable cdda browser-cdda)
		$(use_enable upnp browser-upnp)
		$(use_enable xml libxml2)
		$(use_enable X libxrandr)
	"
#		--enable-browser-netstreams
#		--enable-activity-games

	econf ${myconf} || die "configure failed"
}

src_install() {
	 emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS README
}
