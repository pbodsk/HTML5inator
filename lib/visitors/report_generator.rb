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
  end
end