require 'rails_helper'
RSpec.describe LikesController, type: :controller do
  before do
    @user1 = create_user 'julius', 'julius@lakers.com'
    @user2 = create_user
    @secret1 = @user1.secrets.create(content: 'Oops')
    @secret2 = @user1.secrets.create(content: 'I did it again')
    @like = Like.create(user_id: @user2.id, secret_id: @secret1.id)
  end

  describe "when not logged in" do
    before do
    	session[:user_id] = nil
    end

    it "cannot like" do
    	post :create
    	expect(response).to redirect_to('/sessions/new')
    end

    it "cannot unlike" do
    	delete :destroy, id: @secret1
    	expect(response).to redirect_to('/sessions/new')
    end
  end

  describe "when logged in" do
    let(:params) do
      { user_id: @user2.id, secret_id: @secret2.id }
    end
    it "can like" do
      log_in @user2
      # params = { user_id: @user2.id, secret_id: @secret2.id }
      post "/likes", params
      # redirect_to('/secrets')
      # expect(current_path).to eq('/secrets')
      # expect(page).to have_text('Secret liked')
    end
    it "can unlike" do
    end
  end

  # describe "when signed in as the wrong user" do
  #   before do
  #     @wrong_user = create_user 'julius', 'julius@lakers.com'
  #     session[:user_id] = @wrong_user.id
  #   end
  #   it "cannot like" do
  #     post :create
  #     expect(response).to redirect_to('/sessions/new')
  #   end

  #   it "cannot unlike" do
  #     delete :destroy, id: @secret1
  #     expect(response).to redirect_to('/sessions/new')
  #   end

  # describe "when signed in as the wrong user" do
  #   before do
  #     @wrong_user = create_user 'BB', 'b@lakers.com'
  #     session[:user_id] = @wrong_user.id
  #   end

  #   it "cannot access profile page another user" do
  #     get :edit, id: @user
  #     expect(response).to redirect_to("/users/#{@wrong_user.id}")
  #   end
  #   it "cannot update another user" do
  #     patch :update, id: @user
  #     expect(response).to redirect_to("/users/#{@wrong_user.id}")
  #   end
  #   it "cannot destroy another user" do
  #     delete :destroy, id: @user
  #     expect(response).to redirect_to("/users/#{@wrong_user.id}")
  #   end
  # end


end