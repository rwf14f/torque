class torque::params {
  $munge_key           = hiera ('torque::munge_key',undef)
  $maui_cfg            = hiera ('torque::maui_cfg',undef)
  $torque_server       = hiera ('torque::torque_server',undef) 
  $site_files          = site_files
  
}