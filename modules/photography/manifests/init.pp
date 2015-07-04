class photography::sources {
  apt::ppa{ 'ppa:pmjdebruijn/darktable-release': }
  apt::ppa{ 'ppa:hugin/hugin-builds': }
}

class photography::install {
  package { [
      "darktable",
      "hugin"
    ]:
    ensure => present,
    require => Class["photography::sources"]
  }  
}

class photography {
    include photography::sources,photography::install
}
