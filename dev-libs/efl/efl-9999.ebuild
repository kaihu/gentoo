# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

E_PKG_IUSE="doc nls"

EFL_USE_GIT="yes"
EFL_GIT_REPO_CATEGORY="core"

inherit efl

DESCRIPTION="Enlightenment Foundation Libraries all-in-one package"
HOMEPAGE="https://phab.enlightenment.org/efl"

EFL_IMAGE_LOADER_FLAG_MAP=(
	+bmp:image-loader-bmp +eet:image-loader-eet +gif:image-loader-gif +ico:image-loader-ico
	+jpeg:image-loader-jpeg jp2k:image-loader-jp2k +pmaps:image-loader-pmaps +png:image-loader-png
	+psd:image-loader-psd +tga:image-loader-tga +tiff:image-loader-tiff +wbmp:image-loader-wbmp
	webp:image-loader-webp +xpm:image-loader-xpm +tgv:image-loader-tgv +dds:image-loader-dds
)

IUSE="
	neon
	-liblz4
	systemd
	magic-debug
	+cxx-bindings
	-wayland
	-wayland-ivi-shell
	-fbcon -sdl
	-drm -drm-hw-accel -gl-drm

	+ibus -harfbuzz -egl

	${EFL_IMAGE_LOADER_FLAG_MAP[@]%:*}
	+image-loader-generic

	+tslib +avahi
	gesture xpresent xinput22
	-xine v4l2
	-examples
	-test
	gnutls openssl
	X -xcb
	gles opengl
	glib
	debug

	-i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba

	+physics +threads +fontconfig +fribidi
	-pixman -pixman-font -pixman-rect -pixman-line -pixman-poly -pixman-image -pixman-image-scale-sample
	-tile-rotate -g-main-loop +gstreamer +eo-id +cserve +audio +pulseaudio +xinput2 +xim +scim
	+libmount +multisense
"

REQUIRED_USE="
	openssl?	( !gnutls					)
	X?			( !xcb						)
	opengl?		( !gles						)

	pulseaudio?	( audio						)
	multisense?	( pulseaudio					)

	opengl?		( || ( X xcb sdl wayland )	)
	gles?		( || ( X xcb sdl wayland )	)

	gles?		( egl						)
	sdl?		( || ( opengl gles )		)
	wayland?	( egl || ( opengl gles )	)

	xim?		( || ( X xcb )				)

	xcb?		( pixman i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )

	!physics?	( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!threads?	( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!fontconfig? ( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!fribidi?	( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	pixman?		( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	tile-rotate? ( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	g-main-loop? ( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!gstreamer?	( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!eo-id?		( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!cserve?	( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!audio?		( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!pulseaudio? ( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!xinput2?	( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!xim?		( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!scim?		( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!libmount?	( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
	!multisense? ( i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba )
"

RDEPEND="
	liblz4? ( app-arch/lz4 )
	gnutls? ( net-libs/gnutls )
	openssl? ( dev-libs/openssl )

	glib? ( dev-libs/glib )

	wayland? ( >=dev-libs/wayland-1.2.0 >=x11-libs/libxkbcommon-0.3.1 )

	fontconfig? ( media-libs/fontconfig )

	fribidi? ( dev-libs/fribidi )

	harfbuzz? ( media-libs/harfbuzz )

	pixman? ( x11-libs/pixman )

	audio? ( media-libs/libsndfile )
	pulseaudio? ( media-sound/pulseaudio )

	physics? ( sci-physics/bullet )

	systemd? ( sys-apps/systemd )

	>=sys-apps/util-linux-2.20.0
	virtual/jpeg
	sys-libs/zlib
	sys-apps/dbus
	dev-lang/luajit:2

	png? ( media-libs/libpng )
	gif? ( media-libs/giflib )
	tiff? ( media-libs/tiff )
	tslib? ( x11-libs/tslib )
	webp? ( media-libs/libwebp )

	xine? ( >=media-libs/xine-lib-1.1.1 )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-good:1.0
		)

	X? (
		x11-libs/libXcursor
		x11-libs/libX11
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXinerama
		x11-libs/libXp
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXtst
		x11-libs/libXScrnSaver

		opengl? (
			x11-libs/libX11
			x11-libs/libXrender
			virtual/opengl
		)

		gles? (
			x11-libs/libX11
			x11-libs/libXrender
			virtual/opengl
		)
	)

	xcb? (
		x11-libs/libxcb

		opengl? (
			x11-libs/libX11
			x11-libs/libXrender
			virtual/opengl
			x11-libs/xcb-util-renderutil
		)

		gles? (
			x11-libs/libX11
			x11-libs/libXrender
			virtual/opengl
			x11-libs/xcb-util-renderutil
		)
	)

	sdl? (
		media-libs/libsdl2

		virtual/opengl
	)

	scim?	( app-i18n/scim )
	ibus?	( app-i18n/ibus )

	debug? ( dev-util/valgrind )

	xinput22? ( >=x11-base/xorg-server-1.12 )
"

CORE_EFL_CONFLICTS="
	!dev-libs/ecore
	!dev-libs/edbus
	!dev-libs/eet
	!dev-libs/eeze
	!dev-libs/efreet
	!dev-libs/eina
	!dev-libs/eio
	!dev-libs/embryo
	!dev-libs/eobj
	!dev-libs/ephysics
	!media-libs/edje
	!media-libs/emotion
	!media-libs/ethumb
	!media-libs/evas
"

DEPEND="
	${CORE_EFL_CONFLICTS}

	${RDEPEND}

	doc? ( app-doc/doxygen )
"

pkg_pretend() {
	local conflicts=""

	for i in ${CORE_EFL_CONFLICTS}; do
		has_version ${i#\!} && conflicts+=" ${i#\!}"
	done

	test -z "${conflicts}" && return

	eerror "Portage is unable to automatically resolve conflict with EFL"
	eerror "libraries merged into dev-libs/efl, so please remove them manually"
	eerror
	eerror "emerge -C ${conflicts}"
	eerror

	die "Run emerge  -C ${conflicts}"
}

src_configure() {
	if use openssl
	then
		crypto="openssl"
	else
		if use gnutls
		then
			crypto="gnutls"
		else
			crypto="none"
		fi
	fi

	if use X
	then
		x11="xlib"
	else
		if use xcb
		then
			x11="xcb"
		else
			x11="none"
		fi
	fi

	if use opengl
	then
		opengl="full"
	else
		if use gles
		then
			opengl="es"
		else
			opengl="none"
		fi
	fi

	local enable_graphics="no"
	( use X || use xcb ) && enable_graphics="yes"

	local imgconf=""
	for i in "${EFL_IMAGE_LOADER_FLAG_MAP[@]#+}" ; do
		imgconf+=( $(use_enable ${i%:*} ${i#*:}) )
	done

	export MY_ECONF="
		${MY_ECONF}
		${imgconf}

		$(use_enable nls)
		$(use_enable doc)
		$(use_enable liblz4)
		$(use_enable neon)
		$(use_enable systemd)
		$(use_enable magic-debug)
		$(use_enable debug valgrind)
		$(use_enable threads)
		$(use_enable cxx-bindings)
		$(use_enable wayland)
		$(use_enable wayland-ivi-shell)
		$(use_enable fbcon fb)
		$(use_enable sdl)
		$(use_enable drm)
		$(use_enable drm-hw-accel)
		$(use_enable gl-drm)
		$(use_enable fontconfig)
		$(use_enable fribidi)
		$(use_enable eo-id)
		$(use_enable harfbuzz)
		$(use_enable egl)
		$(use_enable pixman)
		$(use_enable pixman-font)
		$(use_enable pixman-rect)
		$(use_enable pixman-line)
		$(use_enable pixman-poly)
		$(use_enable pixman-image)
		$(use_enable pixman-image-scale-sample)
		$(use_enable tile-rotate)

		$(use_enable image-loader-generic)

		$(use_enable cserve)
		$(use_enable g-main-loop)
		--disable-gstreamer
		$(use_enable gstreamer gstreamer1)
		$(use_enable tslib)
		$(use_enable libmount)
		$(use_enable audio)
		$(use_enable pulseaudio)
		$(use_enable avahi)
		$(use_enable gesture)
		$(use_enable xpresent)
		$(use_enable xinput2)
		$(use_enable xinput22)
		$(use_enable xim)
		$(use_enable scim)
		$(use_enable ibus)
		$(use_enable physics)
		$(use_enable multisense)
		$(use_enable xine)
		$(use_enable v4l2)
		$(use_enable examples always-build-examples)

        $(use_enable i-really-know-what-i-am-doing-and-that-this-will-probably-break-things-and-i-will-fix-them-myself-and-send-patches-aba)

		--with-api=both
		--with-id=gentoo

		--with-crypto=${crypto}

		$(use_with test tests regular)

		$(use_with debug profile debug)
		$(use_with !debug profile release)

		--with-x11=${x11}
		--with-opengl=${opengl}
		--with-x=${enable_graphics}

		$(use_with glib glib yes)
		$(use_with !glib glib no)
	"

	efl_src_configure
}

src_install() {
	export MAKEOPTS="-j1"

	efl_src_install
}
