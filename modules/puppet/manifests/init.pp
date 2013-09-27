class puppet {

	package { ["puppet", "facter", "libaugeas0", "libaugeas-ruby", "libaugeas-ruby1.8", "augeas-lenses", "augeas-tools"]:
		ensure => latest,
	}

	service { "puppet":
		ensure  => running,
		require => Package["puppet"],
	}

	$changes_puppetconf = [
		"set pluginsync true",
	]

	augeas { "puppet.conf":
		context => "/files/etc/puppet/puppet.conf/main",
		changes => $changes_puppetconf,
		notify  => Service["puppet"],
	}

	augeas { "puppet-defaults":
		context => "/files/etc/default/puppet",
		changes => "set START yes",
	}

	file { "nsswitch.aug":
		path    => "/usr/share/augeas/lenses/dist/nsswitch.aug",
		source  => "puppet:///modules/puppet/nsswitch.aug",
		ensure  => present,
		require => Package["libaugeas0"],
	}

	file {  "test_nsswitch.aug":
		path    => "/usr/share/augeas/lenses/dist/tests/test_nsswitch.aug",
		source  => "puppet:///modules/puppet/tests/test_nsswitch.aug",
		ensure  => present,
		require => Package["libaugeas0"],
	}

}
