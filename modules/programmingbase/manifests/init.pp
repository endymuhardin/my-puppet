class programmingbase {
  package { [
      "gitg"
    ]:
    ensure => present,
    require => Class["ubuntubase"]
  }
}
