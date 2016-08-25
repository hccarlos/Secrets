class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.all
  end

  def new
  end

  def create
  	@user = User.new( user_params )
  	if @user.save
  		flash[:notice] = "User successfully created"
      session[:user_id] = @user.id
  		redirect_to "/users/#{@user.id}"
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to "/users/new"
  	end
  end

  def show
    @user = User.find(params[:id])
    @urlID = params[:id].to_i
    @mySecrets = Secret.where("user_id = (?)", @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  	# current_user.update(update_user_params)
    @user.update(update_user_params)
  	# redirect_to "/users/#{current_user.id}"
    redirect_to "/users/#{@user.id}"
  end

  def destroy
  	current_user.destroy
  	redirect_to "/sessions/logout"
  end

private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def update_user_params
		params.require(:user).permit(:name, :email)
	end

end