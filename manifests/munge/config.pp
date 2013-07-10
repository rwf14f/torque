class torque::munge::config(
  ) inherits torque::params
 {
  $package_list = ['munge']
  
  package { $package_list:
    ensure => installed,
  }
  
   service { 'munge':
    name       => 'munge',
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['munge'],
    subscribe  => File['/etc/munge/munge.key'],
  }

  file { '/etc/munge/munge.key':
      ensure  => present,
      source  => "puppet:///${site_files}/${munge_key}",
      require => Package['munge'],
      owner   => 'munge',
      group   => 'munge',
      mode    => '0400',
  }
}
