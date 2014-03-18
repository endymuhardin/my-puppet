class programmingbase {
  $sublime_download_link = "http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3059_x64.tar.bz2"
  $sublime_download = "/opt/downloads/sublime_text_3.tar.bz2"
  $sublime = "sublime_text_3"

  package { [
      "gitg"
    ]:
    ensure => present,
    require => Class["ubuntubase"]
  }
  
  file { "/opt/downloads":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 750,
  }
  
  exec {
    "Download Sublime Text":
      command   => "/usr/bin/wget  -O ${sublime_download} ${sublime_download_link}",
      logoutput => on_failure,
      creates   => "${sublime_download}",
      timeout => 0;

    "Unzip Sublime Text":
      cwd     => "/opt",
      command => "/bin/tar xjf ${sublime_download} ",
      creates => "/opt/${sublime}",
      require => [Exec["Download Sublime Text"] ];
  }
  
  file { "/etc/profile.d/sublime.sh":
    ensure => present,
    content => template("programmingbase/sublime.sh.erb")
  }
}
