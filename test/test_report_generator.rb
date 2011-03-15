require_relative 'mock_page'
require 'test/unit'

class TestDoctypeCommand < Test::Unit::TestCase
  def setup
    @page = MockPage.new
    @doctype_command = Commands::DoctypeCommand.new 
    @report_generator = Visitors::ReportGenerator.new
  end

  def test_can_create_report_generator
    refute_nil(@report_generator)
  end
  
  def test_can_accept_doctype_visitor_html5
    @page.doctype = "<!DOCTYPE html SYSTEM>"
    
    refute_nil(/HTML5 doctype/ =~ @doctype_command.execute_and_accept(@page, @report_generator))
    assert_equal(@report_generator.report_elements.size, 1)
  end
  
  def test_can_accept_doctype_visitor_not_html5
    @page.doctype = "<!DOCTYPE htmlfake SYSTEM>"
    
    refute_nil(/upgraded/ =~ @doctype_command.execute_and_accept(@page, @report_generator))
    assert_equal(@report_generator.report_elements.size, 1)
  end
  
  def test_can_accept_title_visitor
    @title_command = Commands::TitleCommand.new
    refute_nil(@title_command)

    refute_nil(/Mocked title/ =~ @title_command.execute_and_accept(@page, @report_generator))
    assert_equal(@report_generator.report_elements.size, 1)
  end
  
  def test_can_accept_script_tag_visitor_on_scripts_with_type_set
    @script_tag_command = Commands::ScriptTagCommand.new
    refute_nil(@script_tag_command)
    refute_nil(/<li>/ =~ @script_tag_command.execute_and_accept(@page, @report_generator))
    assert_equal(@report_generator.report_elements.size, 1)
  end
  
  def test_can_accept_script_tag_visitor_on_scripts_without_type_set
    @script_tag_command = Commands::ScriptTagCommand.new
    refute_nil(@script_tag_command)
    @page.mock_script = ["&lt;script src='blah.js'&gt; &lt;script&gt;"]
    
    refute_nil(/You have already omitted/ =~ @script_tag_command.execute_and_accept(@page, @report_generator))
    assert_equal(@report_generator.report_elements.size, 1)
  end

  def test_can_accept_css_tag_visitor_on_css_with_type_set
    @css_tag_command = Commands::CssTagCommand.new
    refute_nil(@css_tag_command)

    refute_nil(/<li>/ =~ @css_tag_command.execute_and_accept(@page, @report_generator))
    assert_equal(@report_generator.report_elements.size, 1)
  end

  def test_can_accept_css_tag_visitor_on_css_without_type_set
    @css_tag_command = Commands::CssTagCommand.new
    refute_nil(@css_tag_command)
    @page.mock_style = ["&lt;link href='blah.css'&gt; /&gt;"]
    
    refute_nil(/You have already omitted/ =~ @css_tag_command.execute_and_accept(@page, @report_generator))
    assert_equal(@report_generator.report_elements.size, 1)
  end

  def test_can_build_html
    @css_tag_command = Commands::CssTagCommand.new
    @script_tag_command = Commands::ScriptTagCommand.new
    @title_command = Commands::TitleCommand.new
    
    @doctype_command.execute_and_accept(@page, @report_generator)
    @title_command.execute_and_accept(@page, @report_generator)
    @css_tag_command.execute_and_accept(@page, @report_generator)
    @script_tag_command.execute_and_accept(@page, @report_generator)
    
    output = @report_generator.generate_html
    #puts output
    refute_nil(/text\/javascript/ =~ output)
    refute_nil(/text\/css/ =~ output)
 
  end
end