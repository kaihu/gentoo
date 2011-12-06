# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils python

DESCRIPTION="A 3D framework in C++ with python bindings"
HOMEPAGE="http://panda3d.org"
SRC_URI="http://www.panda3d.org/download/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cg doc egl ffmpeg fftw fmod gles1 gles2 +gtk jpeg npapi ode +openal opencv +opengl png +python ssl swscale +threads tiff truetype wxwidgets xcursor xml xrandr +zlib"

RDEPEND="cg? ( media-gfx/nvidia-cg-toolkit )
		dev-libs/libtar
		doc? ( dev-python/epydoc )
		egl? ( media-libs/mesa )
		ffmpeg? ( media-video/ffmpeg )
		fftw? ( sci-libs/fftw )
		fmod? ( media-libs/fmod )
		gtk? ( x11-libs/gtk+ )
		jpeg? ( media-libs/jpeg )
		npapi? ( net-misc/npapi-sdk )
		ode? ( dev-games/ode )
		openal? ( media-libs/openal )
		opencv? ( media-libs/opencv )
		opengl? ( media-libs/mesa )
		png? ( media-libs/libpng )
		python? ( dev-lang/python )
		ssl? ( dev-libs/openssl )
		tiff? ( media-libs/tiff )
		truetype? ( media-libs/freetype )
		virtual/opengl
		xcursor? ( x11-libs/libXcursor )
		xml? ( dev-libs/tinyxml )
		xrandr? ( x11-libs/libXrandr )
		zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
		sys-devel/automake:1.11"

panda_use() {
	use $1 && {
		if test -n "$2"; then
			echo "--use-$2";
		else
			echo "--use-$1";
		fi
	}
}

pkg_setup() {
	use python && python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/v4l.patch
}

src_compile() {
	cd ${S}
	$(PYTHON) makepanda/makepanda.py \
		--optimize 2 \
		--nothing \
		$(panda_use python) \
		$(panda_use python direct) \
		$(panda_use opengl gl) \
		$(panda_use gles1 gles) \
		$(panda_use gles2) \
		$(panda_use tinydisplay) \
		$(panda_use cg nvidiacg) \
		$(panda_use egl) \
		$(panda_use openal) \
		$(panda_use fmod fmodex) \
		$(panda_use ffmpeg) \
		$(panda_use ode) \
		$(panda_use zlib) \
		$(panda_use png) \
		$(panda_use jpeg) \
		$(panda_use tiff) \
		$(panda_use freetype) \
		$(panda_use ssl openssl) \
		$(panda_use fftw) \
		$(panda_use swscale) \
		$(panda_use opencv) \
		$(panda_use npapi) \
		$(panda_use gtk gtk2) \
		$(panda_use wxwidgets wx) \
		$(panda_use osmesa) \
		$(panda_use X x11) \
		$(panda_use xrandr) \
		$(panda_use xcursor) \
		$(panda_use pandatool) \
		$(panda_use pview) \
		$(panda_use deploytools) \
		$(panda_use contrib) || die "Compile failed"
}

src_install() {
	cd ${S}
	$(PYTHON) makepanda/installpanda.py --destdir="${D}" --prefix=/usr || die "Install failed"
}

pkg_postinst()
{
	elog "Use the 'panda3d' wrapper to run the programs. E.g.: 'panda3d pview -h'"
	if use doc ; then
		elog
		elog "Documentation is available in /opt/panda3d/doc"
		elog "Models are available in /opt/panda3d/models"
	fi
	elog
	elog "For C++ compiling, the include directory must be set:"
	elog "g++ -I/opt/panda3d/include [other flags]"
	if use python ; then
		elog
		elog "ppython is deprecated and panda3d modules are"
		elog "now installed as standard python modules."
		elog "You need to use the 'panda3d' wrapper with the python interpreter."
	fi
	elog
	elog "Tutorials available at http://panda3d.org"
}
