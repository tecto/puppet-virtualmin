class apps-default {

	$packages = [
		acl,
		bash,
		bash-completion,
		build-essential,
		catdoc,
		cryptsetup,
		curl,
		devscripts,
		dnsutils,
		ethtool,
		exiftags,
		fakeroot,
		git,
		gs-esp,
		htop,
		imagemagick, 
		jnettop,
		libpam-cracklib,
		libpam-modules,
		logwatch,
		lynx,
		man-db,
		mii-diag, 
		module-assistant,
		mtr,
		ncftp,
		nmap, 
		ntp, 
		openssh-server,
		openssl,
		rsnapshot,
		rsync,
		screen,
		sudo,
		syslog-ng,
		tree,
		unzip,
		vim,
		wget,
		zip,
		zsh,
	]

	package { 
		$packages: ensure => present,
		}

	file { "/usr/bin/screen":
		owner   => root,
		group   => utmp,
		mode    => 6755,
		require => Package["screen"],
	}
	
	# bash_tweaks.sh
 	file { "/etc/profile.d/bash_tweaks.sh":
		ensure => "present",
	    source => "puppet:///modules/apps-default/bash_tweaks.sh",
	    owner  => "root",
		group  => "root",
		mode   => 664,
	}

}
