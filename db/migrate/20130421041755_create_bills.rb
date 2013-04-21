class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :amount
      t.string :description
      t.string :provider
      t.boolean :private, :default => false
      t.date :billed_on
      t.date :due_on
      t.date :period_started_on
      t.date :period_ended_on
      t.integer :household_id
      t.integer :paid_by_id # HouseholdMember ID

      t.timestamps
    end
  end
end
