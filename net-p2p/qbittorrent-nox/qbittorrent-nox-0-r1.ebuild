# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Openrc init for run Qbittorrent as daemon with webui"
HOMEPAGE="https://www.qbittorrent.org/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64"
RDEPEND="
    acct-group/qbittorrent-nox
    acct-user/qbittorrent-nox
    >=net-p2p/qbittorrent-4[webui]
"
DEPEND="${RDEPEND}"

src_install() {
    newinitd "${FILESDIR}"/qbittorrent-nox-r1.initd qbittorrent-nox
    newconfd "${FILESDIR}"/qbittorrent-nox-r1.confd qbittorrent-nox
}
