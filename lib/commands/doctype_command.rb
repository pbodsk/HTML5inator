require_relative 'commands_util'
require_relative '../visitors/report_generator'
module Commands
  class DoctypeCommand
    include CommandsUtil
    attr_reader :html5_doctype
    def initialize()
      @command = lambda do |page| 
        @html5_doctype =  ! /<!DOCTYPE html SYSTEM>/.match(page.at('!DOCTYPE').to_s).nil?
      end
    end    
    
    def accept(visitor)
      visitor.visitDoctype(self)
    end
    
    def execute_and_accept(page, visitor)
      execute(page)
      accept(visitor)
    end
  end
end