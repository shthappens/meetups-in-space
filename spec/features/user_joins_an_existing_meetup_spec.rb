require 'spec_helper'

feature "User joins an existing meetup" do

  let!(:test_user) do
    FactoryGirl.create(:user)
  end

  let!(:user) do
    FactoryGirl.create(:user)
  end

  let!(:user_membership) do
    FactoryGirl.create(:membership, meetup_id: meetup.id, user_id: user.id, creator: true)
  end

  let!(:meetup) do
    FactoryGirl.create(:meetup)
  end

  scenario "User unsuccessfully joins a meetup" do
    visit "/meetups/#{meetup.id}"
    click_button('Join This Meetup')

    expect(page).to have_content('Please sign in before joining a Meetup.')

  end

  scenario "User successfully joins a meetup" do
    visit '/'
    sign_in_as test_user
    visit "/meetups/#{meetup.id}"
    click_button('Join This Meetup')

    expect(page).to have_content('You successfully joined this Meetup!')
  end

end
