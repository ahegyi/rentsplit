class Household < ActiveRecord::Base
  attr_accessible :name

  has_many :household_members
  has_many :bills
  has_many :users, :through => :household_members

  def active_members
    #  self.select{ |household_member| household_member.active }
    #  self.household_members.select(&:active) # Symbol to Proc, like above
    self.household_members.where(:active => true) # fastest, not throwing away anything
  end

  def inactive_members
    self.household_members.where(:active => false)
  end

  def managers
    self.household_members.where(:manager => true)
  end

  def calculate_payments
    # add up 
    
  end

end
