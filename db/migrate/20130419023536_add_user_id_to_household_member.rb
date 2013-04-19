class AddUserIdToHouseholdMember < ActiveRecord::Migration
  def change
    add_column :household_members, :user_id, :integer
  end
end
