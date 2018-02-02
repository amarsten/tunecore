require 'rails_helper'

RSpec.describe Artist, type: :model do

	describe "Associations" do
		it { should have_many(:albums)}
		it { should have_many(:tracks)}
	end

	describe "searching artists" do

		before :each do
			@black_marble = Artist.create! name: "Black Marble"
			@black_sabbath = Artist.create! name: "Black Sabbath"
			@black_moth = Artist.create! name: "Black Moth Super Rainbow"
			@mission_of_burma = Artist.create! name: "Mission of Burma"
		end

		context "when no artists match the query" do
			it "returns no results" do
				expect(Artist.search_by_name("foo").count).to eq(0)
			end
		end

		context "when only one artist matches the query" do
			it "returns only that artist" do
				expect(Artist.search_by_name("black moth")).to include(@black_moth)
				expect(Artist.search_by_name("black moth").count).to eq(1)

				expect(Artist.search_by_name("marble")).to include(@black_marble)
				expect(Artist.search_by_name("marble").count).to eq(1)
			end
		end

		context "when the multiple artists match the query" do
			it "returns all matches" do
				expect(Artist.search_by_name("black")).to_not include(@mission_of_burma)
				expect(Artist.search_by_name("black").count).to eq(3)
			end
		end

		context "when the query is in the middle of a artist name" do
			it "still returns the artist" do
				expect(Artist.search_by_name("moth")).to include(@black_moth)
				expect(Artist.search_by_name("moth").count).to eq(1)
			end
		end
	end

end