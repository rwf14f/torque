# torque_queue_config
queues = Facter.value('torque_queues').split(',')
queues.each do |queue|
  Facter.add("torque_queue_config_" + queue) do
    confine :osfamily => 'RedHat'
    setcode do
      Facter::Util::Resolution::exec("qmgr -c 'print queue " + queue + "' | sed -n 's/^set queue " + queue + " //p; /^create queue " + queue + "/p'").tr("\n", ",")
    end
  end
end
