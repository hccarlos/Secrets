class SessionsController < ApplicationController
  def new

  end
  def login
  	@user = User.find_by_email(params[:email])
    if @user
    	if @user.authenticate(params[:password])
    		session[:user_id] = @user.id
    		redirect_to "/users/#{@user.id}"
    	else
    		flash[:error] = "Invalid email/password combo"
    		redirect_to "/sessions/new"
    	end
    else
      flash[:error] = "No user by that email"
      redirect_to "/sessions/new"
    end
  end

  def logout
  	session[:user_id] = nil
  	redirect_to "/sessions/new"
  end
end
