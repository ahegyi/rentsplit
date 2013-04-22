class Bill < ActiveRecord::Base
  attr_accessible :amount, :billed_on, :description, :due_on, :period_ended_on, :period_started_on, :private, :provider

  belongs_to :household

  belongs_to :paid_by, :class_name => "HouseholdMember"
  has_many :bill_parts

  validates_presence_of :amount, :billed_on, :period_started_on, :period_ended_on, :provider, :paid_by
  validates_numericality_of :amount

  def paid_by_user?(a_user)
    self.paid_by.user.id == a_user.id
  end

end
