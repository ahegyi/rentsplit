class HouseholdsController < ApplicationController
  before_filter :authenticate_user!

  # GET /households
  def home
    @households = current_user.households
  end
  
  # GET /households/new
  def new
    

  end

  # POST /households
  def create
    household = Household.new
    household.name = params[:name]
    household.save!

    # Since we are creating a new household, we must create a new HouseholdMember
    household_member = HouseholdMember.new
    household_member.last_entered_on = Date.today
    household_member.manager = true # the creator will always manage the household
    household_member.user = current_user
    household_member.household = household
    household_member.save!

    redirect_to user_root, :notice => "Household created!"
  end

  # GET /households/edit/:id
  def edit

  end

  # PUT /households
  def update

  end

end