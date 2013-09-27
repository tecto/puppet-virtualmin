class postfix {

	$packages = [
		postgrey,
		dkim-filter,
		vacation,
		postfix-pcre,
		postfix-policyd-spf-perl,
		libmail-spf-perl,
		#imapproxy,
		postfix,
	]

	package { 
		$packages: ensure => present,
	}

	file { "/etc/postfix/mime_header_checks":
		source => "puppet:///modules/postfix/mime_header_checks",
		require => Package["postfix"],
	}
	
	file { "/etc/postfix/helo.regexp":
		source => "puppet:///modules/postfix/helo.regexp",
		require => Package["postfix"],
	}
	
	exec { "postmap_mime_header_checks":
		command => "postmap /etc/postfix/mime_header_checks",
		require => [ File["/etc/postfix/mime_header_checks"] ],
		creates => "/etc/postfix/mime_header_checks.db",
	}

	file { "/etc/postfix/main.cf":
		source => "puppet:///modules/postfix/main.cf",
		notify => Service["postfix"],
		require => Package["postfix"],
	}
	
	file { "/etc/postfix/master.cf":
		source => "puppet:///modules/postfix/master.cf",
		notify => Service["postfix"],
		require => Package["postfix"],
	}

	service { "postfix":
		ensure  => running,
		require => Package["postfix"],
	}

	mailalias { "root":
		ensure    => present,
		recipient => "noc@YOURDOMAIN.COM",
		require => Package["postfix"],
	}

	mailalias { [ "postmaster" ]:
		ensure    => present,
		recipient => "root",
		require => Package["postfix"],
	}

	augeas { "crontab":
		context => "/files/etc/crontab",
		changes => "set MAILTO root",
	}
	
	#file { "/etc/imapproxy.conf":
	#	source => "puppet:///modules/postfix/imapproxy.conf",
	#	require => Package["imapproxy"],
	#}

}
