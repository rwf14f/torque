class torque::mom::config(
  )inherits torque::params {
    $package_list = ['torque-mom','torque-client']
    $torque_server = $torque_server
   package { $package_list:
    ensure => installed,
  }
  file { '/etc/torque/mom/config':
      ensure  => present,
      content  => template("${module_name}/pbs_config.erb"),
      require => Package['torque-mom'],
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
  }
  
  file { '/etc/torque/server_name':
      ensure  => present,
      content  => template("${module_name}/mom_server_name.erb"),
      require => Package['torque-mom'],
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
  }
  
    
  }