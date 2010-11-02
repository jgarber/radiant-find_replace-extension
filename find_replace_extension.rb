# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class FindReplaceExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/find_replace"
  
  define_routes do |map|
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :replacements
    end
  end
  
  def activate
    admin.tabs.add "Find And Replace", "/admin/replacements", :after => "Layouts", :visibility => [:admin]
    
    Page.send :include, FindReplace::PageExtensions
  end
  
  def deactivate
    # admin.tabs.remove "Find And Replace"
  end
  
end
