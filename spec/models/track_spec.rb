require 'rails_helper'

RSpec.describe Track, type: :model do

	describe "Associations" do
		it { should belong_to(:artist)}
		it { should belong_to(:album)}
	end

	describe "searching tracks" do

		context "when no tracks match the query" do
			it "returns no results" do
				expect(Track.search_by_name("foo").count).to eq(0)
			end
		end

		context "when only one track matches the query" do
			it "returns only that track" do
				expect(Track.search_by_name("sheena")).to include(@sheena)
				expect(Track.search_by_name("sheena").count).to eq(1)
			end
		end

		context "when the multiple tracks match the query" do
			it "returns all matches" do
				expect(Track.search_by_name("rockaway")).to include(@rockaway_theme)
			    expect(Track.search_by_name("rockaway")).to include(@rockaway_beach)
			    expect(Track.search_by_name("rockaway").count).to eq(2)
			end
		end

		context "when the query is in the middle of a track name" do
			it "still returns the track" do
				expect(Track.search_by_name("theme")).to include(@rockaway_theme)
			    expect(Track.search_by_name("theme")).to include(@alessandro)
				expect(Track.search_by_name("theme")).to include(@walter)
				expect(Track.search_by_name("theme").count).to eq(3)
			end
		end
	end

end