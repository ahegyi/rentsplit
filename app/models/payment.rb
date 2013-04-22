class Payment < ActiveRecord::Base
  attr_accessible :amount, :paid_on, :paid_to_id, :paid_from_id

  belongs_to :paid_to, :class_name => "HouseholdMember"
  belongs_to :paid_from, :class_name => "HouseholdMember"

  def paid?
    return !!self.paid_on
  end

end
