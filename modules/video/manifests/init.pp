class video::sources {
  apt::ppa{ 'ppa:maarten-baert/simplescreenrecorder': }
  apt::ppa{ 'ppa:openshot.developers/ppa': }
}

class video::install {
  package { [
      "simplescreenrecorder",
      "openshot"
    ]:
    ensure => present,
    require => Class["video::sources"]
  }
}

class video {
    include video::sources,video::install
}
