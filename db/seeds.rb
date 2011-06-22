puts "Emptying MongoDB..."
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
