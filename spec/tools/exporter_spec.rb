#require 'mongo_transaction_log'
require 'date'
require 'bidding/tools/exporter'
require 'bidding/in_memory_transaction_log'
require 'bidding'

describe 'export log job' do


	describe 'when running' do
		

		before do
			@log = TransactionLog.new
			@log.adapter = InMemoryTransactionLog.new

			Bidding.transaction_log = @log
			Dir.mkdir './tmp' unless File.exists? './tmp'
			setup_commands '1234', ['nop']

		end

		def setup_commands(user, commands)
			queue = CommandQueue.new
			executor = CommandsExecutor.new
			Bidding.executor = executor
			queue.pushCommands({
				"id"=>"setup",
				"user"=>user,
				"commands"=>commands})
		end

		it 'will get all the previous log entries and write them to a file' do
			
			exporter = Exporter.new @log.adapter

			exporter.export_from Time.now.utc

			json = JSON.parse(File.read("./tmp/log-" + Time.now.utc.to_date.to_s + ".json"))

			expect(json[0]['commands']).to eq ['nop']

		end

		it 'will delete the exported entries' do
			exporter = Exporter.new @log.adapter

			exporter.export_from Time.now.utc.nsec

			json = JSON.parse(File.read("./tmp/log-" +Time.now.utc.to_date.to_s + ".json"))

			entries = @log.adapter.from Time.now.utc.nsec
			expect(entries.count).to eq 0

		end

		it 'will write to a file with the current date' do 
			exporter = Exporter.new @log.adapter

			exporter.export_from Time.now.utc

			expect(File.exists?("./tmp/log-" + Time.now.utc.to_date.to_s + ".json")).to be true

		end

	end


end