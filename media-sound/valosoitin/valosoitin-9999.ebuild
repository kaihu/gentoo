# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

E_PKG_IUSE="doc nls"

PYTHON_DEPEND="*:2.7"

inherit python distutils bzr

EBZR_REPO_URI="https://launchpad.net/${PN}"
HOMEPAGE="http://launchpad.net/${PN}"
DESCRIPTION="Valosoitin is an audio player for EFL"

IUSE=""

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	>=dev-python/python-evas-9999
	>=dev-python/python-ecore-9999
	>=dev-python/python-elementary-9999
	>=dev-python/python-emotion-9999
    media-libs/mutagen
"
