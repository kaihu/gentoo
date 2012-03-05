# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

ESVN_SUB_PROJECT="THEMES"
inherit efl

DESCRIPTION="E17 theme: 23Oz"

IUSE="gtk"

DEPEND=">=media-libs/edje-9999"

RDEPEND="
	${DEPEND}
	gtk? ( x11-libs/gtk+ )
"

src_unpack() {
	efl_src_unpack
	use gtk && (
		cd "${S}"
		tar -xjf ${PN}-gtk.tar.bz2
	)
}

src_compile() {
	edje_cc -DVERSION="${ESVN_WC_REVISION}" -id images/ -fd . default.edc -o ${PN}.edj || die edje_cc failed
}

src_install() {
	#E17
	insinto /usr/share/enlightenment/data/themes
	doins "${S}"/${PN}.edj || die "Installing E17 theme failed"
	#GTK
	insinto /usr/share/themes
	doins -r "${S}"/${PN} || die "Installing GTK+ theme failed"
}
