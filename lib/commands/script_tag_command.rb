require_relative 'commands_util'
require_relative '../visitors/report_generator'
module Commands
  class ScriptTagCommand
    include CommandsUtil
    
    attr_reader :scripts
   
    def initialize()
      @command = lambda do |page|
        @scripts = []
        @all_scripts = page.search("script")
        @all_scripts.each do |script|
          script = script.to_s
          if /text\/javascript/ =~ script
            script.gsub!(/</, "&lt;")
            script.gsub!(/>/, "&gt;")
            @scripts.push(script)
          end
        end
      end
    end
    
    def accept(visitor)
      visitor.visitScriptTag(self)
    end
    
    def execute_and_accept(page, visitor)
      execute(page)
      accept(visitor)
    end
    
  end
end
