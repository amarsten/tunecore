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