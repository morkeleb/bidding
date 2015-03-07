require 'bidding/transaction_log'

describe TransactionLog do
  before do
    @transactionLog = TransactionLog.new
  end

  describe 'when a transaction is pushed to the log' do
    it 'will store the transaction' do
      transaction = {"id"=>'test'}
      @transactionLog.push(transaction)

      expect(@transactionLog.adapter.containsId?('test')).to be true
    end

  end

  end
