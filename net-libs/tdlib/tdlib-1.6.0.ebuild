# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
SRC_URI="https://github.com/tdlib/td/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="java +lto"

DEPEND="
    dev-libs/openssl
    sys-libs/zlib
    java? ( virtual/jdk )
"
RDEPEND="${DEPEND}"
BDEPEND="
    dev-util/gperf
    >=dev-util/cmake-3.0.2
"
S="${WORKDIR}/td-${PV}"

src_configure() {
    local mycmakeargs=(
        -DTD_ENABLE_DOTNET=OFF
        -DTD_ENABLE_JNI=$(usex java)
        -DTD_ENABLE_LTO=$(usex lto)
    )

    cmake_src_configure
}
