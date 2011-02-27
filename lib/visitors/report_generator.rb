require 'builder'
module Visitors
  class ReportGenerator
    attr_reader :report_elements
    def initialize      
      @report_elements = []   
    end
   
    def visitDoctype(doctype_command)
      if doctype_command.html5_doctype
          @report_elements.push("You're already using the HTML5 doctype, good")
      else
          @report_elements.push("Your doctype could be upgraded to <!DOCTYPE html>")
      end
      @report_elements.last
    end
    
    def visitTitle(title_command)
        @report_elements.push("Title: #{title_command.title}")
        @report_elements.last
    end
    
    def visitScriptTag(script_tag_command)
      temp_builder = Builder::XmlMarkup.new(:indent => 2)
      if script_tag_command.scripts.length > 0
          temp_builder.p "You no longer need to specify type=\"text/javascript\" on your &lt;script&gt; tags, so you can ditch that on these tags:"
          temp_builder.ul {
            script_tag_command.scripts.each do |script|
              temp_builder.li "#{script}"
            end
          }
          
          temp_elem = temp_builder.to_s
          temp_elem = temp_elem[0,temp_elem.rindex("<to_s/>")]  
          @report_elements.push(temp_elem)
          temp_elem
      else
        @report_elements.push("You have already omitted type=\"text/javascript\" from your &lt;script&gt; tags, good")
        @report_elements.last
      end
    end

    def visitCssTag(css_tag_command)
      temp_builder = Builder::XmlMarkup.new(:indent => 2)
      if css_tag_command.styles.length > 0
          temp_builder.p "You no longer need to specify type=\"text/css\" on your &lt;link&gt; tags, so you can ditch that on these tags:"
          temp_builder.ul {
            css_tag_command.styles.each do |style|
              temp_builder.li "#{style}"
            end            
          }
          temp_elem = temp_builder.to_s
          temp_elem = temp_elem[0,temp_elem.rindex("<to_s/>")]
          @report_elements.push(temp_elem)

          temp_elem
      else
         @report_elements.push("You have already omitted type=\"text/css\" from your &lt;link&gt; tags, good</p>")
         @report_elements.last
      end    
    end    
    
    def generate_html

      @builder = Builder::XmlMarkup.new(:indent => 2)
      @builder.head {
        @builder.title "Report"
      }   
      
      @builder.body {
        @report_elements.each do |element|  
          @builder.section element
        end
      }
      @builder.html
        
    end    
  end
end