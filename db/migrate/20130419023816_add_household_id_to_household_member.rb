class AddHouseholdIdToHouseholdMember < ActiveRecord::Migration
  def change
    add_column :household_members, :household_id, :integer
  end
end
