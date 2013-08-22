module Puppet::Parser::Functions
  newfunction(:torque_config_diff, :type => :rvalue) do |args|
    req_presence = lookupvar('torque_qmgr_present')
    case args[0]
    when 'server'
      config = args[1]
      raise(Puppet::ParseError, "torque_config_diff(server), second argument has to be an array") unless config.is_a?(Array)
      clientconfig = lookupvar('torque_server_config').split(',')
      # get values that need to be set (present in config but not on server)
      sconfig = (config - clientconfig).map { |cfg| "set server #{cfg}" }
      # get values that need to be unset (present on server but not in config)
      usconfig = (clientconfig - config).delete_if { |cfg|
        # remove protected options from unset list first
        req_presence.include?(cfg.gsub!(/[\t =].*$/, ''))
      }.map { |cfg|
        "unset server #{cfg}"
      }
      # combine all commands
      sconfig | usconfig
    when 'queue'
      queues = args[1]
      qdefaults =args[2]
      raise(Puppet::ParseError, 'torque_config_diff(node), second argument has to be a hash') unless queues.is_a?(Hash)
      raise(Puppet::ParseError, 'torque_config_diff(node), third argument has to be an array') unless qdefaults.is_a?(Array)
      clientqueues = lookupvar('torque_queues')
      queueconfig = {}
      queues.keys.each do |queue|
        config = queues[queue].nil? ? qdefaults : queues[queue]
        if clientqueues.include?(queue)
          clientconfig = lookupvar("torque_queue_config_#{queue}").split(',')
          queueconfig[queue] = config - clientconfig
        else
          queueconfig[queue] = config
          queueconfig[queue].unshift("create queue #{queue}") unless clientqueues.include?(queue)
        end
      end
      queueconfig
    when 'node'
      raise(Puppet::ParseError, 'torque_config_diff(): node configuration is not supported yet')
    else
      raise(Puppet::ParseError, "torque_config_diff(): Invalid first argument given (#{args[0]})")
    end
  end
end
