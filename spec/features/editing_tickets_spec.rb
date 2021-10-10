require 'rails_helper'

RSpec.feature 'Users can edit existing tickets' do
  let(:project){FactoryBot.create(:project)}
  let(:user){FactoryBot.create(:user)}
  let(:ticket){FactoryBot.create(:ticket, project: project, author: user)}

  before do
    login_as(user)
    visit project_ticket_path(project, ticket)
  end

  scenario 'with valid attributes' do
    click_link 'Edit Ticket'
    fill_in 'Name', with: 'Ruby Code'
    click_button 'Update Ticket'
    expect(page).to have_content 'Ticket has been updated.'
    within('.ticket header h2') do
      expect(page).to have_content 'Ruby Code'
      expect(page).to have_no_content ticket.name
    end
  end

  scenario 'with invalid attributes' do
    click_link 'Edit Ticket'
    fill_in 'Name', with: ""
    click_button "Update Ticket"
    expect(page).to have_content 'ticket has not been updated'
  end
end
