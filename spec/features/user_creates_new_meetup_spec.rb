require 'spec_helper'

feature "User signs in" do

  let!(:user) do
    FactoryGirl.create(:user)
  end

  let!(:membership) do
    FactoryGirl.create(:membership, creator: true)
  end

  before(:each) do
    visit '/'
    sign_in_as user
  end

  scenario "user successfully signs in" do

    expect(page).to have_content "You're now signed in as #{user.username}!"
  end

  scenario "User enters new meetup details" do

    click_link('Create a new Meetup')

    new_name = 'My space meetup'

    fill_in('name', :with => new_name)
    fill_in('location', :with => 'The moon')
    fill_in('description', :with => 'A meetup to chat about space')

    click_button "Submit"

    expect(page).to have_content('Meetup Successfully Created!')
    expect(page).to have_content(new_name)

  end

  scenario "User submits an incomplete form" do

    click_link('Create a new Meetup')

    fill_in('name', :with => 'My new meetup')
    fill_in('location', :with => 'Maine')

    click_button "Submit"

    name_value = page.find('input#meetup-name-input')[:value]
    location_value = page.find('input#meetup-location-input')[:value]

    expect(name_value).to eq(' My new meetup ')
    expect(location_value).to eq(' Maine ')
    expect(page).to have_content('Description can\'t be blank')

  end
end
