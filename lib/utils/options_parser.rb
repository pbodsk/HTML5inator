require "optparse"
module Utils
  class OptionsParser
    attr_reader :url
    def initialize(argv)
      parse(argv)
    end
    
private
  
    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = "Usage: html5inator [options]"
        opts.on("-u", "--url url", String, "URL of webpage to inspect") do |url|
          @url = url
        end
        
        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end
        
        begin
          argv << "-h" if argv.empty?
          opts.parse(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end
    end
  end
end