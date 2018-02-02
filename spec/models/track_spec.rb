require 'rails_helper'

RSpec.describe Track, type: :model do

	describe "Associations" do
		it { should belong_to(:artist)}
		it { should belong_to(:album)}
	end

	describe "searching tracks" do

		before :each do
			@rem = Artist.create! name: "R.E.M."
			@drugdealer = Artist.create! name: "Drugdealer"
			@ramones = Artist.create! name: "Ramones"

			@dead_letter = Album.create! name: "Dead Letter Office", artist: @rem
			@comedy = Album.create! name: "The End of Comedy", artist: @drugdealer
			@rocket = Album.create! name: "Rocket to Russia", artist: @ramones

			@rockaway_theme = Track.create! name: "Far Rockaway Theme", artist: @drugdealer, album: @comedy
			@alessandro = Track.create! name: "Theme for Alessandro", artist: @drugdealer, album: @comedy

			@walter = Track.create! name: "Walter's Theme", artist: @rem, album: @dead_letter
			@femme = Track.create! name: "Femme Fatale", artist: @rem, album: @dead_letter

			@rockaway_beach = Track.create! name: "Rockaway Beach", artist: @ramones, album: @rocket
			@sheena = Track.create! name: "Sheena Is A Punk Rocker", artist: @ramones, album: @rocket
		end

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