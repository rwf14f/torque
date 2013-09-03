# torque_server_config
host = Facter.value('fqdn')
Facter.add(:torque_server_config) do
  confine :osfamily => 'RedHat'
  confine :batchsystem => 'torque'
  confine :torque_server => host
  setcode do
    tsc = Facter::Util::Resolution::exec("qmgr -c 'print server' | sed -n 's/^set server //p'")
    tsc.nil? ? nil : tsc.tr("\n", ',')
  end
end
