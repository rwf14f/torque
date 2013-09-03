# torque_queues
host = Facter.value('fqdn')
Facter.add(:torque_queues) do
  confine :osfamily => 'RedHat'
  confine :batchsystem => 'torque'
  confine :torque_server => host
  setcode do
    tq = Facter::Util::Resolution::exec("qstat -Q | awk 'NR>2 {print $1}'")
    tq.nil? ? nil : tq.tr("\n", ',')
  end
end
