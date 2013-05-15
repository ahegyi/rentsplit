require 'spec_helper'

describe Bill do

  before :all do
    @household = Household.create(:name => "Aron's Household")
    @user = User.create(:first_name => "Aron", :last_name => "Hegyi",
                    :email => "ahegyi@gmail.com", :password => "password",
                    :password_confirmation => "password"
      )

    # sets user for new household member
    @user.household_members << HouseholdMember.new(:manager => true)
    # sets household for new household member
    @user.household_members.last.household = @household
    @user.household_members.last.save
    # now let's refer to the newly created household member as an instance variable
    @household_member = @user.household_members.last

    @household_member.bills_paid << Bill.new
    @household_member.bills_paid.last.save!
    @bill = @household_member.bills_paid.last

    # TODO
    # clean test db before each rspec run
    # save proper bill attributes so it saves correctly

    puts @bill.inspect
    puts @user.inspect

  end

  it "can check if a particular user paid the bill" do
    expect(@bill.paid_by_user?(@user)).to eq true
  end

end