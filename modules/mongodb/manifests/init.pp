class mongodb::sources {
  apt::source { 'mongodb':
    location    => 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart',
    release     => 'dist'
    repos       => '10gen',
    include_src => false,
    key         => '7F0CEB10'
  }
}

class mongodb::install {
  package { ["mongodb-10gen"]: 
    ensure => present, 
    require => Class["mongodb::sources"]
  }
}

class mongodb {
  include mongodb::sources,mongodb::install
}
