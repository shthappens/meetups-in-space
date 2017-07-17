require 'factory_girl'

FactoryGirl.define do
  factory :user do
    provider "github"
    sequence(:uid) { |n| n }
    sequence(:username) { |n| "sht#{n}" }
    sequence(:email) { |n| "sht#{n}@sht.com" }
    avatar_url "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
  end

  factory :meetup do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "Github Meetup #{n}" }
    sequence(:description) { |n| "Meetup on github #{n}" }
    location "online"
    sequence(:user_id) { |n| n }
  end


  factory :membership do
    sequence(:user_id) { |n| n }
    sequence(:meetup_id) { |n| n }
    creator false
  end


end
