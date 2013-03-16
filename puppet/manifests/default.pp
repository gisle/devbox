# Install the basic tools I require to edit files
package { ["vim", "git", "ack-grep"]:
  ensure => present,
  require => Exec['apt-get update'],
}

# Install the programming languages I care about
package { ["perl", "python", "ruby", "php5", "nodejs", "golang"]:
  ensure => present,
  require => Exec['apt-get update'],
}

# Perl libraries
package { ["libwww-perl","libdata-dump-perl"]:
  ensure => present,
  require => Exec['apt-get update'],
}

# Install some databases
package { ["sqlite3"]:
  ensure => present,
  require => Exec['apt-get update'],
}

# and a web server
package { ["apache2"]:
  ensure => present,
  require => Exec['apt-get update'],
}

service { "apache2":
  ensure => running,
  require => Package["apache2"],
}

# Keep the apt database current; but to run too often.  It's a bit costly.
exec { 'apt-get update':
  command => '/usr/bin/apt-get update',
  onlyif => "/bin/bash -c 'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1 )) )) <= 604800 ))'",
}
