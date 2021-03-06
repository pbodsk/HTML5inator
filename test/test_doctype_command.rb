require_relative '../lib/commands/doctype_command'
require_relative '../lib/visitors/report_generator'
require_relative '../lib/parse/page_provider'
require_relative 'mock_page'
require 'test/unit'

class TestDoctypeCommand < Test::Unit::TestCase
  def setup
    puts "setup"
    @page = MockPage.new
    @doctype_command = Commands::DoctypeCommand.new 
  end
  
  def test_can_create_doctype_command 
    refute_nil(@doctype_command)      
  end
  
  def test_html5_doctype_will_be_false_if_not_html5_doctype
    @page.doctype = "<!DOCTYPE htmlfake SYSTEM>"
    @doctype_command.execute(@page)
    
    refute(@doctype_command.html5_doctype)
  end
  
  def test_html5_doctype_will_be_true_if_html5_doctype
    @page.doctype = "<!DOCTYPE html SYSTEM>"
    @doctype_command.execute(@page)
    
    assert(@doctype_command.html5_doctype)
  end  
end