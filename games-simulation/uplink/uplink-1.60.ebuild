# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

DESCRIPTION="Uplink is a simulator of the cinematic depiction of 
computer hacking."
HOMEPAGE="http://www.introversion.co.uk/uplink/"
SRC_URI="${P}-1.tar.bz2"

LICENSE="uplink"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="fetch"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_nofetch() {
	einfo "Please download"
	einfo "${SRC_URI}"
	einfo "and place it in ${DISTDIR}"
}

src_install() {
	cd ${WORKDIR}
	insinto ${GAMES_PREFIX_OPT}
	insopts -o root -g games -m 750
	doins -r uplink
	dosym ${GAMES_PREFIX_OPT}/uplink/uplink 
${GAMES_PREFIX_OPT}/bin/uplink
	make_desktop_entry uplink "Uplink" 
"${GAMES_PREFIX_OPT}/uplink/uplink.png" "Game;Simulation"
}
