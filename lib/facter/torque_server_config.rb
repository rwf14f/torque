# torque_server_config
Facter.add(:torque_server_config) do
  confine :osfamily => 'RedHat'
  setcode do
    Facter::Util::Resolution::exec("qmgr -c 'print server' | sed -n 's/^set server //p'").tr("\n", ",")
  end
end
