# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="libpurple Telegram plugin using tdlib"
HOMEPAGE="https://github.com/ars3niy/tdlib-purple/"
SRC_URI="https://github.com/ars3niy/tdlib-purple/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="rlottie system-rlottie voip +webp"

REQUIRED_USE="system-rlottie? ( rlottie )"

BDEPEND="
	>=dev-util/cmake-3.2
	=net-libs/tdlib-1.7.9
	system-rlottie? ( media-libs/rlottie )
	voip? ( media-libs/libtgvoip )
	webp? (
		media-libs/libpng:0
		media-libs/libwebp:=
	)
"
RDEPEND="net-im/pidgin"

src_configure() {
	local mycmakeargs=(
		-DNoWebp=$(usex !webp)
		-DNoLottie=$(usex !rlottie)
		-DNoBundledLottie=$(usex system-rlottie)
		-DNoVoip=$(usex !voip)
	)

	cmake_src_configure
}
