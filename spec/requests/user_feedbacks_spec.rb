require 'rails_helper'

RSpec.describe "UserFeedbacks", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/user_feedbacks/create"
      expect(response).to have_http_status(:success)
    end
  end

end
