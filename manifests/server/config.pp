class torque::server::config(
  $torque_server       = $torque::params::torque_server_name,
  $qmgr_server         = $torque::params::torque_qmgr_server,
  $qmgr_queue_defaults = $torque::params::torque_qmgr_qdefaults,
  $qmgr_queues         = $torque::params::torque_qmgr_queues,
) inherits torque::params {
  file { '/etc/torque/server_name':
    ensure  => 'present',
    content => template("${module_name}/server_name.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['torque-server'],
  }

  $sconfig = torque_config_diff('server', $qmgr_server)
  $qconfig = torque_config_diff('queue', $qmgr_queues, $qmgr_queue_defaults)

  file { '/var/lib/torque/qmgr_config':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('torque/qmgr_config.erb'),
  }

  exec { 'qmgr update':
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    command     => 'cat /var/lib/torque/qmgr_config | qmgr',
    onlyif      => 'grep -vq "^[[:space:]]*\(#\|$\)" /var/lib/torque/qmgr_config',
#    refreshonly => true,
    subscribe   => File['/var/lib/torque/qmgr_config'],
    logoutput   => true,
  }
}
