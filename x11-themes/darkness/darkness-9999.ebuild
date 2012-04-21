# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

ESVN_SUB_PROJECT="THEMES"
inherit efl

DESCRIPTION="E17 theme: Darkness"

IUSE="gtk"

DEPEND=">=media-libs/edje-9999"

RDEPEND="
	${DEPEND}
	>=media-libs/elementary-9999
	gtk? ( x11-libs/gtk+ )
"

src_unpack() {
	efl_src_unpack
	cd ${S}
	#gtk theme
	tar -xjf Tenebrific.tbz2
	#cursor theme
	tar -xjf Ecliz_Full.bz2
}

src_compile() {
	#E17
	edje_cc -DVERSION="${ESVN_WC_REVISION}" -id images/ -fd . ${PN}.edc -o ${PN}.edj || die edje_cc failed
	#Elm
	cd "${S}/elm"
	edje_cc -id . -fd ../fonts  ${PN}-desktop.edc ${PN}-desktop.edj || die edje_cc failed
	edje_cc -id . -fd ../fonts  ${PN}.edc ${PN}.edj || die edje_cc failed
}

src_install() {
	#E17
	insinto /usr/share/enlightenment/data/themes
	doins "${S}"/${PN}.edj || die "Installing E17 theme failed"
	#Elm
	insinto /usr/share/elementary/themes
	doins "${S}"/elm/*.edj || die "Installing Elementary theme failed"
	#GTK
	use gtk && (
	insinto /usr/share/themes
	doins -r "${S}"/Tenebrific || die "Installing GTK+ theme failed"
	)
	#cursors
	insinto /usr/share/icons
	doins -r "${S}"/Ecliz_Full || die "Installing Cursor theme failed"
}
