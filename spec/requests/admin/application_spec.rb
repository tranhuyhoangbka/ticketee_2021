require 'rails_helper'

RSpec.describe "Admin::Applications", type: :request do
  let!(:user) { FactoryBot.create(:user, :admin) }

  before do
    login_as(user)
  end

  describe "GET /index" do
    it "returns http success" do
      get "/admin"
      expect(response).to have_http_status(:success)
    end
  end

end
