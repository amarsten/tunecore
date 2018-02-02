require 'rails_helper'

RSpec.describe Artist, type: :model do

	describe "Associations" do
		it { should have_many(:albums)}
		it { should have_many(:tracks)}
	end

	describe "searching artists" do

		context "when no artists match the query" do
			it "returns no results" do
				expect(Artist.search_by_name("foo").count).to eq(0)
			end
		end

		context "when only one artist matches the query" do
			it "returns only that artist" do
				expect(Artist.search_by_name("Ra")).to include(@ramones)
				expect(Artist.search_by_name("Ra").count).to eq(1)
			end
		end

		context "when the multiple artists match the query" do
			it "returns all matches" do
				expect(Artist.search_by_name("m")).to_not include(@drugdealer)
				expect(Artist.search_by_name("m").count).to eq(2)
			end
		end

		context "when the query is in the middle of a artist name" do
			it "still returns the artist" do
				expect(Artist.search_by_name("dealer")).to include(@drugdealer)
				expect(Artist.search_by_name("dealer").count).to eq(1)
			end
		end
	end

end