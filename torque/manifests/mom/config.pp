class torque::mom::config(
  )inherits torque::params {
    $package_list = ['torque-mom','torque-client']

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
    
  }