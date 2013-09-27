node default {
    
	include apps-default
	include apt
	include puppet
	include ssh
	include unattended-upgrades
		
}

node virtualmin_server inherits default {

	stage { [pre, post]: }
	
	Stage[pre] -> Stage[main] -> Stage[post]
    
	class { 'virtualmin-deb' : stage => 'pre' }
	
	include apache2
	include dovecot
	include drush
	include fail2ban
	include mysql
	include postfix
	include ssh
	include virtualmin
	include virtualmin-deb
	
}