class CreateHouseholdMembers < ActiveRecord::Migration
  def change
    create_table :household_members do |t|
      t.date :last_entered_on
      t.date :last_exited_on
      t.boolean :active, :default => true
      t.boolean :manager, :default => false

      t.timestamps
    end
  end
end
