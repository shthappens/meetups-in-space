class AddCreatorToMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :creator, :boolean, default: false
  end
  def self.down
    remove_column :memberships, :creator
  end
end
