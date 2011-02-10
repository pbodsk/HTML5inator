require_relative 'commands_util'
module Commands
  class DoctypeCommand
    include CommandsUtil
    def initialize(&command)
      @command = lambda do |page| 
        ! /<!DOCTYPE html SYSTEM>/.match(page.at('!DOCTYPE').to_s).nil?
      end
    end    
  end
end