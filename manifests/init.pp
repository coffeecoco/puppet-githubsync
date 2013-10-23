class githubsync {

  file { '/usr/local/bin/githubsync.sh':
    ensure => present,
    mode   => '0755',
    source => 'puppet:///modules/githubsync/githubsync.sh',
  }

  file { '/usr/local/bin/githubsync_gist_json.rb':
    ensure => present,
    mode   => '0755',
    source => 'puppet:///modules/githubsync/githubsync_gist_json.rb',
  }

  file { ['/var/local/run/', '/var/local/run/githubsync/']:
    ensure => directory,
    owner  => 'githubsync',
  }

  $file_name = $::operatingsystem ? {
    Debian => '/usr/local/lib/site_ruby/1.8/githubsync.rb',
    RedHat => '/usr/lib/ruby/site_ruby/1.8/githubsync.rb',
  }

  file { 'githubsync.rb':
    ensure => absent,
    name   => $file_name,
  }

  file { '/usr/local/bin/githubsync-update-status.sh':
    ensure => absent,
  }

  cron { 'update githubsync dashboard':
    ensure => absent,
    user   => 'githubsync',
  }

  cron { 'update githubsync nagios plugin':
    ensure => absent,
    user   => 'githubsync',
  }

}
