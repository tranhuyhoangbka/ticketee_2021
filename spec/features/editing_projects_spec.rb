RSpec.feature 'Users can edit existing projects' do
  let(:admin){FactoryBot.create(:user, :admin)}
  let!(:project){FactoryBot.create(:project)}

  before do
    login_as(admin)
    visit '/'
    click_link project.name
    click_link 'Edit Project'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with: 'VS Code'
    click_button 'Update Project'
    expect(page).to have_content 'Project has been updated.'
    expect(page).to have_content 'VS Code'
  end

  scenario 'when providing invalid attributes' do
    fill_in 'Name', with: ''
    click_button 'Update Project'
    expect(page).to have_content 'Project has not been updated.'
  end
end
