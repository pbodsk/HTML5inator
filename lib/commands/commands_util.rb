module Commands
  module CommandsUtil
    def execute(page)
      @command.call(page)
    end
  end
end