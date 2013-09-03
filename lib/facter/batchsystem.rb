# batchsystem.rb
batch_torque = Facter::Util::Resolution::exec('/bin/rpm -q --qf "%{NAME} %{VERSION}\n" torque | grep "^torque "')
unless batch_torque.nil? then
  batchinfo = batch_torque.split(/ /)
  Facter.add(:batchsystem) do
    confine :osfamily => 'RedHat'
    setcode do
      batchinfo[0]
    end
  end
  Facter.add(:batchversion) do
    confine :osfamily => 'RedHat'
    setcode do
      batchinfo[1]
    end
  end
end
