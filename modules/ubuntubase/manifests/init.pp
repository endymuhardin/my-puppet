include apt

class ubuntubase::sources {
  class { 'apt':
    always_apt_update    => false,
    purge_sources_list   => true,
    purge_sources_list_d => true,
    purge_preferences_d  => true,
    update_timeout       => 600
  }

  apt::source{ 'ubuntu-kambing' :
    location    => 'http://kambing.ui.ac.id/ubuntu',
    release     => "${::lsbdistcodename}",
    repos       => 'main restricted universe multiverse',
    include_src => false
  }
  
  apt::source{ 'ubuntu-kambing-updates' :
    location    => 'http://kambing.ui.ac.id/ubuntu',
    release     => "${::lsbdistcodename}-updates",
    repos       => 'main restricted universe multiverse',
    include_src => false
  }
  
  apt::source{ 'ubuntu-kambing-security' :
    location    => 'http://kambing.ui.ac.id/ubuntu',
    release     => "${::lsbdistcodename}-security",
    repos       => 'main restricted universe multiverse',
    include_src => false
  }
  
  apt::source{ 'canonical-partner' :
    location    => 'http://archive.canonical.com/ubuntu',
    repos       => 'partner',
    include_src => false
  }
  
  apt::source{ 'ubuntu-extras' :
    location    => 'http://extras.ubuntu.com/ubuntu',
    repos       => 'main',
    include_src => false
  }
    
  apt::source { 'puppetlabs':
    location    => 'http://apt.puppetlabs.com',
    repos       => 'main',
    key         => '4BD6EC30',
    key_server  => 'pgp.mit.edu',
    include_src => false
  }
}

class ubuntubase::update {
  exec { "Update Repository Ubuntu":
    command => "/usr/bin/apt-get update",
    require => Class["ubuntubase::sources"]
  }
}

class ubuntubase::upgrade {
  exec { "Upgrade Existing Apps":
    command => "/usr/bin/apt-get upgrade -y", 
    require => Class["ubuntubase::update"]
  }
}

class ubuntubase::install {
  package { ["mc","openssh-server","ntp"]: 
    ensure => present, 
    require => Class["ubuntubase::update"]
  }
}

class ubuntubase::service {
  service { "ntp":
    ensure => running,
    enable => true, 
    hasstatus => true,
    hasrestart => true,
    require => Class["ubuntubase::install"]
  }
}

class ubuntubase {
    include ubuntubase::sources,ubuntubase::update,ubuntubase::upgrade,ubuntubase::install,ubuntubase::service
}
