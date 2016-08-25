require 'rails_helper'
RSpec.describe 'deleting a secret' do
  before do
    @user = create_user
    log_in @user
    fill_in 'newSecret', with: 'My secret'
    find("input[name=create_secret]").click
    expect(page).to have_text('My secret')
  end
  it 'deletes secrets from profile page and redirects to profile page' do
    click_on("deleteSecret")
    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).not_to have_text('My secret')
  end
  it 'deletes secret from secrets index page and redirects to current user profile page' do
    visit '/secrets'
    find("input[name=Delete]").click
    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).not_to have_text('My secret')
  end
end