# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
ESVN_SUB_PROJECT="PROTO"

inherit enlightenment

DESCRIPTION="EFL-based photo viewer"
IUSE=""

RDEPEND=">=dev-libs/ecore-9999
	 >=media-libs/evas-9999
	 >=media-libs/elementary-9999"
DEPEND="${RDEPEND}"

CF="-DHAVE_LIMITS_H -DSTDC_HEADERS -DHAVE_MEMCPY=1 -D_GNU_SOURCE=1 -O0 -pipe -Wall -Wextra -g"

src_prepare() {
	echo
}

src_configure() {
	echo
}

src_compile() {
	CFLAGS="$(pkg-config --static --cflags ${DEPS[@]} elementary ecore-x)"
	LIBS="$(pkg-config --static --libs ${DEPS[@]} elementary ecore-x)"
	gcc -c ev.c -o ev.o $CFLAGS $CF || die "gcc ev.c failed"
	gcc *.o -o ev $CFLAGS $CF -L/usr/lib -lc $LIBS || die "gcc .o failed"
}

src_install() {
	insinto /usr/bin
	dobin ev
}
