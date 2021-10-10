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
    within('.ticket') do
      expect(page).to have_content "Author: #{user.email}"
    end
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

  scenario 'with an attachment', js: true do
    fill_in 'Name', with: 'Sample Ticket Name'
    fill_in 'Description', with: 'sample Ticket Description'
    #attach_file "File", "spec/fixtures/speed.txt"
    attach_file("spec/fixtures/speed.txt", class: 'dz-hidden-input', visible: false)
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has been created."
    within '.ticket .attachments' do
      expect(page).to have_content 'speed.txt'
    end
  end
end
