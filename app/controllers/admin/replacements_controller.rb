class Admin::ReplacementsController < ApplicationController
  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
    :when => :admin,
    :denied_url => { :controller => 'pages', :action => 'index' },
    :denied_message => 'You must have administrative privileges to perform this action.'
  
  def new
    if params[:q].blank?
      redirect_to(:action => :index)
    else
      @query = params[:q].to_s
      @pages = Page.find_content(@query)
    end
  end
  
  def create
    @query = params[:query].to_s
    @replacement = params[:replacement].to_s
    @pages = Page.find_content(@query)
    @pages.each do |page|
      page = page.current if page.respond_to?(:current)
      page.parts(true)
      page.parts.each do |part|
        part.content = part.content.gsub(@query, @replacement)
        part.save!
      end
      page.save!
    end
    cache.clear
    announce_replaced
    redirect_to(:controller => :pages)
  end
  
  private
  
  def announce_replaced(message = nil)
    flash[:notice] = message || "Your replacements were made."
  end
end