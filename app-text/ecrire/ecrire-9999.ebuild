# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit enlightenment

DESCRIPTION="Text editor using EFL"

DEPEND=">=media-libs/elementary-0.7.0
	>=media-libs/edje-1.1.0
	>=dev-libs/ecore-1.0.0
	>=dev-libs/efreet-1.0.0
	>=sys-devel/gettext-0.17"
RDEPEND="${DEPEND}"
