
class CommandsExecutor
	def execute(commands)
		commands["commands"].each {|c|
			co = Command.parse(c, commands["user"])
			co.execute()
		}
		Bidding.log_commands commands
		return true
		rescue Exception
			p 'EXCEPTION'
			p $!.to_s
			p $!.backtrace
			return false
	end


end