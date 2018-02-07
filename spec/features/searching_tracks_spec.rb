require 'rails_helper'

RSpec.feature "Tracks can be searched", js: true  do
	scenario "visitor finds track by filtering" do
		visit root_path

		expect(page).to have_content("Welcome to TuneCore Search")

		fill_in "name", with: "the"
		click_button "search"

		expect(page).to have_content("Theme For Alessandro") 
		expect(page).to have_content("Far Rockaway Theme")
		expect(page).to have_content("Walter's Theme")
		expect(page).to have_content("Under The Pressure")

		fill_in "artist", with: "drug"
		click_button "search"

		expect(page).to have_content("Theme For Alessandro") 
		expect(page).to have_content("Far Rockaway Theme")
		expect(page).not_to have_content("Walter's Theme")
		expect(page).to have_content("Under The Pressure")

		fill_in "album", with: "comedy"
		click_button "search"

		expect(page).to have_content("Theme For Alessandro") 
		expect(page).to have_content("Far Rockaway Theme")
		expect(page).not_to have_content("Walter's Theme")
		expect(page).not_to have_content("Under The Pressure")

		fill_in "name", with: "theme for"
		click_button "search"

		expect(page).to have_content("Theme For Alessandro") 
		expect(page).not_to have_content("Far Rockaway Theme")
		expect(page).not_to have_content("Walter's Theme")
		expect(page).not_to have_content("Under The Pressure")

		fill_in "name", with: "some nonsense"
		click_button "search"

		expect(page).to have_content("No Results :(") 



	end
end