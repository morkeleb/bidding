require 'time'
require 'bidding/command'
Dir["./lib/commands/**/*.rb"].sort.each {|f| require f}
Dir["./lib/models/**/*.rb"].sort.each {|f| require f}
class Importer

	def import file
		p 'importing file ' + file
		transaction = JSON File.read file

		transaction.each { |trans| 
			commands = trans["commands"]
			commands.each { |command_string| 
				command = Command.parse command_string, trans["user"], Time.at(trans["date"])
				command.replay
				}
		 }

		File.delete file

	end

end
