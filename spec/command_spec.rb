require 'bidding/command'


describe Command do

	it 'will parse the command line' do

		command = Command.parse("nop 1 2 3", "user")

		expect(command.name).to eq("Nop")
		expect(command.arguments).to eq(["1", "2", "3"])
		expect(command.user).to eq("user")
	end

end