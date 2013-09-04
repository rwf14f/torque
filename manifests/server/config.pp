class torque::server::config (
  $torque_server       =  $torque::params::torque_server_name,
  $nodes               =  $torque::params::torque_server_nodes,
) inherits torque::params
{
  file { '/etc/torque/server_name':
    ensure  => 'present',
    content => template("${module_name}/server_name.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['torque-server'],
  }
  file { '/etc/torque/nodes':
    ensure  => 'present',
    content => template("${module_name}/nodes.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => Package['torque-server'],
  }
  file { '/var/lib/torque/server_priv/nodes':
    ensure  => 'link',
    target  => '/etc/torque/nodes',
    require => File['/etc/torque/nodes'],
  }
}
