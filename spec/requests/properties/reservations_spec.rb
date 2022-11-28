require "rails_helper"

RSpec.describe "Properties::Reservations", type: :request do
  let(:property) { create(:property)}
  let(:user) { create(:user)}
  before { sign_in user }
  describe "GET /new" do
    it "succeeds" do
      get new_property_reservation_path(property, params: {
        checkin_date: "06/01/2040",
        checkout_date: "06/12/2040"
      })
      expect(response).to be_successful
    end
  end
end