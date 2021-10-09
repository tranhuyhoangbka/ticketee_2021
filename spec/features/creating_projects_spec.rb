require 'rails_helper'

RSpec.feature 'Users can create new projects' do
  let(:admin) {FactoryBot.create(:user, :admin)}

  before do
    login_as(admin)
    visit '/'
    click_link 'New Project'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with: 'first project'
    fill_in 'Description', with: 'sample'
    click_button 'Create Project'

    expect(page).to have_content 'Project has been created.'

    project = Project.find_by(name: 'first project')
    expect(page.current_url).to eq project_url(project)
    expect(page).to have_title "first project - Projects - Ticketee"
  end

  scenario 'when providing invalid attributes' do
    click_button 'Create Project'
    expect(page).to have_content 'Project has not been created.'
    expect(page).to have_content "Name can't be blank"
  end
end
