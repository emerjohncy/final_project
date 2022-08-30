require 'rails_helper'

RSpec.describe "Bids", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/bid/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/bid/show"
      expect(response).to have_http_status(:success)
    end
  end

end
