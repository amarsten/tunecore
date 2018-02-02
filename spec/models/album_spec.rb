require 'rails_helper'

RSpec.describe Album, type: :model do

	describe "Associations" do
		it { should belong_to(:artist)}
	end

	describe "searching albums" do

		before :each do
			@built = Artist.create name: "Built to Spill"
			@peyroux = Artist.create name: "Madeleine Peyroux"
			@pavement = Artist.create name: "Pavement"
			@from_now_on = Album.create! name: "Perfect From Now On", artist: @built
			@world = Album.create! name: "Half the Perfect World", artist: @peyroux
			@slanted = Album.create! name: "Slanted & Enchanted", artist: @pavement
		end

		context "when no albums match the query" do
			it "returns no results" do
				expect(Album.search_by_name("foo").count).to eq(0)
			end
		end

		context "when only one album matches the query" do
			it "returns only that album" do
				expect(Album.search_by_name("slanted")).to include(@slanted)
				expect(Album.search_by_name("slanted").count).to eq(1)

				expect(Album.search_by_name("perfect world")).to include(@world)
				expect(Album.search_by_name("perfect world").count).to eq(1)
			end
		end

		context "when the multiple albums match the query" do
			it "returns all matches" do
				expect(Album.search_by_name("perfect")).to_not include(@slanted)
				expect(Album.search_by_name("perfect").count).to eq(2)
			end
		end

		context "when the query is in the middle of a album name" do
			it "still returns the album" do
				expect(Album.search_by_name("from now")).to include(@from_now_on)
				expect(Album.search_by_name("from now").count).to eq(1)
			end
		end

	end
end