require File.dirname(__FILE__) + '/../spec_helper'

describe Page, 'find and replace' do
  dataset :pages
  
  it "should find all pages including a specific phrase in part content" do
    q = "body"
    found_pages = Page.find_content(q)
    found_pages.should_not be_empty
  end
  
  it "should find no pages for a phrase that does not exist" do
    q = "This content does not exist. No no no! It is merely in your imagination."
    found_pages = Page.find_content(q)
    found_pages.should be_empty
  end
  
  it "should be case sensitive" do
    q = "Body"
    found_pages = Page.find_content(q)
    found_pages.should be_empty
  end
  
  it "should not find query in page titles" do
    q = "Another"
    found_pages = Page.find_content(q)
    found_pages.should be_empty
  end
end
