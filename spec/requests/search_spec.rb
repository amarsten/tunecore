require 'rails_helper'

RSpec.describe "Searching tracks", type: :request do
	it "returns results when all params are passed" do
		get "/tracks/search", params: {name: "alessandro", album: "the", artist: "drug"}, xhr: true
		expect(response.body).to include ("Theme For Alessandro")
	end

	it "returns results when track and album are passed" do
		get "/tracks/search", params: {name: "red", album: "lost"} , xhr: true
		expect(response.body).to include ("Red Eyes")
	end

	it "returns results when track and artist are passed" do
		get "/tracks/search", params: {name: "sheena", artist: "ramones"}, xhr: true
		expect(response.body).to include ("Sheena Is A Punk Rocker")
	end

	it "returns results when album and artist are passed" do
		get "/tracks/search", params: {album: "lost", artist: "drug"}, xhr: true
		expect(response.body).to include ("Red Eyes")
		expect(response.body).to include ("Under The Pressure")
	end

	it "returns results when only track is passed" do
		get "/tracks/search", params: {name: "Rockaway Beach"}, xhr: true
		expect(response.body).to include ("Rockaway Beach")
	end

	it "returns results when only album is passed" do
		get "/tracks/search", params: {album: "dream"}, xhr: true
		expect(response.body).to include ("Red Eyes")
		expect(response.body).to include ("Under The Pressure")
	end

	it "returns results when only artist is passed" do
		get "/tracks/search", params: {artist: "drugdealer"}, xhr: true
		expect(response.body).to include ("Theme For Alessandro")
		expect(response.body).to include ("Far Rockaway Theme")
	end
end