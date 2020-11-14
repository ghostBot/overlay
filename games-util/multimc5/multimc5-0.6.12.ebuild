# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 desktop xdg cmake

EGIT_REPO_URI="https://github.com/AfoninZ/MultiMC5-Cracked"
EGIT_COMMIT="ae8cb60f3e9c66a21da43f787e8a7f8417f8ff7b"

QUAZIP_VER="multimc-3"
LIBNBTPLUSPLUS_VER="multimc-0.6.1"

DESCRIPTION="An advanced Qt5-based open-source launcher for Minecraft"
HOMEPAGE="https://multimc.org
	https://github.com/MultiMC/MultiMC5"
BASE_URI="https://github.com/MultiMC"
SRC_URI="
	https://github.com/MultiMC/libnbtplusplus/archive/${LIBNBTPLUSPLUS_VER}.tar.gz -> libnbtplusplus-${LIBNBTPLUSPLUS_VER}.tar.gz
	https://github.com/MultiMC/quazip/archive/${QUAZIP_VER}.tar.gz -> quazip-${QUAZIP_VER}.tar.gz
"

KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
SLOT="0"

COMMON_DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtgui:5
	dev-qt/qttest:5
	dev-qt/qtxml:5
"
DEPEND="${COMMON_DEPEND}
	>=virtual/jdk-1.8.0
"
RDEPEND="${COMMON_DEPEND}
	sys-libs/zlib
	>=virtual/jre-1.8.0
	virtual/opengl
	x11-libs/libXrandr
"

src_unpack() {
	default
	git-r3_fetch
	git-r3_checkout
	rm -rf "${WORKDIR}/${P}/libraries/libnbtplusplus" "${WORKDIR}/${P}/libraries/quazip"
	mv "${WORKDIR}/libnbtplusplus-${LIBNBTPLUSPLUS_VER}" "${WORKDIR}/${P}/libraries/libnbtplusplus" || die
	mv "${WORKDIR}/quazip-${QUAZIP_VER}" "${WORKDIR}/${P}/libraries/quazip" || die
}

src_configure() {
	local mycmakeargs=(
		-DMultiMC_LAYOUT=lin-system
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	domenu application/package/linux/multimc.desktop
	doicon -s scalable application/resources/multimc/scalable/multimc.svg
}

