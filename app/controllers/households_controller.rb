class HouseholdsController < ApplicationController
  before_filter :authenticate_user!

  # GET /households
  def home
    @households = current_user.households
  end
  
  # GET /households/new
  def new
    @household = Household.new
  end

  # POST /households
  def create
    household = Household.new
    household.name = params[:household][:name]
    household.save!

    # Since we are creating a new household, we must create a new HouseholdMember
    household_member = HouseholdMember.new
    household_member.last_entered_on = Date.today
    household_member.manager = true # the creator will always manage the household
    household_member.user = current_user
    household_member.household = household
    household_member.save!

    redirect_to user_root_path, :notice => "Household created!"
  end

  # GET /households/:id/edit
  def edit
    @household = Household.find(params[:id])
  end

  # PUT /households/:id
  def update
    @household = Household.find(params[:id])

    if @household.update_attributes(params[:household])
      redirect_to user_root_path, notice: "Household updated!"
    else
      render action: "edit"
    end

  end

end