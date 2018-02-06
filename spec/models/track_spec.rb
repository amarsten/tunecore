require 'rails_helper'

RSpec.describe Track, type: :model do

	describe "Associations" do
		it { should belong_to(:artist)}
		it { should belong_to(:album)}
	end

	describe "#search" do
		subject { described_class.search(**arguments)}

		context "when only name is passed" do
			let(:arguments) { {name: "rockaway", album: nil, artist: nil} }

			it "returns only tracks with matching names" do
				is_expected.to contain_exactly(@rockaway_theme, @rockaway_beach)
			end

		end

		context "when only album is passed" do
			let(:arguments) { {name: nil, album: "the", artist: nil} }

			it "returns all track with matching albums" do
				is_expected.to contain_exactly(@rockaway_theme, @alessandro, @red_eyes, @pressure)
			end
		end

		context "when only artist is passed" do 
			let(:arguments) { {name: nil, album: nil, artist: "the"} }

			it "returns all tracks with matching artist" do
				is_expected.to contain_exactly(@rockaway_beach, @sheena, @dance, @red_eyes, @pressure)
			end
		end

		context "when only name and album are passed" do
			let(:arguments) { {name: "under", album: "the", artist: nil} }
			# it "returns no results if nothing matches" do
			# 	expect(Track.search(name: "foo", album: "foo").count).to eq(0)
			# end

			# it "returns no results if nothing matches track" do
			# 	expect(Track.search(name: "foo", album: "the end").count).to eq(0)
			# end

			# it "returns no results if nothing matches album" do
			# 	expect(Track.search(name: "theme", album: "foo").count).to eq(0)
			# end

			# it "returns one track if one match" do
			# 	results = Track.search(name: "rockaway", album: "rocket")
			# 	expect(results).to include(@rockaway_beach)
			# 	expect(results.count).to eq(1)
			# end

			it "returns only tracks that match both" do
				is_expected.to contain_exactly(@pressure)
			end
		end

		context "when only name and artist are passed" do
			let(:arguments) { {name: "theme", album: nil, artist: "drugdealer"} }
			# it "returns no results if nothing matches either" do
			# 	expect(Track.search(name: "foo", artist: "foo").count).to eq(0)
			# end

			# it "returns no results if nothing matches track" do
			# 	expect(Track.search(name: "foo", artist: "ramones").count).to eq(0)
			# end

			# it "returns no results if nothing matches artist" do
			# 	expect(Track.search(name: "Theme", artist: "foo").count).to eq(0)
			# end

			# it "returns one track if one match" do
			# 	results = Track.search(name: "theme for", artist: "drug")
			# 	expect(results).to include(@alessandro)
			# 	expect(results.count).to eq(1)
			# end

			it "returns only tracks that match both" do
				is_expected.to contain_exactly(@rockaway_theme)
			end
		end

		context "when only artist and album are passed" do
			let(:arguments) { {name: nil, album: "lost", artist: "the"} }
			# it "returns no results if nothing matches" do
			# 	expect(Track.search(album: "foo", artist: "foo").count).to eq(0)
			# end

			# it "returns no results if nothing matches album" do
			# 	expect(Track.search(album: "foo", artist: "ramones").count).to eq(0)
			# end

			# it "returns no results if nothing matches artist" do
			# 	expect(Track.search(album: "dead letter", artist: "foo").count).to eq(0)
			# end

			# it "returns one track if one match" do
			# 	results = Track.search(name: "r", album: "r")
			# 	expect(results).to include(@rockaway_beach)
			# 	expect(results.count).to eq(1)
			# end

			it "returns only tracks that match both" do
				is_expected.to contain_exactly(@red_eyes, @pressure)
			end
		end

		context "when all arguments are present" do
			let(:arguments) { {name: "red", album: "lost", artist: "war"} }
			# it "returns no results if nothing matches" do
			# 	expect(Track.search(name: "foo" , album: "foo", artist: "foo").count).to eq(0)
			# end

			# it "returns no results if nothing matches track" do
			# 	expect(Track.search(name: "foo", album: "rocket", artist: "ramones").count).to eq(0)
			# end

			# it "returns no results if nothing matches album" do
			# 	expect(Track.search(name: "femme", album: "foo", artist: "r.e.m.").count).to eq(0)
			# end

			# it "returns no results if nothing matches artist" do
			# 	expect(Track.search(track: "walter" , album: "dead letter", artist: "foo").count).to eq(0)
			# end

			# it "returns one track if one match" do
			# 	results = Track.search(name: "r", album: "r", artist: "r")
			# 	expect(results).to include(@rockaway_beach)
			# 	expect(results.count).to eq(1)
			# end

			it "returns only tracks that match all three" do
				is_expected.to contain_exactly(@red_eyes)
			end
		end

		# context "no arguments" do
		# end

		# context "no matches" do
		# end

	end

end