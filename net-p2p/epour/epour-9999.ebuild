# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

E_PKG_IUSE="doc nls"

PYTHON_DEPEND="*:2.7"

inherit python distutils bzr

EBZR_REPO_URI="https://launchpad.net/epour"
HOMEPAGE="http://launchpad.net/epour"
DESCRIPTION="Epour is a simple bittorrent client using EFL and libtorrent"

IUSE=""

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	>=dev-python/python-evas-9999
	>=dev-python/python-ecore-9999
	>=dev-python/python-elementary-9999
    net-libs/rb_libtorrent[python]
"
