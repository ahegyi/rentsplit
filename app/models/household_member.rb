class HouseholdMember < ActiveRecord::Base
  attr_accessible :active, :last_entered_on, :last_exited_on, :manager

  belongs_to :household
  belongs_to :user

  def active?
    active
  end  

  #  alias_method :active?, :active # This shit is weird, will alias to the active class variable

end
