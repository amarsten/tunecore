require 'rails_helper'

RSpec.describe "Visiting root", type: :request do
	it "takes you to the home page" do
		get "/"
		expect(response.body).to include ("TuneCore Search")
	end
end