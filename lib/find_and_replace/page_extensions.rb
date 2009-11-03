module FindAndReplace::PageExtensions
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    # searches an exact phrase
    def find_content(q)
      case Page.connection.adapter_name.downcase
      when 'postgresql'
        sql_content_check = "(page_parts.content LIKE ?)"
      when 'sqlite'
        Page.connection.execute("PRAGMA CASE_SENSITIVE_LIKE=ON")
        sql_content_check = "(page_parts.content LIKE ?)"
      else                                                      
        sql_content_check = "(page_parts.content LIKE BINARY ?)"
      end
      unless (query = q.to_s.strip).blank?
        Page.find(:all, :order => 'published_at DESC', :include => [ :parts ],
            :conditions => ["#{sql_content_check}", "%#{query}%"])
      end
    end
  end
  
end