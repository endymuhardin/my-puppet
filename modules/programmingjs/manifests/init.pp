class programmingjs::sources {
  apt::ppa{ 'ppa:chris-lea/node.js': }
}

class programmingjs::installnode {
  package { [
      "nodejs"
    ]:
    ensure => present,
    require => Class["programmingjs::sources"]
  }  
}

class programmingjs::installyeoman {
  exec { "Install Yeoman" :
    command => "/usr/bin/npm install -g generator-angular",
    require => Class["programmingjs::installnode"],
    timeout => 0
  }  
}

class programmingjs {
    include programmingjs::sources,programmingjs::installnode,programmingjs::installyeoman
}
