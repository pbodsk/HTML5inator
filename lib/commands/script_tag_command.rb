require_relative 'commands_util'
require_relative '../visitors/report_generator'
module Commands
  class ScriptTagCommand
    include CommandsUtil
    
    attr_reader :scripts
   
    def initialize()
      @command = lambda do |page|
        @scripts = page.search("script")
      end
    end
    
    
  end
end
