require_relative 'commands_util'
module Commands
  class TitleCommand
    include CommandsUtil
    def initialize(&command)
      @command = lambda do |page| 
        page.at(:title).inner_html
      end
    end    
  end
end