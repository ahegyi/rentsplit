class User < ActiveRecord::Base
  # Include default devise modules, plus :confirmable. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :household_members
  has_many :households, :through => :household_members


  def name
    self.first_name + " " + self.last_name
  end

  def household_member_id_of(household)
    household_members = household.household_members
    user_as_household_member = household_members.detect {|h_member| h_member.user_id == self.id }

    unless user_as_household_member.nil?
      user_as_household_member.id
    else
      nil
    end
  end

  # Yes, I can refactor this to include the above method
  def is_manager_of?(household)
    household_members = household.household_members
    current_user_as_household_member = household_members.detect {|h_member| h_member.user_id == self.id }

    unless current_user_as_household_member.nil?
      current_user_as_household_member.manager
    else
      nil
    end
  end

end
