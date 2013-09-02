class torque::maui::install(
  $ensure = $torque::params::maui_install_ensure,
) {
  package { [ 'maui-server', 'maui-client' ]:
    ensure => $ensure,
  }
}
