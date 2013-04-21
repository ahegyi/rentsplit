class Bill < ActiveRecord::Base
  attr_accessible :amount, :billed_on, :description, :due_on, :period_ended_on, :period_started_on, :private, :provider

  belongs_to :household

  belongs_to :paid_by, :class_name => "HouseholdMember"
  has_many :bill_parts
end
