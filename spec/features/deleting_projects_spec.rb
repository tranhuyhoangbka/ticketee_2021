require 'rails_helper'

RSpec.feature 'Users can delete project' do
  let(:admin){FactoryBot.create(:user, :admin)}
  let!(:project){FactoryBot.create(:project)}

  before do
    login_as(admin)
    visit '/'
    click_link project.name
  end

  scenario 'delete successfully' do
    click_link 'Delete Project'
    expect(page).to have_content 'Project has been deleted.'
    expect(page.current_url).to eq projects_url
    expect(page).to have_no_content project.name
  end
end
