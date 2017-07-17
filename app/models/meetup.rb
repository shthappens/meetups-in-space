class Meetup < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  validates :name, :location, :description, presence: true
end
