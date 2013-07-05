class torque::params {
  $munge_key           = hiera ('munge_key',undef)
  $maui_cfg            = hiera ('maui_cfg',undef)
  $torque_server_name  = hiera ('torque_server_name',undef) 
  $site_files          = site_files
  
}