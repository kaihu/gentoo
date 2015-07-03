# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

E_PKG_IUSE="doc nls"

EFL_USE_GIT="yes"
EFL_GIT_REPO_CATEGORY="core"

inherit efl

DESCRIPTION="Basic widget set, based on EFL with focus mobile touch-screen devices."
HOMEPAGE="https://phab.enlightenment.org/elementary"

LICENSE="LGPL-2.1"

IUSE="cxx-bindings emap location quicklaunch static-libs weather webkit X xcb xdg examples debug"

RDEPEND="
	>=dev-libs/efl-9999
	location? ( >=dev-libs/elocation-9999 )
	emap? ( >=sci-geosciences/emap-9999 )
	weather? ( >=net-libs/libeweather-9999 )
	"
	#webkit? ( >=net-libs/webkit-efl-1.11.0 )
DEPEND="${RDEPEND}"

src_configure() {

	export MY_ECONF="
		${MY_ECONF}
		$(use_enable cxx-bindings)
		$(use_enable examples build-examples)
		$(use_enable examples install-examples)
		$(use_enable debug)
		$(use_enable nls)
		$(use_enable doc)
		$(use_enable emap)
		$(use_enable location elocation)
		$(use_enable quicklaunch quick-launch)
		$(use_enable weather eweather)
		--with-elementary-web-backend=none
	"
		#use X || use xcb && MY_ECONF="${MY_ECONF} --enable-ecore-x"
		#$(use_with webkit elementary-web-backend ewebkit2)
		#$(use_with !webkit elementary-web-backend none)
		#$(use_enable xdg efreet)
		#$(use_enable xcb ecore-x)
	efl_src_configure
}
