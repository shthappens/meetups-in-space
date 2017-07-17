class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |table|
      table.string :user_id, null: false
      table.string :meetup_id, null: false

      table.timestamps null: false
    end
  end
end
