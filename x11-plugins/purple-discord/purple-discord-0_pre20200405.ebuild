# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Pidgin/Purple PRotocol PLugin for Discord"
HOMEPAGE="https://github.com/EionRobb/purple-discord"
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_COMMIT="db7dc79ee098a0dc4a00cefaf6d488ddddd1202b"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-im/pidgin
dev-vcs/git
dev-libs/json-glib"
RDEPEND="${DEPEND}"


src_prepare(){
	# remove imagemagick dep
	eapply "${FILESDIR}/icons-0_pre20191108.patch"

	eapply_user
}
