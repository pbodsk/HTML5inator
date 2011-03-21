require_relative 'commands_util'
require_relative '../visitors/report_generator'
module Commands
  class CssTagCommand
    include CommandsUtil
    
    attr_reader :styles
   
    def initialize()
      @command = lambda do |page|
        @styles = []
        @all_styles = page.search("link")
        @all_styles.each do |style|
          style = style.to_s
          if /text\/css/ =~ style
            style.gsub!(/</, "&lt;")
            style.gsub!(/>/, "&gt;")
            @styles.push(style)
          end
        end
      end
    end
    
    def accept(visitor)
      visitor.visitCssTag(self)
    end
    
    def execute_and_accept(page, visitor)
      execute(page)
      accept(visitor)
    end
    
  end
end
