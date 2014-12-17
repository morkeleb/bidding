require 'observer'

class CommandQueue

	def initialize
		@list = []
	end

	def list
		@list
	end

	def pushCommands(commands)
		@list.push commands
		if(Bidding.execute_commands commands)
			@list.delete commands
		end
	end

	def length
		@list.length
	end

	def return(transaction)
		@list.insert(0, transaction)
	end

	def next
		@list.shift
	end

	def exists? (id)
		@list.index { |item| item[:id] == id} != nil
	end

end
