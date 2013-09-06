class torque::server::limits(
  $nofiles = $torque::params::torque_limits_nofiles,
) {
  file { '/etc/sysconfig/pbs_server':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Class['torque::server::install']
  }
  file_line { 'torque nofiles limit':
    ensure  => 'present',
    path    => '/etc/sysconfig/pbs_server',
    line    => "ulimit -n ${nofiles}",
    match   => '^ulimit -n ',
    require => File['/etc/sysconfig/pbs_server'],
    notify  => Service['pbs_server'],
  }
}
