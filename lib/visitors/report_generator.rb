module Visitors
  class ReportGenerator
    def visitDoctype(doctype_command)
      if doctype_command.html5_doctype
        "<p>You're already using the HTML5 doctype, good</p>"
      else
        "<p>Your doctype could be upgraded to <!DOCTYPE html></p>"
      end
    end
    
    def visitTitle(title_command)
      "<p>Title: #{title_command.title}</p>"
    end
    
    def visitScriptTag(script_tag_command)
      if script_tag_command.scripts.length > 0
        return_value = "<p>You no longer need to specify type=\"text/javascript\" on your &lt;script&gt; tags, so you can ditch that on these tags:</p>
        <ul>"  
        script_tag_command.scripts.each do |script|
          return_value << "<li>" << script << "</li>"
        end
         return_value += "</ul>"
        
      else
        '<p>You have already omitted type="text/javascript" from your &lt;script&gt; tags, good</p>'
      end
    end
    
    def visitCssTag(css_tag_command)
      if css_tag_command.styles.length > 0
        return_value = "<p>You no longer need to specify type=\"text/css\" on your &lt;link&gt; tags, so you can ditch that on these tags:</p>
        <ul>"  
        css_tag_command.styles.each do |style|
          return_value << "<li>" << style << "</li>"
        end
         return_value += "</ul>"
        
      else
        '<p>You have already omitted type="text/css" from your &lt;link&gt; tags, good</p>'
      end
      
    end
  end
end