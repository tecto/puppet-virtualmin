class ssh {

	service { "ssh":
		ensure    => running,
		enable    => true,
		hasstatus => false,
		status    => "[ -f /var/run/sshd.pid ]",
		require   => Package["openssh-server"],
	}

	# create the folder
	file { "/root/.ssh":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 700,
	}
	
	file { "/root/.ssh/authorized_keys":
		source  => "puppet:///modules/ssh/authorized_keys",
		require => [ File["/root/.ssh"],Package["openssh-server"] ],
		mode => 600,
	}

}
