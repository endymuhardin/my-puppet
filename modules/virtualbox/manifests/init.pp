class virtualbox::sources {
  apt::source { 'virtualbox':
    location    => 'http://download.virtualbox.org/virtualbox/debian',
    repos       => 'contrib',
    release     => 'utopic',
    include  => {
      'src' => false,
      'deb' => true
    },
    key         => {
        'id' => '7B0FAB3A13B907435925D9C954422A4B98AB5139',
        'source' => 'https://www.virtualbox.org/download/oracle_vbox.asc'
    }
  }
}

class virtualbox::install {
  package { ["dkms","VirtualBox-4.3"]: 
    ensure => present, 
    require => Class["virtualbox::sources"]
  }
}

class virtualbox {
  include virtualbox::sources,virtualbox::install
}
