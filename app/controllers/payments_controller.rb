class PaymentsController < ApplicationController
  before_filter :authenticate_user!, :get_current_household
  before_filter :calculate_payments

  # GET /households/:household_id/payments as household_payments
  def index
    @household_members = @current_household.household_members
    @payments_to_pay.sort_by{|payment| payment.amount }.reverse!


    # @payments = Payment.all
  end

  # POST /households/:household_id/calculate_payments as calculate_payments

  def calculate_payments
    @payments_to_pay = []
    @members = Hash.new
    @members_who_are_owed_money = {}
    @members_who_owe_money = {}
    @household_members = @current_household.household_members
    # total_for_household = @current_household.bill_total

    @household_members.each do |member|      
      # @members[member.id] = Hash.new
      # @members[member.id][:member_object] = member
      # @members[member.id][:amount_paid_to_household] = member.amount_paid_to_household
      # @members[member.id][:amount_owed_to_household] = member.amount_owed_to_household
      # @members[member.id][:net_owed_to_household] = member.net_owed_to_household
      if member.net_owed_to_household < 0
        @members_who_owe_money[member.id] = Hash.new
        @members_who_owe_money[member.id][:member_object] = member
        @members_who_owe_money[member.id][:net_owed_to_household] = member.net_owed_to_household
      else
        @members_who_are_owed_money[member.id] = Hash.new
        @members_who_are_owed_money[member.id][:member_object] = member
        @members_who_are_owed_money[member.id][:net_owed_to_household] = member.net_owed_to_household
      end
    end

    # highest to lowest
    @members_who_are_owed_money.sort_by{|id, m| m[:net_owed_to_household]}.reverse.each do |id_owed, member_owed|
      # "lowest" negative amount to highest negative amount
      @members_who_owe_money.sort_by{|id, m| m[:net_owed_to_household]}.reverse.each do |id_who_owes, member_who_owes|
        # if member_owed[:net_owed_to_household] == -1 * (member_who_owes[:net_owed_to_household])
        #   p = Payment.create(:paid_to_id => id_owed, :paid_from_id => id_who_owes, :amount => member_owed[:net_owed_to_household])
        #   @payments_to_pay.push(p)
        #   member_owed[:net_owed_to_household] = 0
        #   member_who_owes[:net_owed_to_household] = 0
        # elsif member_owed[:net_owed_to_household] > -1 * (member_who_owes[:net_owed_to_household])
        #   p = Payment.create(:paid_to_id => id_owed, :paid_from_id => id_who_owes, :amount => (-1 * member_who_owes[:net_owed_to_household]))
        #   @payments_to_pay.push(p)
        #   member_owed[:net_owed_to_household] -= (-1 * member_who_owes[:net_owed_to_household])
        #   member_who_owes[:net_owed_to_household] += member_owed[:net_owed_to_household]
        # elsif member_owed[:net_owed_to_household] < -1 * (member_who_owes[:net_owed_to_household])
        #   p = Payment.create(:paid_to_id => id_who_owes, :paid_from_id => id_owed, :amount => member_owed[:net_owed_to_household])
        #   @payments_to_pay.push(p)
        #   member_owed[:net_owed_to_household] -= (-1 * member_who_owes[:net_owed_to_household])
        #   member_who_owes[:net_owed_to_household] += member_owed[:net_owed_to_household]
        # end
        if member_owed[:net_owed_to_household] == -1 * (member_who_owes[:net_owed_to_household])
          p = Payment.create(:paid_to_id => id_owed, :paid_from_id => id_who_owes, :amount => member_owed[:net_owed_to_household])
          @payments_to_pay.push(p)
          member_owed[:net_owed_to_household] = 0
          member_who_owes[:net_owed_to_household] = 0
        elsif member_owed[:net_owed_to_household] > -1 * (member_who_owes[:net_owed_to_household])
          p = Payment.create(:paid_to_id => id_who_owes, :paid_from_id => id_owed, :amount => (-1 * member_who_owes[:net_owed_to_household]))
          @payments_to_pay.push(p)
          member_owed[:net_owed_to_household] -= (-1 * member_who_owes[:net_owed_to_household])
          member_who_owes[:net_owed_to_household] += member_owed[:net_owed_to_household]
        elsif member_owed[:net_owed_to_household] < -1 * (member_who_owes[:net_owed_to_household])
          p = Payment.create(:paid_to_id => id_owed, :paid_from_id => id_who_owes, :amount => member_owed[:net_owed_to_household])
          @payments_to_pay.push(p)
          member_owed[:net_owed_to_household] -= (-1 * member_who_owes[:net_owed_to_household])
          member_who_owes[:net_owed_to_household] += member_owed[:net_owed_to_household]
        end

      end

    end

    # redirect_to household_payments_url(@current_household_id)
  end

  private

  def get_current_household
    @current_household_id = params[:household_id].to_i
    @current_household = Household.find(@current_household_id)
  end

end
