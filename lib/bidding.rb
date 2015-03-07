require "bidding/version"
require 'bidding/command'
require 'bidding/command_queue'
require 'bidding/commands_executor'
require 'bidding/transaction_log'
require 'bidding/in_memory_transaction_log'
require 'bidding/commands/nop'
require 'bidding/tools/exporter'
require 'bidding/tools/importer'

module Bidding

  @@executor = CommandsExecutor.new
  @@log = TransactionLog.new
  @@queue = CommandQueue.new

  def self.executor=(executor)
    @@executor = executor
  end


  def self.execute_commands commands
    @@executor.execute commands
  end

  def self.transaction_log=(log)
    @@log = log
  end

  def self.command_queue=(queue)
    @@queue = queue
  end

  def self.command_queue
    @@queue
  end

  def self.log_commands commands
    @@log.push commands
  end




end
