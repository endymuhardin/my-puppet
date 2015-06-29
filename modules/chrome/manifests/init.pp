class chrome::sources {
  apt::source { 'chrome':
    location    => 'http://dl.google.com/linux/chrome/deb',
    release     => 'stable',
    repos       => 'main',
    key => {
        'id' => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
        'source' => 'https://dl.google.com/linux/linux_signing_key.pub'
    },
    include  => {
      'src' => false,
      'deb' => true
    }
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
