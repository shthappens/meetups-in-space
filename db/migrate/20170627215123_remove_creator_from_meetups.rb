class RemoveCreatorFromMeetups < ActiveRecord::Migration
  def change
    remove_column :meetups, :creator
  end
end
