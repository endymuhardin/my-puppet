class virtualbox::sources {
  apt::source { 'virtualbox':
    location    => 'http://download.virtualbox.org/virtualbox/debian',
    repos       => 'contrib',
    include_src => false,
    key         => '98AB5139'
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
