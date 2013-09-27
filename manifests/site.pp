import "functions/*"
import "classes/*"
import "nodes/*"

filebucket { main: server => "puppet.YOURDOMAIN.COM" }

File { backup => false, owner => root, group => root, mode => 644 }
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }

Package {
	ensure   => present,
	provider => $operatingsystem ? {
		Debian => aptitude,
		Ubuntu => aptitude,
		redhat => up2date,
	},
}

#Service {
#	ensure => running,
#}