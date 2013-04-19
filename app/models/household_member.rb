class HouseholdMember < ActiveRecord::Base
  attr_accessible :active, :last_entered_on, :last_exited_on, :manager
end
