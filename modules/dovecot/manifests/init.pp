class dovecot {

	$packages = [
		dovecot-common,
		dovecot-imapd,
		dovecot-pop3d,
	]

	package { 
		$packages: ensure => present,
	}
		
	service { "dovecot":
		ensure => running,
		require => Package["dovecot-imapd"],
	}
	
	file { "dovecot.conf" :
		path    => "/etc/dovecot/dovecot.conf",
		source  => "puppet:///modules/dovecot/dovecot.conf",
		require => Package["dovecot-common"],
		notify  => Service["dovecot"],
	}
	
	file { "maildir_cleanup" :
		path => "/etc/cron.daily/maildir_cleanup",
		source => "puppet:///modules/dovecot/maildir_cleanup",
		require => Package["dovecot-common"],
		mode => 755,
	}
	
}