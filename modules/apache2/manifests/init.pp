class apache2 {

	$packages = [
		apache2,
		php5-cgi,
		php5-gd,
		php5-xmlrpc,
		php5-imap,
		php5-curl,
		php5-dev,
		php5-mcrypt,
		libpcre3-dev,
	]

	package { 
		$packages: ensure => present,
	}

	service { "apache2":
		ensure => running,
		require => Package["apache2"],
	}

	file { "default" :
		path    => "/etc/apache2/sites-available/default",
		source  => "puppet:///modules/apache2/default",
		require => Package["apache2"],
		notify  => Service["apache2"],
	}

	file { "default-ssl":
		path    => "/etc/apache2/sites-available/default-ssl",
		source  => "puppet:///modules/apache2/default-ssl",
		require => Package["apache2"],
		notify  => Service["apache2"],
	}

	exec { "enable mod_rewrite":
		command => "a2enmod rewrite",
		creates => "/etc/apache2/mods-enabled/rewrite.load",
		require => Package["apache2"],
		notify  => Service["apache2"],
	}

	exec { "enable mod-ssl":
		command => "a2enmod ssl",
		creates => "/etc/apache2/mods-enabled/ssl.load",
		require => Package["apache2"],
		notify  => Service["apache2"],
	}

	exec { "enable default-ssl":
		command => "a2ensite default-ssl",
		creates => "/etc/apache2/sites-enabled/default-ssl",
		require => File["default-ssl"],
		notify  => Service["apache2"],
	}
	
	exec { "pear packages":
		command => "pear update-channels; pear upgrade-all; pear install Auth_SASL HTML_Common HTML_QuickForm HTML_QuickForm_Controller HTML_QuickForm_advmultiselect HTML_Template_IT Mail Mail_Mime Mail_mimedecode Net_SMTP Net_Socket Net_UserAgent_Detect XML_RPC; pecl install uploadprogress; pear config-set preferred_state beta; pear install OLE Spreadsheet_Excel_Writer; pear config-set preferred_state stable",
		require => Package["php5-dev"],
		creates => "/usr/share/php/XML/RPC.php",
	}
	
	file { "apc answers":
		path    => "/etc/apache2/apc_answers.txt",
		source  => "puppet:///modules/apache2/apc_answers.txt",
		require => Package["apache2"],
	}
	
	exec { "apc install":
		command => "pecl install apc < /etc/apache2/apc_answers.txt",
		require => [ Package["php5-dev"], Package["libpcre3-dev"], File["apc answers"] ],
		creates => "/usr/include/php5/ext/apc/apc_serializer.h",
	}		
	
	file { "php.ini":
		path    => "/etc/php5/cgi/php.ini",
		source  => "puppet:///modules/apache2/php.ini",
		require => [ Package["php5-cgi"], Exec["pear packages"], Exec["apc install"] ],
	}

}