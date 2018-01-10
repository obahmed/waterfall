require 'test_helper'

describe Project do
	let(:bhep) {projects(:bhep)}
	describe 'validations' do
		it "is a valid project" do
			expect(bhep).must_be :valid?
		end
	end
end
