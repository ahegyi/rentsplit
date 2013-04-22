class HouseholdMember < ActiveRecord::Base
  attr_accessible :active, :last_entered_on, :last_exited_on, :manager

  belongs_to :household
  belongs_to :user

  has_many :bills_paid, :class_name => "Bill", :foreign_key => "paid_by_id"
  has_many :bill_parts_owed, :class_name => "BillPart", :foreign_key => "owed_by_id"
  
  has_many :payments_received, :class_name => "Payment", :foreign_key => "paid_to_id"
  has_many :payments_sent, :class_name => "Payment", :foreign_key => "paid_from_id"
  
  def active?
    active
  end  

  #  alias_method :active?, :active # This shit is weird, will alias to the active class variable

  
end
