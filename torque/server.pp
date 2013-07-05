class torque::server(
  ) inherits torque::params {
    
    include torque::server::config
    include torque::munge::config
    include torque::maui::config
  }