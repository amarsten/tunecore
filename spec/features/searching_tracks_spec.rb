require 'rails_helper'

RSpec.feature "Tracks can be searched", type: :feature do
	scenario "visitor finds track by filtering" do
		visit root_path

		expect(page).to have_content("Welcome to TuneCore Search")

		fill_in "name", with: "the"

		click "Search"

		expect(page).to have_content("Theme For Alessandro") 
		expect(page).to have_content("Far Rockaway Theme")
		expect(page).to have_content("Walter's Theme")
		expect(page).to have_content("Under The Pressure")

		fill_in "artist", with: "drug"

		expect(page).to have_content("Theme For Alessandro") 
		expect(page).to have_content("Far Rockaway Theme")
		expect(page).not_to have_content("Walter's Theme")
		expect(page).to have_content("Under The Pressure")

		fill_in "album", with: "comedy"

		expect(page).to have_content("Theme For Alessandro") 
		expect(page).to have_content("Far Rockaway Theme")
		expect(page).not_to have_content("Walter's Theme")
		expect(page).not_to have_content("Under The Pressure")

		fill_in "name", with: "theme for"

		expect(page).to have_content("Theme For Alessandro") 
		expect(page).not_to have_content("Far Rockaway Theme")
		expect(page).not_to have_content("Walter's Theme")
		expect(page).not_to have_content("Under The Pressure")

		fill_in "name", with: "some nonsense"

		expect(page).to have_content("No Results :(") 



	end
end