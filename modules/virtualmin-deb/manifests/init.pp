class virtualmin-deb {

	# wget --quiet http://software.virtualmin.com/lib/RPM-GPG-KEY-virtualmin -O - | apt-key add -
	
	apt::keyfile { "RPM-GPG-KEY-virtualmin":
	
		keyfile => "lib/RPM-GPG-KEY-virtualmin",
		keyid  => "A0BDBCF9",
		server => "software.virtualmin.com",
		ensure => present,
		before => File["/etc/apt/sources.list.d/virtualmin.list"],
		
	}
	
	file { "/etc/apt/sources.list.d/virtualmin.list":
	
		source => "puppet:///modules/virtualmin-deb/virtualmin.list",
		notify	=> Exec["apt-get update virtualmin"],
		
	}
	
	exec { "apt-get update virtualmin":
	
		command	=> "apt-get update",
		refreshonly => true,
		
	}
	
	$packages = [
	
		webmin,
		php-pear,
		webmin-php-pear,
		webmin-virtual-server-theme,
		webmin-virtual-server-mobile,
		usermin,
		usermin-virtual-server-theme,
		usermin-virtual-server-mobile,
		virtualmin-base,
		webmin-virtualmin-git,
		webmin-virtualmin-google-analytics,
		webmin-virtualmin-signup,
		webmin-virtualmin-sqlite,
		webmin-virtualmin-init,
		webmin-security-updates,
		webmin-virtualmin-mailman,
		webmin-virtualmin-svn,
		webmin-virtual-server,
		webmin-virtualmin-dav,
		webmin-virtualmin-htpasswd,
		webmin-virtualmin-awstats,
		clamav,
		clamav-base,
		clamav-daemon,
		clamav-docs,
		clamav-freshclam,
		clamav-testfiles,
		libclamav6,
		spamassassin,
		spamc,
		bind9,
		bind9utils,
		libapache2-mod-fcgid,

	]

	package { 
	
		$packages: ensure => present,
		require => Exec['apt-get update virtualmin'],
		
	}
	
}
