include apt

class { 'apt':
  always_apt_update    => false,
  purge_sources_list   => true,
  purge_sources_list_d => true,
  purge_preferences_d  => true,
  update_timeout       => 600
}

class baseubuntu::sources {
  apt::source{ 'kambing-repo' :
    location    => 'http://kambing.ui.ac.id/ubuntu/',
    repos       => 'main restricted universe multiverse',
    include_src => 'false'
  }
  
  apt::source{ 'canonical-partner' :
    location    => 'http://archive.canonical.com/ubuntu',
    repos       => 'partner',
    include_src => 'false'
  }
  
  apt::source{ 'ubuntu-extras' :
    location    => 'http://extras.ubuntu.com/ubuntu',
    repos       => 'main',
    include_src => 'false'
  }
    
  apt::source { 'puppetlabs':
    location    => 'http://apt.puppetlabs.com',
    repos       => 'main',
    key         => '4BD6EC30',
    key_server  => 'pgp.mit.edu',
    include_src => 'false'
  }
}

class baseubuntu::update {
  exec { "Update Repository Ubuntu":
    command => "/usr/bin/apt-get update",
    require => Class["baseubuntu::sources"]
  }
}

class baseubuntu::install {
  package { ["mc","openssh-server","ntp"]: 
    ensure => present, 
    require => Class["baseubuntu::update"]
  }
}

class baseubuntu::service {
  service { "ntp":
    ensure => running,
    enable => true, 
    hasstatus => true,
    hasrestart => true,
    require => Class["baseubuntu::install"]
  }
}

class baseubuntu {
    include baseubuntu::sources,baseubuntu::update,baseubuntu::install,baseubuntu::service
}
