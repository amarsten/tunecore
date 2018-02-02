require 'rails_helper'

RSpec.describe Album, type: :model do

	describe "Associations" do
		it { should belong_to(:artist)}
	end

	describe "searching albums" do

		context "when no albums match the query" do
			it "returns no results" do
				expect(Album.search_by_name("foo").count).to eq(0)
			end
		end

		context "when only one album matches the query" do
			it "returns only that album" do
				expect(Album.search_by_name("comedy")).to include(@comedy)
				expect(Album.search_by_name("comedy").count).to eq(1)
			end
		end

		context "when the multiple albums match the query" do
			it "returns all matches" do
				expect(Album.search_by_name("r")).to_not include(@comedy)
				expect(Album.search_by_name("r").count).to eq(2)
			end
		end

		context "when the query is in the middle of a album name" do
			it "still returns the album" do
				expect(Album.search_by_name("letter")).to include(@dead_letter)
				expect(Album.search_by_name("letter").count).to eq(1)
			end
		end

	end
end