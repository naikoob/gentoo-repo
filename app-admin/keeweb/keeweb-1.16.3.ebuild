# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils pax-utils desktop

DESCRIPTION="KeeWeb password manager"
HOMEPAGE="https://keeweb.info"
SRC_URI="https://github.com/keeweb/keeweb/releases/download/v${PV}/KeeWeb-${PV}.linux.x64.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="gnome-base/gsettings-desktop-schemas
		>=media-libs/libpng-1.2.46:0
		>=x11-libs/cairo-1.14.12:0
		>=x11-libs/gtk+-2.24.31-r1:2
		>=x11-libs/libXtst-1.2.3:0
		"
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="opt/${PN}/*"
QA_PRESTRIPPED="opt/${PN}/*"

pkg_setup(){
	use amd64 && S="${WORKDIR}"
}

src_install(){
	local DEST="/opt/${PN}"
	pax-mark m keeweb
	insinto "${DEST}"
	doins -r *
	dosym "${DEST}/keeweb" "/usr/bin/keeweb"
	domenu "${FILESDIR}/keeweb.desktop"
	newicon "${WORKDIR}/128x128.png" "${PN}.png"
	fperms +x "${DEST}/keeweb"
	fperms +x "${DEST}/chrome-sandbox"
	insinto "/usr/share/licenses/${PN}"
	for i in LICEN*;
	do
		newins "${i}" "${i}"
	done
}

