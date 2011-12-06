# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=0

inherit depend.apache webapp eutils

DESCRIPTION="An open source financial accounting program."
HOMEPAGE="http://ledgersmb.org/"
SRC_URI="mirror://sourceforge/ledger-smb/${PN}-1.3.2-v1.tar.gz"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="creditcard doc excel odf pdf scripting"

DEPEND=""
RDEPEND=">=dev-db/postgresql-base-8.2
	>=dev-lang/perl-5.8.1
	
	virtual/perl-Data-Dumper
	dev-perl/Log-Log4perl
	virtual/perl-locale-maketext
	dev-perl/DateTime
	>=dev-perl/locale-maketext-lexicon-0.62
	>=dev-perl/DBI-1.00
	virtual/perl-MIME-Base64
	virtual/perl-Digest-MD5
	dev-perl/HTML-Parser
	dev-perl/DBD-Pg
	virtual/perl-Encode
	virtual/perl-Time-Local
	perl-gcpan/PathTools
	perl-gcpan/Class-Std
	perl-gcpan/Config-Std
	dev-perl/MIME-Lite
	>=dev-perl/Template-Toolkit-2.14
	dev-perl/Error
	dev-perl/Cgi-Simple
	dev-perl/File-MimeInfo
	pdf? ( dev-perl/Template-Latex )
	creditcard? ( dev-perl/Net-TCLink )
	odf? ( dev-perl/XML-Twig )
	excel? ( perl-gcpan/Excel-Template-Plus )
	scripting? ( >=dev-perl/Parse-RecDescent-1.94 ) "

#	>=dev-perl/Class-MethodMaker-2.08
#	>=dev-perl/HTML-Tagset-3.10
#	>=dev-perl/Log-Agent-0.307
#	>=dev-perl/Shell-EnvImporter-1.04
#	>=perl-core/i18n-langtags-0.35
#	virtual/perl-Getopt-Long
#	think? ( perl-gcpan/Rose-DB )
#	think? ( perl-gcpan/Rose-DB-Object )
#	think? ( perl-gcpan/Rose-DateTime )
#	think? ( perl-gcpan/Rose-Object )
#"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	#cd "${S}"

	# clean up unwanted cruft
	rm -rf winprint.bat dists/{deb,rpm,slackware,source,win32} doc/COPYRIGHT
	#rm -f dists/gentoo/*.ebuild dists/gentoo/{ChangeLog,metadata.xml}
	#mv doc/manual/*.txt doc/
	#use doc || rm -rf doc/coding-standard.* doc/API doc/samples doc/manual
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
	keepdir ${MY_HTDOCSDIR}/templates/
	keepdir ${MY_HTDOCSDIR}/css/
	webapp_serverowned -R ${MY_HTDOCSDIR}/spool/
	webapp_serverowned -R ${MY_HTDOCSDIR}/templates/
	webapp_serverowned -R ${MY_HTDOCSDIR}/css/

	webapp_server_configfile apache dists/gentoo/ledger-smb-httpd-gentoo.conf
	webapp_configfile ${MY_HTDOCSDIR}/${PN}.conf
	use creditcard && webapp_configfile ${MY_HTDOCSDIR}/pos.conf.pl

	webapp_postinst_txt en dists/gentoo/post-install.txt

	webapp_src_install
}
