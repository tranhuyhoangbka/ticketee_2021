require 'rails_helper'

RSpec.feature 'Users can view projects' do
  let!(:project){FactoryBot.create(:project)}

  scenario 'with project details' do
    visit '/'
    click_link project.name
    expect(page.current_url).to eq project_url(project)
  end
end
