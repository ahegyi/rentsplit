class BillPart < ActiveRecord::Base
  attr_accessible :amount

  belongs_to :bill
  belongs_to :owed_by, :class_name => "HouseholdMember"
end
