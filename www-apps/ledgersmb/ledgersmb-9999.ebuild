# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#

inherit depend.apache webapp eutils subversion

DESCRIPTION="LedgerSMB is an Open source web-based accounting application for Small and Medium buisnesses."
HOMEPAGE="http://www.ledgersmb.org/"
if [[ ${PV} != *9999* ]]; then
        SRC_URI="http://downloads.sourceforge.net/ledger-smb/files/${P}.tar.gz"
        KEYWORDS="amd64 hppa ppc ~sparc x86"
	WEBAPP_MANUAL_SLOT="yes"
        SLOT="3"
else
        ESVN_REPO_URI="svn://svn.code.sf.net/p/ledger-smb/code/trunk"
        ESVN_PROJECT="${PN}"
        KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
        WEBAPP_MANUAL_SLOT="yes"
        SLOT="4"
fi

ESVN_REPO_URI="svn://svn.code.sf.net/p/ledger-smb/code/trunk"
ESVN_PROJECT="${PN}"
# don't use the gentoo mirrors yet, we're not there.
RESTRICT='mirror'
#RESTRICT="fetch"

LICENSE="GPL-2"



#creditcard use is for credit card processing
#doc adds documentation
#latex - Adds support for pdf and ps printing via LaTeX (typesetting package)
#think pulls in the deps for the think-electric patches
#xml pulls in xml and openoffice output deps
IUSE="creditcard doc scripting latex think xml"

DEPEND=""
#new 1.4 deps added:
#virtual/perl-Data-Dumper pulled in by dev-perl/Class-Std
#dev-perl/Contextual-Return
#dev-perl/Log-Log4perl
#Locale-Maketext pulled in by dev-perl/locale-maketext-lexicon
#DateTime pulled in by DateTime-Format-Strptime or perl-gcpan/Rose-DB-Object
#HTML-Entities provided by dev-perl/HTML-Parser
#dev-perl/Moose
#IO-File provided by perl-core/IO
#IO-Scalar provided by dev-perl/IO-stringy
#Encode provided by html perl-core/Encode virtual/perl-Encode pulled in by other stuff I think
#Time-Local virtual/perl-Time-Localpulled in by other stuff I think
#Cwd virtual/perl-File-Spec pulled in by dev-perl/DBI
#Config-IniFiles -new dep added

#Template dev-perl/Template-Toolkit ?
#Error dev-perl/Error added dep
#CGI-Simple added dep dev-perl/Cgi-Simple
#File-MimeInfo added dep dev-perl/File-MimeInfo
#Number-Format added dep dev-perl/Number-Format
#DateTime-Format-Strptime added dep dev-perl/DateTime-Format-Strptime added dep
#NOTE: perl-cgpan appears to have a bug and cannot make a Net_TCLink-3.4 ebuild
#include a hand modified one.

#keep 1.2 deps
ewarn 	"This package currently requires perl-gcpan/Config-Std"
ewarn    "Please run the following command before emerging:"
ewarn    "g-cpan -i Config::Std"
RDEPEND=">=dev-db/postgresql-base-8.4.4
	>=dev-lang/perl-5.8.0
	dev-perl/Cgi-Simple
	>=dev-perl/Class-MethodMaker-2.08
	>=dev-perl/Class-Std-0.0.8
	dev-perl/Config-IniFiles
	>=perl-gcpan/Config-Std-0.0.4
	dev-perl/Contextual-Return
	dev-perl/DateTime-Format-Strptime
	dev-perl/DBD-Pg
	>=dev-perl/DBI-0.46
	dev-perl/Error
	dev-perl/File-MimeInfo
	dev-perl/JSON
	>=dev-perl/HTML-Parser-3.56
	>=dev-perl/HTML-Tagset-3.10
	>=dev-perl/locale-maketext-lexicon-0.62
	>=dev-perl/Log-Agent-0.307
	dev-perl/Log-Log4perl
	>=dev-perl/MIME-Lite-3.01
	dev-perl/Moose
	dev-perl/Number-Format
	>=dev-perl/Shell-EnvImporter-1.04
	dev-perl/Template-Toolkit
	dev-perl/Test-Trap
	dev-perl/Test-Exception
	>=perl-core/I18N-LangTags-0.35
	virtual/perl-Digest-MD5
	virtual/perl-Getopt-Long
	>=virtual/perl-Locale-Maketext-1.10
	virtual/perl-MIME-Base64
	virtual/perl-Time-Local		
	creditcard? ( >=perl-gcpan/Net_TCLink-3.4 )
	scripting? ( >=dev-perl/Parse-RecDescent-1.94 )	
	latex? ( dev-perl/ImageSize ) 
	latex? ( dev-perl/Template-Latex )
	latex? ( virtual/latex-base )
	think? ( dev-perl/Date-Calc )
	think? ( dev-perl/Net-SMTP-TLS-ButMaintained )
	think? ( perl-gcpan/Rose-DB )
	think? ( perl-gcpan/Rose-DateTime )
	think? ( perl-gcpan/Rose-Object )
	xml? ( perl-gcpan/OpenOffice-OODoc )
	xml? ( dev-perl/XML-Simple )
	xml? ( dev-perl/XML-Twig )
	"

need_apache

S=${WORKDIR}/${PN}

if [[ ${PV} != *9999* ]]; then
  src_unpack() {
	unpack ${A}
	cd "${S}"
  }
fi

if [[ ${PV} != *9999* ]]; then
  src_prepare() {
	# clean up unwanted cruft
	rm -rf configure_apache.sh winprint.bat dists/{deb,rpm,slackware,source,win32} doc/COPYRIGHT
	rm -f dists/gentoo/*.ebuild dists/gentoo/{ChangeLog,metadata.xml}
	mv doc/manual/*.txt doc/
	use doc || rm -rf doc/coding-standard.* doc/API doc/samples doc/manual
	mv {Build,Makefile}.PL contrib/
	mv utils/ contrib/
	}
fi

src_install() {
	webapp_src_preinst

	local httpd httpd_ver docs="BUGS COMPATABILITY CONTRIBUTORS Changelog INSTALL README.translations TODO UPGRADE \
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
	
	#Set Gentoo postgresql contrib path for 9.0 and up
	sed "s|contrib_dir = /usr/share/pgsql/contrib/|contrib_dir = /usr/share/postgresql/extension/|" -i ${PN}.conf
	
	cp -R . "${D}"/${MY_HTDOCSDIR}
	rm -rf "${D}"/${MY_HTDOCSDIR}/dists

	keepdir ${MY_HTDOCSDIR}/spool/
	keepdir ${MY_HTDOCSDIR}/users/
	webapp_serverowned -R ${MY_HTDOCSDIR}/spool/
	webapp_serverowned -R ${MY_HTDOCSDIR}/users/
	
	
	#make a check_server() code block? 
	#local httpd httpd_ver 
	httpd_ver=$(best_version www-servers/apache) 
	case $httpd_ver in 
	*2.4.*) einfo "Configuring for new Apache 2.4 series: $httpd_ver" 
	    httpd=apache conf='ledgersmb-httpd-2.4.conf' ;;   
	*2.2.*) einfo "Configuring for Apache 2.2: $httpd_ver" 
	    httpd=apache conf='ledgersmb-httpd-2.0-2.2.conf' ;;
	'') false ;;
	*) ewarn "Unsupported apache version: $httpd_ver"; false #or die?
	esac  
	einfo "Webserver is $httpd config file is $conf"

	#Where to keep files?
	#if webapp_server_configfile apache dists/gentoo/$conf
	#else
	#webapp_server_configfile apache ${FILESDIR}/${P}/$conf
	einfo "Copying config files to ${MY_SERVERCONFIGDIR}"
	webapp_server_configfile apache ${FILESDIR}/$conf
	webapp_configfile ${MY_HTDOCSDIR}/${PN}.conf
	
	#comment out for now since I could not find this file:
	#use creditcard && webapp_configfile ${MY_HTDOCSDIR}/pos.conf.pl 
	
	webapp_postinst_txt en ${FILESDIR}/post-install.txt

	webapp_src_install
	
	local alt
	#I am not sure how webapp-config can make a generic/dynamic
	#apache config file with the ${MY_HTDOCSDIR} with the $conf ledgersmb-httpd-2.4.conf

	einfo "Create databases by directing your web browser"
	#So if the base URL is http://localhost/ledgersmb/, 
	einfo "to the database setup and upgrade script at:"
	if use vhosts; then
	  einfo "http://localhost/ledgersmb/setup.pl."
	else
	  einfo "http://${VHOST_ROOT}/ledgersmb/setup.pl."
	fi
	#Should this be a reconfig hook script ?
	einfo "Setting up ledgersmb-httpd.conf file for ${VHOST_HOSTNAME}"
	einfo "My install dir is ${MY_INSTALLDIR}"
	einfo "files that should not be served by the webserver are in ${MY_HOSTROOTDIR}/${PF}"
	path=/var/www/${VHOST_HOSTNAME}/htdocs/${PN}
	einfo "Path in config file is $path or ${VHOST_ROOT}" 
	cp "${FILESDIR}"/$conf ledgersmb-httpd-1.conf || cp $conf.template ledgersmb-httpd-1.conf && alt="t" || die "Cant copy files"
	if [[$alt="t"]];
	then
	  einfo "$alt is true $conf.template copied to $path/ledgersmb-httpd-1.conf"
	  sed "s|WORKING_DIR|$path|" -i ${MY_INSTALLDIR}/ledgersmb-httpd-1.conf || die "Sed failed"
	else
	  einfo "$alt is false $path/$conf copied to $path/ledgersmb-httpd-1.conf"
	  pwd | einfo
	  sed "s|\${MY_HTDOCSDIR}|$path|" -i ledgersmb-httpd-1.conf || die "Sed failed"
	fi
}

# Notes from http://www.gentoo.org/proj/en/webapps/webapp-eclass.xml
# By default, webapp.eclass will be found under /usr/portage/eclass/. 
