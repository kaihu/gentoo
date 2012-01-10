# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

ESVN_SUB_PROJECT="THEMES"
inherit enlightenment

DESCRIPTION="E17 theme: Detourious"

IUSE="gtk"

DEPEND=">=media-libs/edje-9999
	gtk? ( 	x11-themes/gtk-engines-murrine
		x11-themes/gtk-engines-equinox )"

RDEPEND="${DEPEND}"

src_prepare () {
	echo
}

src_configure() {
	echo
}

src_install() {
	insinto /usr/share/enlightenment/data/themes
	doins ${PN}.edj
	doins ${PN}-dark.edj
	insinto /usr/share/elementary/themes/
	doins ${PN}-elm.edj
	use gtk && {
		insinto /usr/share/themes
		doins -r gtk/${PN}
	}
}
