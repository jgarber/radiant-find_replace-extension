require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::ReplacementsHelper do
  before(:each) do
    @content = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end
  
  it "should highlight a found phrase in some text" do
    helper.truncate_and_highlight(@content, "Lorem", 100).should == "<strong class=\"highlight\">Lorem</strong> ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore..."
  end
  
  it "should truncate to 100 characters by default" do
    helper.truncate_and_highlight(@content, "Lorem", 100).size.should == 100 + "<strong class=\"highlight\"></strong>...".size
  end
  
  it "should truncate to X characters" do
    helper.truncate_and_highlight(@content, "Lorem", 20).size.should == 20 + "<strong class=\"highlight\"></strong>...".size
  end
  
  it "should truncate properly when found phrase is near the end" do
    helper.truncate_and_highlight(@content, "laborum", 100).should == " in culpa qui officia deserunt mollit anim id est <strong class=\"highlight\">laborum</strong>...."
  end
  
  it "should not truncate if another match occurs in the otherwise-truncated part" do
    helper.truncate_and_highlight(@content, "dolor").should == "Lorem ipsum <strong class=\"highlight\">dolor</strong> sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et <strong class=\"highlight\">dolor</strong>e magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure <strong class=\"highlight\">dolor</strong> in reprehenderit in voluptate velit esse cillum <strong class=\"highlight\">dolor</strong>e eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end
end