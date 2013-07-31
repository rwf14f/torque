class torque::params {
  # munge options
  $munge_install_ensure   = 'installed'
  $munge_service_ensure   = 'running'
  $munge_service_enabled  = true
  $munge_key_location     = undef #hiera ('torque::munge_key',undef)

  # mom options
  $mom_install_ensure     = 'installed'
  $client_install_ensure  = 'installed'
  $mom_service_ensure     = 'running'
  $mom_service_enable     = true
  $torque_server          = undef #hiera ('torque::torque_server',undef)
  $mom_restricted         = []
  $mom_ideal_load_adj     = 0.2
  $mom_max_load_adj       = 1.2
  $mom_options            = {
    logevent => 255,
  }

  # server options
  $server_install_ensure  = 'installed'
  $server_service_ensure  = 'running'
  $server_service_enable  = true
  $torque_server_name     = $::fqdn

  # maui options
  $maui_install_ensure    = 'installed'
  $maui_service_ensure    = 'running'
  $maui_service_enable    = true
  $maui_server            = $::fqdn
  $maui_port              = 40559
  $maui_mode              = 'NORMAL'
  $maui_rmcfgtype         = 'PBS'
  $maui_rmcfgopt          = 'TIMEOUT=90'
  $maui_adminhost         = $::fqdn
  $maui_admin1            = 'root'
  $maui_admin3            = undef
  $maui_generalopt        = {
    'NODESYNCTIME'     => '00:00:30',
    # Set PBS server polling interval. If you have short # queues
    # or/and jobs it is worth to set a short interval. (default 10 seconds)
    'RMPOLLINTERVAL'   => '00:00:30',
    # a max. 10 MByte log file in a logical location
    'LOGFILE'          => '/var/log/maui.log',
    'LOGFILEMAXSIZE'   => 10000000,
    'LOGLEVEL'         => 1,
    'LOGFILEROLEDEPTH' => 10,
    # Set the delay to 5 min before Maui tries to run a job again, in
    # case it failed to run the first time. The default value is 1 hour.
    'DEFERTIME'        => '00:05:00',
  }
  $maui_options           = {}
  $maui_groupcfg          = {}
  $maui_usercfg           = {}
  $maui_srcfg             = {}
}
