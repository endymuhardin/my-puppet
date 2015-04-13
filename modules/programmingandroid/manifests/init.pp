class programmingandroid::param {
    $androidsdk = "android-sdk-linux"
    $installroot = "/opt"
    $androidsdk_download = "https://dl.google.com/android/android-sdk_r22.6.2-linux.tgz"
    $installer = "/opt/downloads/android-sdk_r22.6.2-linux.tgz"
}

class programmingandroid::installjdk {
  package { [
      "openjdk-7-jdk", "wget", "unzip"
    ]: 
    ensure => present, 
    require => Class["programmingandroid::param"]
  }  
}

class programmingandroid::installsdk {
  file { "/opt/downloads":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 750,
  }
  
  exec {
    "Download Android SDK":
      command   => "/usr/bin/wget  -O ${programmingandroid::param::installer} ${programmingandroid::param::androidsdk_download}",
      logoutput => on_failure,
      creates   => "${programmingandroid::param::installer}",
      require   => [ Class["programmingandroid::installjdk"] ],
      timeout => 0;

    "Unzip Android SDK":
      cwd     => "/opt",
      command => "/bin/tar xvzf ${programmingandroid::param::installer}",
      creates => "/opt/${programmingandroid::param::androidsdk}",
      require => [ Exec["Download Android SDK"], Class["programmingandroid::installjdk"] ];
  }
}

class programmingandroid::environment {
  file { "/etc/profile.d/android_env.sh":
    ensure => present,
    content => template("programmingandroid/android_env.sh.erb"), 
    require => Class["programmingandroid::installsdk"]
  }
}

class programmingandroid {
    include programmingandroid::param,programmingandroid::installjdk,programmingandroid::installsdk,programmingandroid::environment
}
