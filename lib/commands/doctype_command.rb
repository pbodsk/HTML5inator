require_relative 'commands_util'
module Commands
  class DoctypeCommand
    include CommandsUtil
    attr_reader :html5_doctype
    def initialize(&command)
      @command = lambda do |page| 
        @html5_doctype =  ! /<!DOCTYPE html SYSTEM>/.match(page.at('!DOCTYPE').to_s).nil?
      end
    end    
    
=begin    
    def accept(visitor)
      visitor.visitDoctype(self)
    end
=end
  end
end