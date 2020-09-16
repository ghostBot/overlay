# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 multilib

DESCRIPTION="libPurple core-answerscripts plugin"
HOMEPAGE="https://github.com/Harvie/libpurple-core-answerscripts"
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_COMMIT="267074cbc216a99cf5ff339f61abd9c9abd8f9f0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-im/pidgin
dev-vcs/git"
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr/$(get_libdir)/purple-2/
	insopts -m755
	doins answerscripts.so
}
