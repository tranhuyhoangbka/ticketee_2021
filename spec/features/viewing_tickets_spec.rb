require 'rails_helper'

RSpec.feature 'Users can view tickets' do
  let!(:project1){FactoryBot.create(:project, name: "project name 1")}
  let!(:project2){FactoryBot.create(:project, name: "project name 2")}
  let!(:author){FactoryBot.create(:user)}
  let!(:ticket1){FactoryBot.create(:ticket, project: project1, author: author, name: "ticket name 1", description: 'sample ticket desc 1')}
  let!(:ticket2){FactoryBot.create(:ticket, project: project2, author: author, name: "ticket name 2")}

  before do
    visit "/"
    click_link project1.name
  end

  scenario 'for a given project' do
    expect(page).to have_content 'ticket name 1'
    expect(page).to have_no_content 'ticket name 2'
    click_link 'ticket name 1'
    within('.ticket header h2') do
      expect(page).to have_content 'ticket name 1'
    end
    expect(page).to have_content 'sample ticket desc 1'
  end
end
