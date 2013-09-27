class apt {

	exec { "apt-get update":
		refreshonly => true,
	}

	file { "puppet-backports source":
		path   => "/etc/apt/sources.list.d/puppet-backports.list",
		source => "puppet:///modules/apt/puppet-backports.list",
		ensure => present,
		notify => Exec["add puppet-backports key"],
	}

	exec { "add puppet-backports key":
		command => "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 094D0420",
		notify  => Exec["update puppet"],
		refreshonly => true,
	}	

	exec { "update puppet":
		command => "apt-get update && apt-get install -y puppet",
		notify  => Augeas["puppet.conf"],
		refreshonly => true,
	}

	file { "augeas-backports source":
		path   => "/etc/apt/sources.list.d/augeas-backports.list",
		source => "puppet:///modules/apt/augeas-backports.list",
		ensure => present,
		notify => Exec["add augeas-backports key"],
	}

	exec { "add augeas-backports key":
		command => "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C18789EA",
		notify  => Exec["update augeas"],
		refreshonly => true,
	}

	exec { "update augeas":
		command => "apt-get update && apt-get install -y libaugeas0 libaugeas-ruby libaugeas-ruby1.8 facter augeas-lenses augeas-tools",
		refreshonly => true,
	}

}











