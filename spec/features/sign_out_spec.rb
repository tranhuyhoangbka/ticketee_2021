require 'rails_helper'

RSpec.feature 'Signed-in users can sign out' do
  let!(:user){FactoryBot.create :user}

  before{login_as(user)}

  scenario do
    visit '/'
    click_link 'Logout'
    expect(page).to have_content 'Signed out successfully.'
  end
end
