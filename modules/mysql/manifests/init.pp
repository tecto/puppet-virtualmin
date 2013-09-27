class mysql {

	$packages = [
		mysql-server,
	]

	package { 
		$packages: ensure => present,
	}
	
	service { "mysql":
		ensure => running,
		require => Package["mysql-server"],
	}
	
	# my.cnf
	file { "/etc/mysql/my.cnf":
		source => "puppet:///modules/mysql/my.cnf",
		owner  => "root",
		group  => "root",
		mode   => 644,
		require => Package["mysql-server"],
		notify  => Service["mysql"],
	}

}
