require 'rails_helper'

RSpec.feature 'Users can delete tickets' do
  let(:project){FactoryBot.create(:project)}
  let(:user){FactoryBot.create(:user)}
  let(:ticket){FactoryBot.create(:ticket, project: project, author: user)}

  before do
    login_as user
    visit project_ticket_path(project, ticket)
  end

  scenario 'delete success' do
    click_link 'Delete Ticket'
    expect(page).to have_content 'Ticket has been deleted.'
    expect(page.current_url).to eq project_url(project)
    expect(page).not_to have_content ticket.name
  end
end
