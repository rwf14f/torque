class torque::server::config {
  $package_list = [ 'torque-server', 'torque-client']

  package { $package_list:
    ensure => installed, }
   
  service { 'pbs_server':
    name       => 'pbs_server',
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['torque-server'],
    subscribe  => File['/etc/torque/server_name'],
  }
  file { '/etc/torque/server_name':
      ensure  => present,
      content  => template("${module_name}/server_name.erb"),
      require => Package['torque-server'],
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
  }
  
  
}