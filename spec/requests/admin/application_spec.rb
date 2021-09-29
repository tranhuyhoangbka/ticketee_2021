require 'rails_helper'

RSpec.describe "Admin::Applications", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/application/index"
      expect(response).to have_http_status(:success)
    end
  end

end
