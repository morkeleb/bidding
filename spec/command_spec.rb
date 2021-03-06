require 'bidding/command'
require 'bidding/commands/nop'
require 'date'


describe Command do

  it 'will parse the command line' do
    date = DateTime.now
    command = Command.parse("nop 1 2 3", "user", date)

    expect(command.name).to eq("Nop")
    expect(command.arguments).to eq(["1", "2", "3"])
    expect(command.user).to eq("user")
    expect(command.execution_date).to eq(date)
  end

  describe 'Command.build' do
    it 'will build a command line for you' do
      command_line = Command.build("nop", "1", "2", "3")

      expect(command_line).to eq "nop 1 2 3"

    end
    it 'will handle numbers as arguments' do
      command_line = Command.build("nop", "1", 2, "3")

      expect(command_line).to eq "nop 1 2 3"
    end

    it 'will handle dates as arguments' do
      d = DateTime.now
      command_line = Command.build("nop", "1", d, "3")
      expect(command_line).to eq "nop 1 " + d.to_s + " 3"
    end
  end



end
