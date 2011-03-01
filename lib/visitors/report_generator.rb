require 'builder'
module Visitors
  class ReportGenerator
    attr_reader :report_elements
    def initialize      
      @report_elements = []   
    end
   
    def visitDoctype(doctype_command)
      if doctype_command.html5_doctype
          @report_elements.push("<p>You're already using the HTML5 doctype, good</p>")
      else
          @report_elements.push("<p>Your doctype could be upgraded to &lt;!DOCTYPE html&gt;</p>")
      end
      @report_elements.last
    end
    
    def visitTitle(title_command)
        @report_elements.push("Title: #{title_command.title}")
        @report_elements.last
    end
    
    def visitScriptTag(script_tag_command)
      temp_element = ""
      if script_tag_command.scripts.length > 0
          temp_element << "<p>You no longer need to specify type=\"text/javascript\" on your &lt;script&gt; tags, so you can ditch that on these tags:</p><ul>"
          script_tag_command.scripts.each do |script|
            temp_element << "<li>#{script}</li>"
          end
          temp_element << "</ul>"
          
          @report_elements.push(temp_element)
          temp_element
      else
        @report_elements.push("<p>You have already omitted type=\"text/javascript\" from your &lt;script&gt; tags, good</p>")
        @report_elements.last
      end
    end

    def visitCssTag(css_tag_command)
      temp_element = ""
      if css_tag_command.styles.length > 0
          temp_element << "<p>You no longer need to specify type=\"text/css\" on your &lt;link&gt; tags, so you can ditch that on these tags:</p><ul>"
          css_tag_command.styles.each do |style|
            temp_element << "<li>#{style}</li>"
          end            
          temp_element << "</ul>"

          @report_elements.push(temp_element)
          temp_element
      else
         @report_elements.push("<p>You have already omitted type=\"text/css\" from your &lt;link&gt; tags, good</p>")
         @report_elements.last
      end    
    end    
    
    def generate_html
      html_string = "<!DOCTYPE html><html><head><title>Report</title></head><body>"
      @report_elements.each do |element|  
        html_string << "<section>#{element}</section>"
      end
      
      html_string << "</body></html>"
      html_string
    end    
  end
end