class InMemoryTransactionLog

	def initialize
		@list = []
	end

	def push(transaction)
		@list.push(transaction)
	end

	def from(date)
		@list.select { |entry| entry["date"] < date}
	end


	def containsId? (id)
		 @list.index { |trans| trans["id"] == id  } != nil
	end

	def delete(entry)
		@list.delete_if { |entry| entry["id"] == entry}
	end

	# for testing purposes only
	def log
		@list
	end


end