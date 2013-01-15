module Commands
  module CommandsUtil
    def execute(page)
      @command.call(page)
    end
    
    def execute_and_accept(page, visitor)
      execute(page)
      accept(visitor) 
    end 
  end
end