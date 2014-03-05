class redis::sources {
  apt::ppa{ 'ppa:rwky/redis': }
}

class redis::install {
  package { [
      "redis-server"
    ]:
    ensure => present,
    require => Class["redis::sources"]
  }  
}

class redis {
    include redis::sources,redis::install
}
