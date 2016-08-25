require 'rails_helper'
RSpec.describe 'updating user' do
  it 'updates user and redirects to profile page' do
    user = create_user
    log_in user
    expect(page).to have_text('AA')
    click_link 'Edit Profile'
    fill_in 'user[name]', with: 'drake'
    click_button 'Update'
    # expect(current_path).to eq('/users/#{userID}')
    expect(page).not_to have_text('AA')
    expect(page).to have_text('drake')
  end
end