class AddUserIdToMeetups < ActiveRecord::Migration
  def self.up
    add_column :meetups, :user_id, :integer, null: false
  end
  def self.down
    remove_column :meetups, :user_id
  end
end
