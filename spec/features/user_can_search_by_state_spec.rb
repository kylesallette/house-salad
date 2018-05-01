require 'rails_helper'

feature "user can search for house members" do

  scenario "user submits valid state name" do
    # As a user
    # When I visit "/"
    visit '/'

    # And I select "Colorado from the dropdown
    select "Colorado", from: :state

    # And I click on Locate Members of the house"
    VCR.use_cassette("features/user_can_search_by_state") do
      click_on "Locate Members of the House"

      # Then my path should be "/search" with "state=CO" in the params
      expect(current_path).to eq(search_path)

      # And I should see a message "7 results"
      expect(page).to have_content("7 Results")

      # And i should see name, role, party, district
      within(first(".member")) do
        expect(page).to have_css(".name")
        expect(page).to have_css(".role")
        expect(page).to have_css(".party")
        expect(page).to have_css(".district")
      end
    end
  end

end
