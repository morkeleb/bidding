# Bidding

Bidding is a small gem for handling the command pattern.
The goal is to let the commands be easy to implement, and to provide basic infrastructure for executing commands.

The infrastructure is a command queue, a command executor which executes transactions and a transaction log which keeps a record of all executed commands.

It's inspried from the CQRS movement, except it is left up to the implementor to decide if the commands should issue events and thus use eventsourcing.
Or if it simple should keep a record of all executed commands.

The gem uses an in memory transaction log and queue. Right now the idea is that adapters to different queues and storage backed logs should be implemented outside the gem.
Thus keeping the gem dependencies as small as possible.

## Installation

Add this line to your application's Gemfile:

    gem 'bidding'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bidding

## Usage

When you require 'bidding' you get access to a bunch of classes.
The most important one is the Command class.

### Commands
To create a command simple inherit from the Command class and add an execute method.

```ruby

class Nop < Command

	def execute 
		# this code executes what the command does
	end

end

```

This will allow you to execute the nop command simply by parsing and executing the command.


```ruby

Command.parse("nop").execute()

```

#### Parameters

A command wouldn't be much use unless it could take a few paramters. Since the focus here is to have the command code as readable as possible.
You simple specify the arguments of the command in order in which they appear.

```ruby

class Nop < Command

	parameters :type, :id, :title

	def execute 
		# this code executes what the command does
		# you can use type, id and title here.
	end

end

```

the parameters method adds properties to the command which correspond to the location of the arguments in the commandline string.
The code above has 3 parameters: type, id and title. These are all available in the execute method.

Example:

```ruby

class Nop < Command

	parameters :type, :id, :title

	def execute 
		p type
		p id
		p URI.unescape(title)
	end

end

Command.parse("nop the_type 12345 awesome%20stuff!").execute()

# outputs
# > the_type
# > 12345
# > awesome!

```

Each parameter is separated with a space. If you would like to add parameter values that contain spaces I recommend URI encoding them first.
This allows you to handle strings that might contain spaces.

#### Building a command line in ruby

Sometimes you want to create a command line in Ruby. This could become a classic point of pain where concatinating strings creates ugly code.
You might end up with something similar to

```ruby

command_line = "nop " + my_arguments + " " + date.to_s + " " + integer.to_s

```
Thats code isnt really nice to look at, so Bidding has a helper method to make prettier

```ruby

command_line = Command.build("nop", my_arguments, date, integer.to_s)

```

### Components

Appart from the Command structure bidding has 3 major components. All quite simple in their implementations.

The Executor, the command queue and the transaction log.
The executor executes commands and if they are successfull the commands are pushed to the transaction log. The command queue keeps a queue of commands to be executed in order.

The gem contains an inmemory queue and log for testing purposes.

The TransactionLog and the queue should be implemented as need be.

#### The queue

Pushing a command to the queue is done simply by calling

```ruby

Bidding.command_queue.pushCommands {"commands"=>["nop"]}

```

You can change which implementation for the queue to use by setting which queue to use in bidding.


```ruby

Bidding.command_queue = MyOwnImplementationOfTheQueue.new

```

#### Executor

The commands executor takes a hash of commands from a queue and executes them in order. Successfull commands are pushed to a log.
If the commands are not successfull the commands are left on the queue.

Commands can be executed immidiatly by calling execute commands


```ruby

Bidding.execute_commands {"commands"=>["nop"]}

```

The example above will send the commands directly to the executor without passing the queue.

The executor implementation can also be changed.

```ruby

Bidding.executor = MyOwnImplementationOfTheExecutor.new

```

#### The transaction log

The log keeps track of which commands that have been successfully been executed and in which order.

> The concept of the transaction log is inspired by Event Sourcing. If you want to use events as a termonology I would recommend looking into changing the implementation of the executor. The reason I didn't go all in is a wish to start simple. Bidding might support event sourcing in the future.

Bidding contains some helper tools that should help you create rake files to import and or export transaction logs to JSON files.

These JSON files help you to keep a backup of the command logs on disc. They also allow you to completley replay all commands in the system, effectivlly allowing you to change details of the history.

Which log implementation to use can be changed similar to the other components.


```ruby

Bidding.transaction_log = MyOwnImplementationOfTheTransactionLog.new

```

## Contributing

1. Fork it ( http://github.com/morkeleb/bidding/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
