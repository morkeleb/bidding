require 'bidding/commands_executor'
require 'bidding/command_queue'
require 'bidding/command'
require 'bidding/commands/nop'
require 'bidding/transaction_log'
require 'bidding'

describe CommandsExecutor do

  describe 'when a new transaction arrives' do
    before do
      @transactionLog = TransactionLog.new
      @queue = CommandQueue.new
      @executor = CommandsExecutor.new
      Bidding.command_queue = @queue
      Bidding.executor = @executor
      Bidding.transaction_log = @transactionLog
    end

    it 'will recieve updates from the queue' do
      expect(@executor).to receive("execute")
      @queue.pushCommands({"commands"=>"", "id"=>'myid'})
    end
    describe 'on updates' do

      describe 'when the transaction is executed' do
        before do
          allow_any_instance_of(Command).to receive('parse').and_return(Nop.new)
        end

        it 'will remove the transaction from the queue' do
          @queue.pushCommands({"commands"=>["nop"], "id"=>'myid'})
          expect(@queue.length).to eq 0

        end

        it 'will set a time for the command when parsing' do
          expect(Command).to receive("parse")
          @queue.pushCommands({"commands"=>["nop"], "id"=>'myid'})
        end

        it 'will post the transaction to the TransactionLog' do
          expect(@transactionLog).to receive("push").and_return(1)
          @queue.pushCommands({"commands"=>["nop"], "id"=>'myid'})
          expect(@queue.length).to eq 0
        end
      end

      describe 'if the transaction fails' do
        before do
          expect(Command).to receive("parse").and_raise(Exception)
        end
        it 'will remain on the queue' do
          @queue.pushCommands({"commands"=>["nop"], "id"=>'myid'})
          expect(@queue.length).to eq 1
        end
      end
    end
  end

end
