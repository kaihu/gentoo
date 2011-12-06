# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Original ebuild Copyright 1999-2007 The LedgerSMB Team

inherit depend.apache webapp eutils

DESCRIPTION="A fork of a popular general ledger software package called SQL-Ledger"
HOMEPAGE="http://ledger-smb.sourceforge.net/"
SRC_URI="mirror://sourceforge/ledger-smb/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="ppc x86"
IUSE="creditcard doc scripting think"

DEPEND=""
RDEPEND=">=dev-db/postgresql-base-8.0
	>=dev-lang/perl-5.8.0
	>=perl-gcpan/Class-Std-0.0.8
        >=dev-perl/Class-MethodMaker-2.08
	>=perl-gcpan/Config-Std-0.0.4
	dev-perl/DBD-Pg
	dev-perl/DBI
        >=dev-perl/HTML-Parser-3.56
	>=dev-perl/HTML-Tagset-3.10
	>=dev-perl/locale-maketext-lexicon-0.62
        >=dev-perl/Log-Agent-0.307
        >=dev-perl/MIME-Lite-3.01
        >=dev-perl/Shell-EnvImporter-1.04
        >=perl-core/i18n-langtags-0.35
        virtual/perl-Digest-MD5
        virtual/perl-Getopt-Long
        >=virtual/perl-locale-maketext-1.10
        virtual/perl-MIME-Base64
	virtual/perl-Time-Local
        app-portage/g-cpan
        creditcard? ( >=dev-perl/Net-TCLink-3.4 )
	scripting? ( >=dev-perl/Parse-RecDescent-1.94 )
	think? ( perl-gcpan/Rose-DB )
	think? ( perl-gcpan/Rose-DB-Object )
	think? ( perl-gcpan/Rose-DateTime )
	think? ( perl-gcpan/Rose-Object )
"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	#cd "${S}"

	# clean up unwanted cruft
	rm -rf configure_apache.sh winprint.bat dists/{deb,rpm,slackware,source,win32} doc/COPYRIGHT
	#rm -f dists/gentoo/*.ebuild dists/gentoo/{ChangeLog,metadata.xml}
	mv doc/manual/*.txt doc/
	use doc || rm -rf doc/coding-standard.* doc/API doc/samples doc/manual
	#mv {Build,Makefile}.PL contrib/
	#mv utils/ contrib/
}

src_install() {
	webapp_src_preinst

	local docs="BUGS COMPATABILITY CONTRIBUTORS Changelog INSTALL README.translations TODO UPGRADE \
		doc/LedgerSMB-manual.* doc/README doc/release_notes"
	dodoc ${docs}
	dohtml -r doc/html_manual doc/faq.html
	rm -rf ${docs} COPYRIGHT LICENSE README.* VERSION doc/html_manual doc/faq.html
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins -r doc/*
		doins -r contrib/
		rm -rf doc/ contrib/
	else
		rm -rf doc/ contrib/
	fi

	cp ${PN}.conf.default ${PN}.conf
	cp -R . "${D}"/${MY_HTDOCSDIR}
	rm -rf "${D}"/${MY_HTDOCSDIR}/dists

	keepdir ${MY_HTDOCSDIR}/spool/
	keepdir ${MY_HTDOCSDIR}/users/
	webapp_serverowned -R ${MY_HTDOCSDIR}/spool/
	webapp_serverowned -R ${MY_HTDOCSDIR}/users/

	webapp_server_configfile apache dists/gentoo/ledger-smb-httpd-gentoo.conf
	webapp_configfile ${MY_HTDOCSDIR}/${PN}.conf
	use creditcard && webapp_configfile ${MY_HTDOCSDIR}/pos.conf.pl

	webapp_postinst_txt en dists/gentoo/post-install.txt

	webapp_src_install
}
