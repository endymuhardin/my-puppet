class programmingjava::param {
    $maven = "apache-maven-3.2.1"
    $installroot = "/opt"
    $maven_download = "http://apache.mirrors.hoobly.com/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.zip"
    $installer = "/opt/downloads/$maven-bin.zip"
}

class programmingjava::installjdk {
  package { [
      "openjdk-7-jdk", "wget", "unzip"
    ]: 
    ensure => present, 
    require => Class["programmingjava::param"]
  }  
}

class programmingjava::installmaven {
  file { "/opt/downloads":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 750,
  }
  
  exec {
    "Download Maven":
      command   => "/usr/bin/wget  -O ${programmingjava::param::installer} ${programmingjava::param::maven_download}",
      logoutput => on_failure,
      creates   => "${programmingjava::param::installer}",
      require   => [ Class["programmingjava::installjdk"] ];

    "Unzip Maven":
      cwd     => "/opt",
      command => "/usr/bin/unzip ${programmingjava::param::installer}",
      creates => "/opt/${programmingjava::param::maven}",
      require => [ Exec["Download Maven"], Class["programmingjava::installjdk"] ];
  }
}

class programmingjava::environment {
  file { "/etc/profile.d/java_env.sh":
    ensure => present,
    content => template("programmingjava/java_env.sh.erb"), 
    require => Class["programmingjava::installmaven"]
  }
}

class programmingjava {
    include programmingjava::param,programmingjava::installjdk,programmingjava::installmaven,programmingjava::environment
}
