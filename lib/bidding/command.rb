class Command
  attr_accessor :name, :arguments, :user, :commandline

  def self.parameters(*args)
    args.each do |arg|
      self.class_eval("def #{arg};arguments["+args.index(arg).to_s+"];end")  
    end
  end

  def self.parse(commandline, user)
    parts = commandline.split(" ")
    name = camel_case parts.shift
    command = Kernel.const_get(name).new
    command.name = name
    command.user = user
    command.arguments = parts
    command.commandline = commandline
    return command
  end

  def self.camel_case(s)
    return s if s !~ /_/ && s =~ /[A-Z]+.*/
    s.split('_').map{|e| e.capitalize}.join
  end


  def execute
    raise 'execute method not implemented for class: ' + self.class.name
  end

  def replay
    @replay = true
    execute
  end

end
