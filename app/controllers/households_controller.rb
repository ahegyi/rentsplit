class HouseholdsController < ApplicationController
  before_filter :authenticate_user!, :get_current_household, :except => [:index, :new, :create] #, :authorize_user_for_household #TODO!!! :only => [:edit, :destroy, :show, :update, :show_members, :new_member, :create_members, :update_members, :destroy_household_member]

  # GET /households
  def index
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

    redirect_to user_root_url, :notice => "Household created!"
  end

  # GET /households/:id/edit
  def edit
    @household = Household.find(params[:id])
  end

  # DELETE /households/:id
  def destroy
    @household = Household.find(params[:id])
    @household.destroy

    redirect_to households_url
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


  # GET /households/:id/members
  def show_members
    @household = Household.find(params[:id])
    @active_members = @household.active_members
    @inactive_members = @household.inactive_members

  end

  # GET /households/:id/members/new
  def new_member
    @household = Household.find(params[:id])
    @household_member = HouseholdMember.new
    @household_member.household_id = @household.id
    @household_member.user_id = current_user.id
  end

  # POST /households/:id/members
  def create_members
    @household = Household.find(params[:id])
    @household_member = HouseholdMember.new

    new_member = User.where(:email => params[:email]).first
    if new_member.nil?
      redirect_to household_members_url(@household.id), alert: "The email #{params[:email]} doesn't exist in our system! Please tell them to sign up."
    else
      if HouseholdMember.where(:user_id => new_member.id, :household_id => @household.id).empty?
        @household_member.user_id = new_member.id
        @household_member.household_id = @household.id
        @household_member.last_entered_on = Date.today
        @household_member.save!
        redirect_to household_members_url(@household.id), notice: "The email #{params[:email]} has been added to #{@household.name}!"
      else
        redirect_to household_members_url(@household.id), alert: "The email #{params[:email]} (#{new_member.name}) is already in this household!"
      end
    end

  end

  # PUT /households/:household_id/members/:household_member_id/:update_action
  # I would probably just do this:
  # PUT /household_members/:id # {:active => true}
  # <3 EMO
  def update_members
    @household = Household.find(params[:household_id])
    @household_member = HouseholdMember.find(params[:household_member_id])

    case params[:update_action]
    when "remove"
      @household_member.active = false
      @household_member.last_exited_on = Date.today
      @household_member.save!
    when "reactivate"
      @household_member.active = true
      @household_member.last_entered_on = Date.today
      @household_member.save!
    end

    redirect_to household_members_url(@household)
  end

  # DELETE /households/:household_id/members/:household_member_id
  def destroy_household_member
    household_member = HouseholdMember.find(params[:household_member_id])
    household_member.destroy

    redirect_to household_members_url(params[:household_id])
  end

  private

  def get_current_household
    # Is there a better way!?!?
    @current_household_id = (params[:household_id] || params[:id]).to_i
    @current_household = Household.find(@current_household_id)
  end

  # end
  # TODO!!!
  # Make sure that the current user is in the household!
  # def authorize_user_for_household
  #   # only check on individual households
  #   current_household_id = params[:id] || params[:household_id]

  #   if current_household_id.nil?
  #     return
  #   else
  #     current_household = Household.find(current_household_id)
  #     if current_household.nil?
  #       return
  #     else
  #       authorized = false
  #       current_household_members = current_household.household_members
  #       current_user.household_members.each do |user_member|
  #         if current_household_members.include?(user_member)
  #           authorized = true
  #         else
  #           redirect_to households_url, :alert => "You are not allowed to see that!"
  #         end
  #       end
  #     end
  #   end

  # end

end