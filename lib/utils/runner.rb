require_relative 'options_parser'
require_relative '../parse/page_provider'
require_relative '../commands/css_tag_command'
require_relative '../commands/doctype_command'
require_relative '../commands/script_tag_command'
require_relative '../commands/title_command'
require_relative '../visitors/report_generator'

module Utils
  class Runner
    attr_reader :commands
    attr_reader :report_generator
    def initialize(argv)
      @options = Utils::OptionsParser.new(argv)
      @page = Parse::PageProvider.new(@options.url).page
      @report_generator = Visitors::ReportGenerator.new
      @commands = []
      load_commands
    end
    
    def run
      @commands.each do |command|
        command.execute_and_accept(@page, @report_generator)
      end
    end
    
private
    def load_commands
      @commands.push(Commands::TitleCommand.new)
      @commands.push(Commands::DoctypeCommand.new)
      @commands.push(Commands::CssTagCommand.new)
      @commands.push(Commands::ScriptTagCommand.new)
    end
  end
end