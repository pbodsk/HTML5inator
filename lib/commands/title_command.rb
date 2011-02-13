require_relative 'commands_util'
module Commands
  class TitleCommand
    include CommandsUtil
    attr_reader :title
    def initialize(&command)
      @command = lambda do |page| 
        @title = page.at(:title).inner_html
      end
    end    
  end
end