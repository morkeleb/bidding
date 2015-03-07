require 'bidding/command_queue'
require 'bidding'


describe 'CommandQueue' do

  describe "when a new message is posted" do
    it 'will be placed on the queue' do
      queue = CommandQueue.new

      queue.pushCommands( {:commands=>[], :id=>'dede'})

      queue.list.count == 1

    end
    it 'will signal an observer that a new item is on the queue' do
      observer = double('observer')

      expect(observer).to receive(:execute)
      Bidding.executor = observer

      queue = CommandQueue.new



      queue.pushCommands( {:commands=>[], :id=>'dede'})

    end
  end

  end
