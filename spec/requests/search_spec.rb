require 'rails_helper'

RSpec.describe "Searching tracks", type: :request do
	it "returns results when all params are passed" do
		get "/tracks/search", params: {track: "alessandro", album: "the", artist: "drug"}, xhr: true
		expect(response.body).to include ("Theme For Alessandro")
	end
end