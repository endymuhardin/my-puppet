include apt

class ubuntubase::sources {
  class { 'apt':
    purge => {
      'sources.list' => true,
      'sources.list.d' => true,
      'preferences.d' => true
    },
    update => {
      timeout => 600
    }
  }

  apt::source{ 'ubuntu-kambing' :
    location    => 'http://kambing.ui.ac.id/ubuntu',
    release     => "${::lsbdistcodename}",
    repos       => 'main restricted universe multiverse',
    include  => {
      'src' => false,
      'deb' => true
    }
  }
  
  apt::source{ 'ubuntu-kambing-updates' :
    location    => 'http://kambing.ui.ac.id/ubuntu',
    release     => "${::lsbdistcodename}-updates",
    repos       => 'main restricted universe multiverse',
    include  => {
      'src' => false,
      'deb' => true
    }
  }
  
  apt::source{ 'ubuntu-kambing-security' :
    location    => 'http://kambing.ui.ac.id/ubuntu',
    release     => "${::lsbdistcodename}-security",
    repos       => 'main restricted universe multiverse',
    include  => {
      'src' => false,
      'deb' => true
    }
  }
  
  apt::source{ 'canonical-partner' :
    location    => 'http://archive.canonical.com/ubuntu',
    repos       => 'partner',
    include  => {
      'src' => false,
      'deb' => true
    }
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
    require => Class["ubuntubase::update"],
    timeout => 0
  }
}

class ubuntubase::install {
  package { ["mc","openssh-server","ntp","curl"]: 
    ensure => present, 
    require => Class["ubuntubase::upgrade"]
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
