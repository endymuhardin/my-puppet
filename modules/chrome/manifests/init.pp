class chrome::sources {
  apt::source { 'chrome':
    location    => 'http://dl.google.com/linux/chrome/deb',
    release     => 'stable'
    repos       => 'main',
    include_src => false
  }
}

class chrome::install {
  package { ["google-chrome-stable"]: 
    ensure => present, 
    require => Class["chrome::sources"]
  }
}

class chrome {
  include chrome::sources,chrome::install
}
