# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for qbittorrent-nox"

ACCT_USER_ID=-1
ACCT_USER_HOME=/var/lib/qBittorrent/
ACCT_USER_GROUPS=( qbittorrent )

acct-user_add_deps
