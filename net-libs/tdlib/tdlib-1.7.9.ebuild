# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
SRC_URI="https://github.com/tdlib/td/archive/7d41d9eaa58a6e0927806283252dc9e74eda5512.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="clang java +lto test"

RDEPEND="
	dev-libs/openssl
	sys-libs/zlib
	java? ( virtual/jdk:= )
"
BDEPEND="
	dev-util/gperf
	>=dev-util/cmake-3.0.2
	clang? ( >=sys-devel/clang-3.4:= )
"

S="${WORKDIR}/td-7d41d9eaa58a6e0927806283252dc9e74eda5512"

src_prepare() {
	eapply_user

	if use test; then
		sed -i -e '/run_all_tests/! {/all_tests/d}' \
			test/CMakeLists.txt || die
	else
		sed -i \
			-e '/enable_testing/d' \
			-e '/add_subdirectory.*test/d' \
			CMakeLists.txt || die
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DTD_ENABLE_DOTNET=OFF
		-DTD_ENABLE_JNI=$(usex java)
		-DTD_ENABLE_LTO=$(usex lto)
	)

	cmake_src_configure
}
