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

  has_many :household_members #, :bill_parts
  has_many :households, :through => :household_members

end
