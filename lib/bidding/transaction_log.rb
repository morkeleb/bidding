require 'date'

class TransactionLog


  def adapter=(adapter)
    @adapter = adapter
  end

  def adapter
    @adapter ||= InMemoryTransactionLog.new
  end

  def push(transaction)
    transaction["date"] = Time.now.utc.to_f
    adapter.push(transaction)
  end
end
