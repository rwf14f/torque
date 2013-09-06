class torque::params {
  # ==== torque::munge ====
  # -- torque::munge::install --
  # ensure: specifies whether to install the munge packages
  #   default key: $munge_install_ensure
  #   hiera APL key: torque::munge::install::ensure
  $munge_install_ensure   = 'installed'

  # -- torque::munge::service --
  # ensure: specifies whether to run the munge service
  #   default key: $munge_service_ensure
  #   hiera APL key: torque::munge::service::ensure
  $munge_service_ensure   = 'running'
  # enable: specifies whether to start the munge service during boot
  #   default key: $munge_service_enabled
  #   hiera APL key: torque::munge::service::enable
  $munge_service_enabled  = true

  # -- torque::munge::config --
  # key_location: specifies where to find the munge key
  #     this has to be either a file:// or puppet:// url that can be used file the puppet file type
  #     this is a mandatory parameter, there is no default value
  #   default key: $munge_key_location
  #   hiera APL key: torque::munge::config::key_location
  $munge_key_location     = undef

  # ==== torque::mom ====
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
  $torque_server_nodes    = []
  # the following options are protected from being unset if they don't appear in torque_qmgr_server
  $torque_qmgr_present    = [
    'acl_hosts',
    'node_check_rate',
    'tcp_timeout',
    'next_job_number',
  ]
  # default torque server configuration that is set by qmgr ('set server ' is prepended by the module)
  $torque_qmgr_server     = [
    # internal defaults, usually not needed
#    "acl_hosts = ${::fqdn}",
#    'node_check_rate = 150',
#    'tcp_timeout = 6',
#    'next_job_number = 0',
    #
    'scheduling = True',
    'acl_host_enable = False',
    "managers = root@${::fqdn}",
    "operators = root@${::fqdn}",
    'default_queue = dteam',
    'log_events = 511',
    'mail_from = adm',
    'mail_domain = never',
    'query_other_jobs = True',
    'scheduler_iteration = 600',
    'default_node = lcgpro',
    'node_pack = False',
    'kill_delay = 10',
    "authorized_users = *@${::fqdn}",
  ]
  # default set up for a single queue
  $torque_qmgr_qdefaults  = [
    'queue_type = Execution',
    'resources_max.cput = 48:00:00',
    'resources_max.walltime = 72:00:00',
    'enabled = True',
    'started = True',
    'acl_group_enable = True',
  ]
  # default queue definitions
  # empty, because queues are not set up by default
  # this is a hash with the queue name as key and an array of configuration options as value
  # if no value is specified then the default options array ($torque_qmgr_qdefaults) is used
  $torque_qmgr_queues     = {}
  # server process limits
  $torque_limits_nofiles  = 4096
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
