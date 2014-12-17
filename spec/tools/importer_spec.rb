require 'json'
require 'bidding/tools/importer'

describe 'importer' do

	describe 'when importing a single file' do

		before do
			transaction = [{"commands"=>['nop']}]
			
			Dir.mkdir './tmp' unless File.exists? './tmp'
			File.open("./tmp/log.json", "w") { |io|
				io.write JSON transaction
			  }
		end

		it 'will run all the commands using a command executor' do
			expect_any_instance_of(Nop).to receive(:execute)
			
			importer = Importer.new

			importer.import "./tmp/log.json"


		end

		it 'will run all commands with a replay flag set' do

		end

		it 'will delete the file once done' do
			importer = Importer.new

			importer.import "./tmp/log.json"

			expect(File.exist?("./tmp/log.json")).to be false
		end
	end

end