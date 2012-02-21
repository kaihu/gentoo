# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
ESVN_REPO_URI="http://svn.webkit.org/repository/webkit/trunk"

inherit cmake-utils flag-o-matic subversion

DESCRIPTION="Open source web browser engine (EFL version)"
HOMEPAGE="http://trac.webkit.org/wiki/EFLWebKit"

WANT_AUTOTOOLS="no"

LICENSE="LGPL-2 LGPL-2.1 BSD"
IUSE="curl -glib -gstreamer static-libs"
SLOT="0"

RDEPEND="
	dev-libs/libxslt
	virtual/jpeg:0
	media-libs/libpng
	x11-libs/cairo
	glib? (
			dev-libs/glib
			net-libs/libsoup
		)
	!glib? ( net-misc/curl )
	>=dev-db/sqlite-3
	media-libs/edje
	media-libs/evas[fontconfig]
	dev-libs/ecore[X,glib?]
	gstreamer? (
			media-libs/gstreamer:0.10
			>=media-libs/gst-plugins-base-0.10.25:0.10
			dev-libs/glib
		)
	!curl? ( net-libs/libsoup )
	dev-libs/icu
"
DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5.33
	sys-devel/bison
	sys-devel/gettext
	dev-util/gperf
	dev-util/pkgconfig
"

CMAKE_IN_SOURCE_BUILD="enable"

src_configure() {
	[[ gcc-major-version == 4 ]] && [[ gcc-minor-version == 4 ]] && append-flags -fno-strict-aliasing

	mycmakeargs="-DPORT=Efl -DENABLE_BLOB=ON -DENABLE_DATAGRID=ON -DENABLE_FULLSCREEN_API=ON -DENABLE_GEOLOCATION=ON -DENABLE_NOTIFICATIONS=ON -DENABLE_ORIENTATION_EVENTS=ON"
	if ! use glib ; then
		#could have done the whole cmake-utils_use_enable thing here but I'm lazy
		mycmakeargs+=" -DNETWORK_BACKEND=curl -DENABLE_GLIB_SUPPORT=OFF"
	else
		mycmakeargs+=" -DNETWORK_BACKEND=soup -DENABLE_GLIB_SUPPORT=ON"
	fi
	if use gstreamer && ! use glib ; then
		mycmakeargs="${mycmakeargs/curl/soup}"
		mycmakeargs="${mycmakeargs/ENABLE_GLIB_SUPPORT=OFF/ENABLE_GLIB_SUPPORT=ON}"
	fi
	mycmakeargs+=" $(cmake-utils_use_enable gstreamer VIDEO)"
	enable_cmake-utils_src_configure
}
