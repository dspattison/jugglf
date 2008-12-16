class MembersController < ApplicationController
  layout 'poison'
  
  def index
    @members = Member.find(:all, :order => "name asc")
    
    respond_to do |wants|
      wants.html
    end
  end
  
  def show
    @member = Member.find(params[:id])
    @raids  = Raid.find(:all, :order => "date DESC")
    
    respond_to do |wants|
      wants.html
    end
  end
end
