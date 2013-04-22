class BillsController < ApplicationController
  before_filter :authenticate_user!, :get_current_household

  # GET /households/:household_id/bills as household_bills
  def index
    @bills = @current_household.bills.order("billed_on DESC") # show new bills first
  end

  # GET /households/:household_id/bills/new as new_household_bill
  def new
    @bill = Bill.new
  end

  # POST /households/:household_id/bills
  def create
    @bill = Bill.new(params[:bill])
    @bill.household = @current_household
    @bill.paid_by = HouseholdMember.find(current_user.household_member_id_of(@current_household))

    # Add dates here!!

    if @bill.save
      # if this is outside the if save statement, it may not save and it will update the amount anyway
      # We must always store amount as an integer behind the scenes!
      @bill.amount = (100 * params[:bill][:amount].to_f).to_i
      @bill.save

      # Update Bill Parts equally among household members
      # TODO let users edit distribution

      household_members_count = @current_household.household_members.count
      amount_in_integer = @bill.amount.to_i

      payable_per_member = amount_in_integer / household_members_count
      payable_leftover = amount_in_integer % household_members_count

      @current_household.household_members.each do |member|
        bill_part = BillPart.new
        bill_part.amount = payable_per_member
        bill_part.owed_by = member
        bill_part.save!
        @bill.bill_parts << bill_part
        @bill.save!
        bill_part.save! # is this extra save necessary?
      end

      # if there is an amount leftover, add it to a random person in the house
      if payable_leftover > 0
        lucky_guy = @current_household.household_members.sample
        lucky_guys_bill_part = @bill.bill_parts.where(:owed_by_id => lucky_guy.id).first
        lucky_guys_bill_part.amount += payable_leftover
        lucky_guys_bill_part.save!
      end

      redirect_to household_bill_url(@current_household_id, @bill), notice: "Bill for #{@bill.provider} was successfully added."
    else
      render action: "new"
    end

  end

  # GET /households/:household_id/bills/:id as household_bill
  def show
    @bill = Bill.find(params[:id])


  end
  
  # DELETE /households/:household_id/bills/:id
  def destroy
    @bill = Bill.find(params[:id])
    
    # Sanity check
    if @bill.paid_by_user?(current_user)
      @bill.bill_parts.each do |bill_part|
        bill_part.destroy
      end
      @bill.destroy
      redirect_to household_bills_url(params[:household_id]), :notice => "Bill for #{@bill.provider} has been permanently deleted."
    else
      redirect_to household_bills_url(params[:household_id]), :alert => "You cannot delete a bill you did not pay. Talk to your fellow residents and see what's up!"
    end

  end

  private
  
  def get_current_household
    @current_household_id = params[:household_id].to_i
    @current_household = Household.find(@current_household_id)
  end

end
