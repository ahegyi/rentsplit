class Payment < ActiveRecord::Base
  attr_accessible :amount, :paid_on

  belongs_to :paid_to, :class_name => "HouseholdMember"
  belongs_to :paid_from, :class_name => "HouseholdMember"

  def paid?
    return !!self.paid_on
  end

end
