class LikesController < ApplicationController
before_action :require_login, only: [:create, :destroy]
	def create
		@like = Like.new(secret_id: params[:secret_id], user_id: current_user.id)
		if @like.save
			flash[:notice] = "Secret liked"
		else
			flash[:notice] = "Error"
		end
		redirect_to "/secrets"
	end

	def destroy
		Like.where(secret_id: params[:id], user_id: current_user.id).destroy_all
		redirect_to "/secrets"
	end

end
