class netatalk {

	file { "/etc/default/netatalk":
		source  => "puppet:///modules/netatalk/netatalk",
		notify  => Service["netatalk"],
	}

        file { "/etc/netatalk/afpd.conf":
                source  => "puppet:///modules/netatalk/afpd.conf",
                notify  => Service["netatalk"],
        }

        file { "/etc/netatalk/AppleVolumes.default":
                source  => "puppet:///modules/netatalk/AppleVolumes.default",
                notify  => Service["netatalk"],
        }

	file { "/etc/avahi/services/afpd.service":
                source  => "puppet:///modules/netatalk/afpd.service",
                notify  => Service["avahi-daemon"],
		mode => 644,
        }

        package { avahi-daemon :
                ensure => present,
        }

        service { avahi-daemon :
                ensure  => running,
                enable  => true,
                require => Package["avahi-daemon"],
        }

	package { netatalk :
		ensure => present,
	}

	service { netatalk :
		ensure  => running,
		enable  => true,
		require => Package["netatalk"],
	}

}
