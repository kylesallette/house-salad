require 'rails_helper'

describe PropublicaService do

  describe "members" do
    it "finds all CO members" do
      VCR.use_cassette("services/find_co_members") do
        members = PropublicaService.find_house_members("CO")
        member = members.first

        expect(members.count).to eq(7)
        expect(member[:name]).to eq("Diana DeGette")
        expect(member[:party]).to eq("D")
        expect(member[:district]).to eq("1")
      end
    end
  end
end
