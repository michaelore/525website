class UserController < ApplicationController
  layout 'standard'
  def login
	if session[:logged_in] then
		redirect_to :controller => "posts", :action => "index"
	end
  end

  def process_login
	if params[:password] == "swartdizzle" then
		session[:logged_in] = true
		redirect_to :controller => "posts", :action => "index"
	else
		redirect_to :controller => "user", :action => "login", :bad_password => true
	end
  end

  def logout
	session[:logged_in] = false
	redirect_to :controller => "posts", :action => "index"
  end

end
