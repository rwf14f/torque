path = '/etc/torque/server_name'
Facter.add("torque_server") do
  confine :osfamily => 'RedHat'
  confine :batchsystem => 'torque'
  setcode do
    if File.readable?(path) then
      server = File.new(path).gets
      server.chomp unless server.nil?
    end
  end
end
