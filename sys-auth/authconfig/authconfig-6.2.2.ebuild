# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://fedorahosted.org/releases/a/u/authconfig/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="sys-auth/libfprint
	sys-libs/pam"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install
}
