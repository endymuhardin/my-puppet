class programmingbase::sources {
    apt::ppa{ 'ppa:git-core/ppa': }
}

class programmingbase::install {
  package { [
      "git-svn"
    ]:
    ensure => present,
    require => Class["programmingbase::sources"]
  }
}

class programmingbase {
    include programmingbase::sources,programmingbase::install
}
