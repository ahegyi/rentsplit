class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount, :null => false, :default => 0
      t.date :paid_on
      t.integer :paid_to_id # HouseholdMember ID
      t.integer :paid_from_id # HouseholdMember ID

      t.timestamps
    end
  end
end
