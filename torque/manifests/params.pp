class torque::params {
  $munge_key           = hiera ('torque::munge_key',undef)
  $maui_cfg            = hiera ('torque::maui_cfg',undef)
  $torque_server_name  = hiera ('torque::torque_server_name',undef) 
  $site_files          = site_files
  
}