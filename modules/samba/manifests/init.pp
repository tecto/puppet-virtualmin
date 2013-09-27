class samba {

	package { gdb :
		ensure => present,
	}

	package { samba :
		ensure => present,
	}

	service { smbd :
		ensure  => running,
		enable  => true,
		require => Package["samba"],
	}

}
