class smbsrv_ssl {

	# ca.pem  smbsrv_net.crt  smbsrv_net.key  smbsrv_net.nopw.key  smbsrv_net.pem  sub.class1.server.ca.pem  sub.class2.server.ca.pem

	file { "/etc/ssl/smbsrv":
		ensure => "directory",
 		mode   => 700,
	}

	file { "/etc/ssl/smbsrv/smbsrv_net.crt":
		source  => "puppet:///modules/smbsrv_ssl/smbsrv_net.crt",
		#notify	=> Service["webmin"],
	}

	file { "/etc/ssl/smbsrv/smbsrv_net.key":
                source  => "puppet:///modules/smbsrv_ssl/smbsrv_net.key",
                #notify  => Service["webmin"],
        }

        file { "/etc/ssl/smbsrv/smbsrv_net.nopw.key":
                source  => "puppet:///modules/smbsrv_ssl/smbsrv_net.nopw.key",
                #notify  => Service["webmin"],
        }

        file { "/etc/ssl/smbsrv/smbsrv_net.pem":
                source  => "puppet:///modules/smbsrv_ssl/smbsrv_net.pem",
                #notify  => Service["webmin"],
        }

        file { "/etc/ssl/smbsrv/sub.class2.server.ca.pem":
                source  => "puppet:///modules/smbsrv_ssl/sub.class2.server.ca.pem",
                #notify  => Service["webmin"],
        }

}
