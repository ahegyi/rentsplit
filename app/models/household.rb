class Household < ActiveRecord::Base
  attr_accessible :name

  has_many :household_members #, :bills
  has_many :users, :through => :household_members
end
