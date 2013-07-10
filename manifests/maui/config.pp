class torque::maui::config(
  ) inherits torque::params {
  $package_list = [ 'maui-server',]
   package { $package_list:
    ensure => installed,
  }
  file { '/var/spool/maui/maui.cfg':
      ensure  => present,
      source  => "puppet:///${site_files}/${maui_cfg}",
      require => Package['maui-server'],
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
  }
 
  service { 'maui':
    name       => 'maui',
    ensure     => stopped,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['maui-server'],
    subscribe  => File['/var/spool/maui/maui.cfg'],
  }
  
}