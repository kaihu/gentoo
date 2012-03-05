# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

ESVN_SUB_PROJECT="THEMES"
inherit efl

DESCRIPTION="E17 theme: Efenniht"

IUSE=""

DEPEND=">=media-libs/edje-9999"

RDEPEND="
	${DEPEND}
"
	#Elementary theme is broken as of 5th of March 2012
	#>=media-libs/elementary-9999

src_compile() {
	make ${PN}.edj || die "Compiling E17 theme failed"
	#make elm-${PN}.edj || die "Compiling Elementary theme failed"
}

src_install() {
	insinto /usr/share/enlightenment/data/themes
	doins ${PN}.edj || die "Installing E17 theme failed"
	#insinto /usr/share/elementary/themes/
	#doins elm-${PN}.edj || die "Installing Elementary theme failed"
}
