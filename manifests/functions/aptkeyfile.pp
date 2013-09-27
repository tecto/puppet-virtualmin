define apt::keyfile($keyfile, $keyid, $ensure, $server) {
  case $ensure {
    present: {
      exec { 'Import $keyfile to apt keystore':
        path        => '/bin:/usr/bin',
        environment => 'HOME=/root',
        command     => "wget http://$server/$keyfile -O - | apt-key add -",
        user        => 'root',
        group       => 'root',
        unless      => "apt-key list | grep $keyid",
        logoutput   => on_failure,
      }
    }

    absent: {
      exec { "Remove ${keyid} from apt keystore":
        path        => '/bin:/usr/bin',
        environment => 'HOME=/root',
        command     => "apt-key del $keyid",
        user        => 'root',
        group       => 'root',
        onlyif      => "apt-key list | grep $keyid",
      }
    }

    default: {
      fail "Invalid 'ensure' value '${ensure}' for apt::keyfile"
    }
  }
}
