# torque_queue_config
queues = Facter.value('torque_queues')
host = Facter.value('fqdn')
unless queues.nil?
  queues.split(',').each do |queue|
    Facter.add("torque_queue_config_#{queue}") do
      confine :osfamily => 'RedHat'
      confine :batchsystem => 'torque'
      confine :torque_server => host
      setcode do
        tqc = Facter::Util::Resolution::exec("qmgr -c 'print queue #{queue}' | sed -n 's/^set queue #{queue} //p; /^create queue #{queue}/p'")
        tqc = tqc.nil? ? nil : tqc.tr("\n", ',')
      end
    end
  end
end
