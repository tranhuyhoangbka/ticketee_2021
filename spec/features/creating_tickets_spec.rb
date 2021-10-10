require 'rails_helper'

RSpec.feature 'Users can create new tickets' do
  let(:user){FactoryBot.create(:user)}
  let!(:project){FactoryBot.create(:project)}

  before do
    login_as user
    visit project_path(project)
    click_link 'New Ticket'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with: 'Sample Ticket Name'
    fill_in 'Description', with: 'sample Ticket Description'
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket has been created.'
  end

  scenario 'when providing invalid attributes' do
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket has not been created.'
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario 'with an invalid description' do
    fill_in 'Name', with: 'Sample Ticket Name'
    fill_in 'Description', with: 'short'
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket has not been created.'
    expect(page).to have_content 'Description is too short'
  end
end
