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
  
  def test_html5_doctype_will_be_false_if_not_html5_doctype
    @doctype_command.execute(@page)
    
    refute(@doctype_command.html5_doctype)
  end
  
  def test_html5_doctype_will_be_true_if_html5_doctype
    @page = Parse::PageProvider.new("http://youtube.com/html5").page
    @doctype_command.execute(@page)
    
    assert(@doctype_command.html5_doctype)
  end
end