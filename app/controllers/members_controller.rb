class MembersController < ApplicationController
  layout 'poison'
  
  def index
    @members = Member.find(:all, :order => "lf DESC, name ASC")
    
    respond_to do |wants|
      wants.html
    end
  end
  
  def show
    @member = Member.find(params[:id])
    @raids = Raid.find(:all, :limit => 5) # Temp
    
    respond_to do |wants|
      wants.html
    end
  end
end
