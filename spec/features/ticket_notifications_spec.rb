require "rails_helper"

RSpec.feature "Users can receive notifications about ticket updates" do
  include ActiveJob::TestHelper

  let!(:alice) { FactoryBot.create(:user, id: 15, email: "alice@example.com") }
  let!(:bob) { FactoryBot.create(:user, id: 16, email: "bob@example.com") }
  let!(:project) { FactoryBot.create(:project) }

  let!(:ticket) do
    FactoryBot.create(:ticket, project: project, author: alice)
  end

  before do
    # ticket.watchers << alice
    login_as(bob)
    visit project_ticket_path(project, ticket)
  end

  scenario "ticket authors automatically receive notifications" do
    fill_in "Text", with: "Is it out yet?"
    click_button "Create Comment"
    # becase email sent using active job
    perform_enqueued_jobs
    # use email_spec gem
    email = find_email!(alice.email)
    expected_subject = "#{project.name} - #{ticket.name}"
    expect(email.subject).to eq expected_subject
    # click into a link in mail content with lable include text "projects"
    click_email_link_matching(/projects/, email)
    expect(current_path).to eq project_ticket_path(project, ticket)
  end

  scenario "comment authors do not receive emails" do
    fill_in "Text", with: "Is it out yet?"
    click_button "Create Comment"
    perform_enqueued_jobs
    email = find_email(bob.email)
    expect(email).to be_nil
  end

  scenario "comment authors are automatically subscribed to a ticket" do
    fill_in "Text", with: "Is it out yet?"
    click_button "Create Comment"

    perform_enqueued_jobs

    click_link "Logout"
    reset_mailer

    login_as(alice)
    visit project_ticket_path(project, ticket)
    fill_in "Text", with: "Not yet - sorry!"
    click_button "Create Comment"

    perform_enqueued_jobs

    expect(page).to have_content "Comment has been created."
    expect(unread_emails_for(bob.email).count).to eq 1
    expect(unread_emails_for(alice.email).count).to eq 0
  end
end
