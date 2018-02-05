require 'rails_helper'

RSpec.describe Artist, type: :model do

	describe "Associations" do
		it { should have_many(:albums)}
		it { should have_many(:tracks)}
	end

end