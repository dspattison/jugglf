# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'd329d91cbe26ce677a45f274da677dde'
  
  @@layout = 'application'
  
  def render(*args)
    args.first[:layout] = false if request.xhr? and args.first[:layout].nil?
  	super
  end
  
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.invision_user
      @current_member = current_user_member
    end
    
    def current_user_member
      current_member = nil
      
      if current_user
        char = @current_user.character_name.titlecase
        member = Member.find_by_name(char)
        current_member = member unless member.nil?
      end
      
      return current_member
    end
    
    def require_admin
      if current_user
        unless @current_user.is_admin?
          flash[:error] = "You do not have permission to access that page."
          if @current_member.nil?
            redirect_to('/todo') # TODO: Redirect to summary page
          else
            redirect_to(member_path(@current_member))
          end
        end
      else
        return require_user
      end
    end
    
    def require_user
      unless current_user
        store_location
        flash[:error] = "You must be logged in to access that page."
        redirect_to(new_user_session_url)
        return false
      end
    end
    
    def require_no_user
      if current_user
        store_location
        # TODO: Redirect to summary page
        redirect_to('/todo')
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
