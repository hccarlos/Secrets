class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  def index
  	@secrets = Secret.all
    @myLikedSecrets = Like.where("user_id = (?)", current_user.id).select("secret_id")
  end

  def create
  	@secret = Secret.new(user_id: params[:user_id], content: params[:newSecret])
  	if @secret.save
  		flash[:notice] = "Secret successfully created"
  	else
  		flash[:errors] = @user.errors.full_messages
  	end
  	redirect_to "/users/#{params[:user_id]}"
  end

  def destroy
    secret = Secret.find(params[:id])
    secret.destroy if secret.user == current_user
    redirect_to "/users/#{current_user.id}"
    # redirect_to :back
  end
end
