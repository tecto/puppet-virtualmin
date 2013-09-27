class virtualmin {

	$packages = [
		maildrop,
	]

	package { 
		$packages: ensure => present,
	}
	
	# cycle_apache
	file { "/usr/local/bin/cycle_apache":
		source => "puppet:///modules/virtualmin/cycle_apache",
		owner  => "root",
		group  => "root",
		mode   => 700,
	}
	
	# shells
	file { "/etc/shells":
		source => "puppet:///modules/virtualmin/shells",
		owner  => "root",
		group  => "root",
		mode   => 644,
	}
	
	# sudoers
	file { "/etc/sudoers":
		source => "puppet:///modules/virtualmin/sudoers",
		owner  => "root",
		group  => "root",
		mode   => 440,
	}

	# create the skel_maildir folder
	file { "/etc/skel_maildir":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 700,
	}
	
	exec { "skel_maildirmake":
		command => "maildirmake /etc/skel_maildir/.maildir",
		require => [ File["/etc/skel_maildir"], Package["maildrop"]  ],
		creates => "/etc/skel_maildir/.maildir",
	}
	
	exec { "skel_maildirmake_drafts":
		command => "maildirmake -f Drafts /etc/skel_maildir/.maildir",
		require => [ exec["skel_maildirmake"] ],
		creates => "/etc/skel_maildir/.maildir/.Drafts",
	}
	
	exec { "skel_maildirmake_junk":
		command => "maildirmake -f Junk /etc/skel_maildir/.maildir",
		require => [ exec["skel_maildirmake"] ],
		creates => "/etc/skel_maildir/.maildir/.Junk",
	}
	
	exec { "skel_maildirmake_sent":
		command => "maildirmake -f Sent /etc/skel_maildir/.maildir",
		require => [ exec["skel_maildirmake"] ],
		creates => "/etc/skel_maildir/.maildir/.Sent",
	}
	
	exec { "skel_maildirmake_trash":
		command => "maildirmake -f Trash /etc/skel_maildir/.maildir",
		require => [ exec["skel_maildirmake"] ],
		creates => "/etc/skel_maildir/.maildir/.Trash",
	}
	
	exec { "skel_maildirmake_subscriptions":
		command => "echo 'Drafts
Junk
Sent
Trash' > /etc/skel_maildir/.maildir/subscriptions",
		require => [ exec["skel_maildirmake"] ],
		creates => "/etc/skel_maildir/.maildir/subscriptions",
	}
	
	# create the skel_virtualmin folder
	file { "/etc/skel_virtualmin":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 770,
	}
	
	exec { "skel_maildirmake_virtualmin":
		command => "maildirmake /etc/skel_virtualmin/.maildir",
		require => [ File["/etc/skel_virtualmin"], Package["maildrop"]  ],
		creates => "/etc/skel_virtualmin/.maildir",
	}
	
	exec { "skel_maildirmake_virtualmin_drafts":
		command => "maildirmake -f Drafts /etc/skel_virtualmin/.maildir",
		require => [ exec["skel_maildirmake_virtualmin"] ],
		creates => "/etc/skel_virtualmin/.maildir/.Drafts",
	}
	
	exec { "skel_maildirmake_virtualmin_junk":
		command => "maildirmake -f Junk /etc/skel_virtualmin/.maildir",
		require => [ exec["skel_maildirmake_virtualmin"] ],
		creates => "/etc/skel_virtualmin/.maildir/.Junk",
	}
	
	exec { "skel_maildirmake_virtualmin_sent":
		command => "maildirmake -f Sent /etc/skel_virtualmin/.maildir",
		require => [ exec["skel_maildirmake_virtualmin"] ],
		creates => "/etc/skel_virtualmin/.maildir/.Sent",
	}
	
	exec { "skel_maildirmake_virtualmin_trash":
		command => "maildirmake -f Trash /etc/skel_virtualmin/.maildir",
		require => [ exec["skel_maildirmake_virtualmin"] ],
		creates => "/etc/skel_virtualmin/.maildir/.Trash",
	}
	
	exec { "skel_maildirmake_virtualmin_subscriptions":
		command => "echo 'Drafts
Junk
Sent
Trash' > /etc/skel_virtualmin/.maildir/subscriptions",
		require => [ exec["skel_maildirmake_virtualmin"] ],
		creates => "/etc/skel_virtualmin/.maildir/subscriptions",
	}
	
	file { "/etc/skel_virtualmin/etc":
		ensure => "directory",
		require => File["/etc/skel_virtualmin"],
		owner  => "root",
		group  => "root",
		mode   => 770,
	}
	
	exec { "php.ini hardlink":
		command => "ln /etc/php5/cgi/php.ini /etc/skel_virtualmin/etc/php.ini",
		path    => "/usr/local/bin:/bin",
		require => File["/etc/skel_virtualmin/etc"],
		creates => "/etc/skel_virtualmin/etc/php.ini",
	}
	
	file { "/etc/skel_virtualmin/lib":
		ensure => "directory",
		require => File["/etc/skel_virtualmin"],
		owner  => "root",
		group  => "root",
		mode   => 770,
	}
	
	file { "/etc/skel_virtualmin/ssl":
		ensure => "directory",
		require => File["/etc/skel_virtualmin"],
		owner  => "root",
		group  => "root",
		mode   => 750,
	}
	
	# backup
	file { "/home/backup":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 770,
	}
	
	file { "/home/backup/domains":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 770,
	}
	
	file { "/home/backup/domains/full-weekly-sundays":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 770,
	}
	
	file { "/home/backup/domains/incrementals":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 770,
	}
	
	file { "/home/backup/config":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 770,
	}
}
