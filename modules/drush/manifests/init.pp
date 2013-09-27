class drush {

	# http://community.aegirproject.org/installing/debian
	
	file { "/etc/apt/preferences.d/drush":
		ensure => "present",
		source  => [
			"puppet:///modules/drush/drush-$operatingsystem$lsbmajdistrelease",
			"puppet:///modules/drush/drush-$operatingsystem$lsbdistrelease",
		],
	}
	
	file { "/etc/apt/sources.list.d/backports.list":
		require => File["/etc/apt/preferences.d/drush"],
		ensure => "present",
		source  => [
			"puppet:///modules/drush/backports-$operatingsystem$lsbmajdistrelease",
			"puppet:///modules/drush/backports-$operatingsystem$lsbdistrelease",
		],
		notify => Exec["apt-get update for backports"],
	}
	
	exec { "apt-get update for backports":
    	command => "apt-get update",
		onlyif => [
			"test -e /etc/apt/sources.list.d/backports"
			],
		notify => Exec["update drush"],
	}
	
	exec { "update drush":
		command => "apt-get install -y drush",
		refreshonly => true,
	}

}
