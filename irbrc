#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE

IRB.conf[:AUTO_INDENT] = true

begin
  require 'interactive_editor'
rescue
  puts 'No Interactive Editor'
end

begin
  require 'ap'
rescue
  puts 'No Awesome Print'
end

begin
  require 'wirb'
  Wirb.start
rescue
  puts 'No Wirb'
end

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end
