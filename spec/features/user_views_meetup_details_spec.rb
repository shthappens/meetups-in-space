require 'spec_helper'

feature "User views meetup details" do

  let!(:sht_user) do
    FactoryGirl.create(:user)
  end

  let!(:gst_user) do
    FactoryGirl.create(:user)
  end

  let!(:smt_user) do
    FactoryGirl.create(:user)
  end

  let!(:sht_meetup) do
    FactoryGirl.create(:meetup)
  end

  let!(:sht_membership) do
    FactoryGirl.create(:membership, meetup_id: sht_meetup.id, user_id: sht_user.id, creator: true)
  end

  let!(:gst_membership) do
    FactoryGirl.create(:membership, meetup_id: sht_meetup.id, user_id: gst_user.id)
  end

  let!(:smt_membership) do
    FactoryGirl.create(:membership, meetup_id: sht_meetup.id, user_id: smt_user.id)
  end

  scenario "User views details for each meetup" do
    visit "/meetups/#{sht_meetup.id}"

    expect(page).to have_content "Creator: #{sht_user.username}"
    expect(page).to have_content "Members: #{sht_user.username}"

  end
end
