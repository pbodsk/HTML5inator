require_relative '../lib/commands/doctype_command'
require_relative '../lib/parse/page_provider'
require 'test/unit'

class TestDoctypeCommand < Test::Unit::TestCase
  def setup
    @page = Parse::PageProvider.new("http://peterbodskov.dk").page
    @doctype_command = Commands::DoctypeCommand.new 
  end
  
  def test_can_create 
    refute_nil(@doctype_command)      
  end
  
  def test_will_return_false_if_not_html5_doctype
    refute(@doctype_command.execute(@page))
  end
  
  def test_will_return_true_if_html5_doctype
    @page = Parse::PageProvider.new("http://youtube.com/html5").page
    assert(@doctype_command.execute(@page))
  end
end