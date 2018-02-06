require 'rails_helper'

RSpec.describe Album, type: :model do

	describe "Associations" do
		it { should belong_to(:artist)}
		it { should have_many(:tracks)}
	end

end