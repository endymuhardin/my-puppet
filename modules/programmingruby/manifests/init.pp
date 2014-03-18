class programmingruby::sources {
  apt::ppa{ 'ppa:brightbox/ruby-ng': }
}

class programmingruby::install {
  package { [
      "ruby1.9.3"
    ]:
    ensure => present,
    require => Class["programmingruby::sources"]
  }  
}

class programmingruby {
    include programmingruby::sources,programmingruby::install
}
