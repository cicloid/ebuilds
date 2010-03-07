# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit ruby gems
USE_RUBY="ruby18 ruby19"

DESCRIPTION="Passenger gem for use with nginx or apache"
HOMEPAGE="http://www.modrails.com"

LICENSE="MIT"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"

IUSE="nginx"
DEPEND=">=dev-lang/ruby-enterprise-1.8.7"

RDEPEND="${DEPEND}
	>=dev-ruby/rubygems-ee-1.3.6"

src_install() {
	gems_src_install
	use nginx &&
	    pushd "${D}/usr/$(get_libdir)/ruby/gems/1.8/gems/passenger-2.2.11" &&
	    patch -p0 < "${FILESDIR}/headers.patch" &&
	    pushd "${D}usr/$(get_libdir)/ruby/gems/1.8/gems/passenger-2.2.11/ext/nginx" &&
	    OPTIMIZE="yes" rake nginx &&
	    popd
}

pkg_postinst() {
	einfo "If you upgrade from previous version of Phusion Passenger re-emerge nginx:"
	einfo "    emerge nginx"
	einfo ""
	einfo "And dont forget to update your nginx.conf"
	einfo ""
}