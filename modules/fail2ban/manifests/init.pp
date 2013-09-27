class fail2ban {

	# http://www.howtoforge.com/fail2ban_debian_etch
	# http://www.faqforge.com/linux/controlpanels/ispconfig3/configure-fail2ban-to-use-route-instead-of-iptables-to-block-connections/
	# http://forum.openvz.org/index.php?t=msg&goto=41276&
	# http://wiki.dovecot.org/HowTo/Fail2Ban
	# http://www.dovecot.org/list/dovecot/2009-May/039447.html
	# http://www.fail2ban.org/wiki/index.php/Dovecot
	# http://www.virtualmin.com/node/20165
	# http://www.fail2ban.org/wiki/index.php/Postfix
	
	$packages = [
		fail2ban,
	]

	package { 
		$packages: ensure => present,
	}

	service { "fail2ban":
		ensure    => running,
		enable    => true,
		require   => [
			Package["fail2ban"],
			File["/etc/fail2ban/jail.local"],
			File["/etc/fail2ban/action.d/route.conf"],
			File["/etc/fail2ban/filter.d/dovecot-pop3imap.conf"],
			File["/etc/fail2ban/filter.d/postfix.conf"],
		]
	}

	file { "/etc/fail2ban/jail.local":
		source  => "puppet:///modules/fail2ban/jail.local",
		require => Package["fail2ban"],
	}
	
	file { "/etc/fail2ban/action.d/route.conf":
		source  => "puppet:///modules/fail2ban/route.conf",
		require => Package["fail2ban"],
	}
	
	file { "/etc/fail2ban/filter.d/dovecot-pop3imap.conf":
		source  => "puppet:///modules/fail2ban/dovecot-pop3imap.conf",
		require => Package["fail2ban"],
	}
	
	file { "/etc/fail2ban/filter.d/postfix.conf":
		source  => "puppet:///modules/fail2ban/postfix.conf",
		require => Package["fail2ban"],
	}

}
