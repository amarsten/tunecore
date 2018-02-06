require 'rails_helper'

RSpec.describe Track, type: :model do

	before :suite do
		@rem = Artist.create! name: "R.E.M."
	    @drugdealer = Artist.create! name: "Drugdealer"
	    @ramones = Artist.create! name: "The Ramones"
	    @war_on_drugs = Artist.create! name: "The War On Drugs"

	    @dead_letter = Album.create! name: "Dead Letter Office", artist: @rem
	    @comedy = Album.create! name: "The End of Comedy", artist: @drugdealer
	    @rocket = Album.create! name: "Rocket to Russia", artist: @ramones
	    @dream = Album.create! name: "Lost In The Dream", artist: @war_on_drugs

	    @rockaway_theme = Track.create! name: "Far Rockaway Theme", artist: @drugdealer, album: @comedy
	    @alessandro = Track.create! name: "Theme for Alessandro", artist: @drugdealer, album: @comedy

	    @walter = Track.create! name: "Walter's Theme", artist: @rem, album: @dead_letter
	    @femme = Track.create! name: "Femme Fatale", artist: @rem, album: @dead_letter

	    @rockaway_beach = Track.create! name: "Rockaway Beach", artist: @ramones, album: @rocket
	    @sheena = Track.create! name: "Sheena Is A Punk Rocker", artist: @ramones, album: @rocket
	    @dance = Track.create! name: "Do You Wanna Dance?", artist: @ramones, album: @rocket

	    @red_eyes = Track.create! name: "Red Eyes", artist: @war_on_drugs, album: @dream
	    @pressure = Track.create! name: "Under The Pressure", artist: @war_on_drugs, album: @dream
	end

	describe "Associations" do
		it { should belong_to(:artist)}
		it { should belong_to(:album)}
	end

	describe "#search" do
		subject { described_class.search(**arguments)}

		context "when only name is passed" do
			let(:arguments) { {name: "rockaway", album: nil, artist: nil} }

			it "returns only tracks with matching names" do
				is_expected.to match_array([@rockaway_beach, @rockaway_theme])
			end

		end

		context "when only album is passed" do
			let(:arguments) { {name: nil, album: "the", artist: nil} }

			it "returns all track with matching albums" do
				is_expected.to match_array([@rockaway_theme, @alessandro, @red_eyes, @pressure])
			end
		end

		context "when only artist is passed" do 
			let(:arguments) { {name: nil, album: nil, artist: "the"} }

			it "returns all tracks with matching artist" do
				is_expected.to match_array([@dance, @rockaway_beach, @sheena, @red_eyes, @pressure])
			end
		end

		context "when only name and album are passed" do
			let(:arguments) { {name: "under", album: "the", artist: nil} }

			it "returns only tracks that match both" do
				is_expected.to match_array([@pressure])
			end
		end

		context "when only name and artist are passed" do
			let(:arguments) { {name: "theme", album: nil, artist: "drugdealer"} }

			it "returns only tracks that match both" do
				is_expected.to match_array([@alessandro, @rockaway_theme])
			end
		end

		context "when only artist and album are passed" do
			let(:arguments) { {name: nil, album: "lost", artist: "the"} }

			it "returns only tracks that match both" do
				is_expected.to match_array([@red_eyes, @pressure])
			end
		end

		context "when all arguments are present" do
			let(:arguments) { {name: "red", album: "lost", artist: "war"} }

			it "returns only tracks that match all three" do
				is_expected.to match_array([@red_eyes])
			end
		end

		context "when there are multiple matches" do
			let(:arguments) { {name: "theme", album: "d", artist: "r"} }

			it "orders the results by relevance" do
				is_expected.to eq([@walter, @rockaway_theme, @alessandro])
			end			
		end


		context "when there are no matches" do
			let(:arguments) { {name: "blue", album: "lost", artist: "war"} }

			it "returns no results" do
				is_expected.to be_empty
			end
		end

	end

end