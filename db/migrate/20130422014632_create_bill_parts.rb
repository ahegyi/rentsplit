class CreateBillParts < ActiveRecord::Migration
  def change
    create_table :bill_parts do |t|
      t.integer :amount
      t.integer :bill_id
      t.integer :owed_by_id # HouseholdMember ID

      t.timestamps
    end
  end
end
