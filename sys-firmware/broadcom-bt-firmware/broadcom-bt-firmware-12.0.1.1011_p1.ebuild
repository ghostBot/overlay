# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Broadcom Bluetooth firmware for Linux kernel"
HOMEPAGE="https://github.com/winterheart/broadcom-bt-firmware"
SRC_URI="https://github.com/winterheart/broadcom-bt-firmware/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Broadcom"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	insinto /lib/firmware/brcm/
	doins -r brcm/*.hcd || die
}
