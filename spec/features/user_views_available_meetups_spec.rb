require 'spec_helper'

feature "User sees a list of all available meetups" do

  let!(:sht) do
    FactoryGirl.create(:user)
  end

  let!(:github_meetup) do
    Meetup.create({
      name: "Github Meetup",
      description: "Meetup on github",
      location: "online",
      user_id: sht.id
      })
    # FactoryGirl.create(:meetup, user: sht)
  end

  let!(:space_meetup) do
    Meetup.create({
      name: "Space Meetup",
      description: "Meet up in space",
      location: "Milky Way",
      user_id: sht.id
      })
  end

  let!(:github_meetup_members) do
    Membership.create({
      user_id: sht.id,
      meetup_id: github_meetup.id,
      creator: true
      })
  end

  let!(:space_meetup_member) do
    Membership.create({
      user_id: sht.id,
      meetup_id: space_meetup.id,
      creator: true
      })
  end

  scenario "user views available meetups" do
    visit '/meetups'

    expect(page).to have_content "Github Meetup"
    expect(page).to have_content "Space Meetup"
  end
end
