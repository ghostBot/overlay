# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit python-any-r1 scons-utils toolchain-funcs cmake

PULSE_VER="13.0"
PULSE_DIR="${WORKDIR}/pulseaudio-${PULSE_VER}/"
OPENFEC_VER="1.4.2.4"
CMAKE_USE_DIR="${WORKDIR}/openfec-${OPENFEC_VER}"
BUILD_DIR="${WORKDIR}/openfec-${OPENFEC_VER}"_build

IUSE="openfec pulseaudio test tools"

DESCRIPTION="Toolkit for real-time audio streaming over the network"
HOMEPAGE="https://roc-streaming.org/"
SRC_URI="https://github.com/roc-streaming/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	openfec? ( https://github.com/roc-streaming/openfec/archive/v1.4.2.4.tar.gz -> openfec-${OPENFEC_VER}.tar.gz )
	pulseaudio? ( https://freedesktop.org/software/pulseaudio/releases/pulseaudio-${PULSE_VER}.tar.xz )"

LICENSE="MPL-2.0 openfec? ( CeCILL-C )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="!test? ( test )"

DEPEND="tools? ( dev-util/gengetopt )
	pulseaudio? ( >=media-sound/pulseaudio-${PULSE_VER} )"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/ragel
	test? ( dev-util/cpputest )"

PATCHES=(
	"${FILESDIR}/0001-Remove-deprecated-scons-call.patch"
	"${FILESDIR}/0002-Fix-compatibility-with-new-SCons.patch"
	"${FILESDIR}/0003-Fix-pulseaudio-build-dir.patch"
	"${FILESDIR}/0004-Fix-gcc-flags.patch"
)

src_prepare(){
	if use openfec; then
		cmake_src_prepare
	else
		default
	fi
}

src_configure(){
	scons_var=(
		CXX=$(tc-getCXX)
		$(usex openfec "--with-openfec-includes=${WORKDIR}/openfec-${OPENFEC_VER}/src --with-libraries=${WORKDIR}/openfec-${OPENFEC_VER}/bin/Gentoo/" "--disable-openfec")
		$(usex pulseaudio "--enable-pulseaudio-modules --with-pulseaudio=${PULSE_DIR} --with-pulseaudio-build-dir=/usr/$(get_libdir)/pulseaudio" "--disable-pulseaudio")
		$(usex test "" "--disable-tests")
		$(usex tools "" "--disable-tools")
		--disable-examples
		--disable-doc
		--disable-sox
		--disable-libunwind
	)

	if use pulseaudio; then
		cd ${PULSE_DIR} || die
		econf \
			--enable-shared \
			--disable-static \
			--disable-tests \
			--disable-manpages \
			--disable-orc \
			--disable-webrtc-aec \
			--without-caps
		cp config.h src/ || die
	fi

	if use openfec; then
		# force static && DEBUG define for not erasing CFLAGS
		local mycmakeargs=(
				"-DBUILD_STATIC_LIBS=ON"
				"-DDEBUG:STRING=ON"
				"-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
		)
		cmake_src_configure
	fi
}

src_compile(){
	use openfec && cmake_src_compile
	escons ${scons_var[@]}
}

src_test(){
	escons ${scons_var[@]} test || die "test failed"
}

src_install(){
	escons  ${scons_var[@]} \
		--prefix="${ED}"/usr \
		--libdir="${ED}"/usr/$(get_libdir) \
		--pulseaudio-module-dir="${ED}$(pulseaudio --dump-conf | sed -n -e 's/^dl-search-path\s=\s//p')" \
		install
}
