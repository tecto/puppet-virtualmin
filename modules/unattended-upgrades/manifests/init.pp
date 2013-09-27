class unattended-upgrades {

	# https://help.ubuntu.com/10.04/serverguide/automatic-updates.html
	# http://redes-privadas-virtuales.blogspot.com/2011/04/automatic-updates-on-ubuntu-with.html
	# https://help.ubuntu.com/community/AutomaticSecurityUpdates
	# http://syslog.tv/2012/01/28/automaticunattended-updates-on-debian-6-squeeze/
	
	$packages = [
		unattended-upgrades,
		apticron,
	]

	package { 
		$packages: ensure => present,
	 }
	
	file { "/etc/apt/apt.conf.d/50unattended-upgrades":
		ensure => "present",
		source  => "puppet:///modules/unattended-upgrades/50unattended-upgrades",
		mode => 600,
	}
	
	file { "/etc/apt/apt.conf.d/20auto-upgrades":
		ensure => "present",
		source  => "puppet:///modules/unattended-upgrades/20auto-upgrades",
		mode => 600,
	}

}
