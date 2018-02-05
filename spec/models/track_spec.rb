require 'rails_helper'

RSpec.describe Track, type: :model do

	describe "Associations" do
		it { should belong_to(:artist)}
		it { should belong_to(:album)}
	end

	describe "searching tracks" do

		context "when nothing matches the query" do
			it "returns no results" do
				expect(Track.find_by_string("foo").count).to eq(0)
			end
		end

		context "when only one track matches the query" do
			it "returns only that track" do
				results = Track.find_by_string("sheena")
				expect(results).to include(@sheena)
				expect(results.count).to eq(1)
			end
		end

		context "when the multiple tracks match the query" do
			it "returns all matches" do
				results = Track.find_by_string("rockaway")
				expect(results).to include(@rockaway_theme)
			    expect(results).to include(@rockaway_beach)
			    expect(results.count).to eq(2)
			end
		end

		context "when the query is in the middle of a track name" do
			it "still returns the track" do
				results = Track.find_by_string("theme")
				expect(results).to include(@rockaway_theme)
			    expect(results).to include(@alessandro)
				expect(results).to include(@walter)
				expect(results.count).to eq(3)
			end
		end

		context "when the query matches an album name" do
			it "returns all tracks associated with that album" do
				results = Track.find_by_string("rocket")
				expect(results).to include(@rockaway_beach)
			    expect(results).to include(@sheena)
			    expect(results).to include(@dance)
				expect(results.count).to eq(3)
			end
		end

		context "when the query is in the artist name" do
			it "returns all tracks associated with that artist" do
				results = Track.find_by_string("drug")
				expect(results).to include(@rockaway_theme)
			    expect(results).to include(@alessandro)
				expect(results.count).to eq(2)
			end
		end

		context "when the query matches track, album, and artist names" do
			it "returns all tracks with matching names, albums, or artists" do
				results = Track.find_by_string("d")
				expect(results).to_not include(@rockaway_beach)
			    expect(results).to_not include(@sheena)
				expect(results.count).to eq(5)
			end
		end

	end

end