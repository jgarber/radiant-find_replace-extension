require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::ReplacementsController do
  dataset :users, :pages

  before :each do
    login_as :admin
  end
  
  describe "submitting a search" do
    it "should show all matching pages" do
      get :new, {:q => 'body'}
      assigns[:pages].should_not be_empty
    end
    
    it "should redirect to the index without a query" do
      get :new
      response.should redirect_to('/admin/replacements')
    end
    
    it "should redirect to the index with a blank query" do
      get :new, {:q => ''}
      response.should redirect_to('/admin/replacements')
    end
  end
  
  describe "submitting a replacement" do
    it "should replace content" do
      page = pages(:first)
      page.part('body').content.should == "First body."
      
      post :create, {:query => "First", :replacement => "1st"}
      response.should redirect_to('/admin/pages')
      flash[:notice].should == "Your replacements were made."
      response.should redirect_to('/admin/pages')
      
      page.reload.part('body').content.should == "1st body."
    end
  end
end