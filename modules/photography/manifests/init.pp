class photography::sources {
  apt::ppa{ 'ppa:pmjdebruijn/darktable-release': }
}

class photography::install {
  package { [
      "darktable"
    ]:
    ensure => present,
    require => Class["photography::sources"]
  }  
}

class photography {
    include photography::sources,photography::install
}
