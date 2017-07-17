require 'spec_helper'

feature "User sees list of members in the meetup" do

  let!(:user_1) do
    FactoryGirl.create(:user)
  end

  let!(:user_2) do
    FactoryGirl.create(:user)
  end

  let!(:meetup) do
    FactoryGirl.create(:meetup)
  end

  let!(:user_1_membership) do
    FactoryGirl.create(:membership, meetup_id: meetup.id, user_id: user_1.id, creator: true)
  end

  let!(:user_2_membership) do
    FactoryGirl.create(:membership, meetup_id: meetup.id, user_id: user_2.id)
  end

  scenario "User sees a list of members with name and avatar" do
    visit "/meetups/#{meetup.id}"

    expect(page).to have_content(user_1.username)
    expect(page).to have_content(user_2.username)
    expect(page).to have_css('img')
  end

end
