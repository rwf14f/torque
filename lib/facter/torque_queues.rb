# torque_queues
Facter.add(:torque_queues) do
  confine :osfamily => 'RedHat'
  setcode do
    Facter::Util::Resolution::exec("qstat -Q | awk 'NR>2 {print $1}'").tr("\n", ",")
  end
end
