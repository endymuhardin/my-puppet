class mysql::params {
    $mysql_password = "admin"
}

class mysql::install {
    package { [ "mysql-server"]: 
        ensure => present
    }
}

class mysql::service {
    service {"mysql":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
        require => Class["mysql::install"]
    }
}


class mysql::config {
    exec { "set-mysql-password":
        unless => "mysqladmin -uroot -p$mysql::params::mysql_password status",
        path => ["/bin", "/usr/bin"],
        command => "mysqladmin -uroot password $mysql::params::mysql_password",
        require => Class["mysql::service"],
    }
}

define mysqldb( $user, $password ) {
    exec { "create-${name}-db":
        unless => "/usr/bin/mysql -uroot -p$mysql::params::mysql_password ${name}",
        command => "/usr/bin/mysql -uroot -p$mysql::params::mysql_password -e \"create database ${name};\"",
        require => Class["mysql::service"],
    }

    exec { "grant-${name}-db":
        unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
        command => "/usr/bin/mysql -uroot -p$mysql::params::mysql_password -e \"grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
        require => [Class["mysql::service"], Exec["create-${name}-db"]]
    }
}

class mysql {
    include mysql::params, mysql::install, mysql::service, mysql::config
}
