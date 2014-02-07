class torque::server {
  class { 'torque::server::install': }
  class { 'torque::server::config': }
  class { 'torque::server::service': }
  class { 'torque::server::qmgrconfig': }
  class { 'munge': }
  class { 'torque::maui': }
  # make sure the services are started in the right order after initial configuration, otherwise things might not work
  Class['munge::service'] -> Class['torque::server::service'] -> Class['torque::maui::service']
  # qmgrconfig uses a fact which calls qmgr and which only works if the torque server is running
  Class['torque::server::service'] -> Class['torque::server::qmgrconfig']
}
