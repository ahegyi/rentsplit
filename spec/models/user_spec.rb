require 'spec_helper'

describe User do

  before :all do

    @household = Household.create(:name => "Aron's Household")
    @user = User.create(:first_name => "Aron", :last_name => "Hegyi",
                    :email => "ahegyi@gmail.com", :password => "password",
                    :password_confirmation => "password"
      )
    @user2 = User.create(:first_name => "Erik", :last_name => "Michaels-Ober",
                    :email => "ahegyi+erik@gmail.com", :password => "password",
                    :password_confirmation => "password"
      )

    # sets user for new household member
    @user.household_members << HouseholdMember.new(:manager => true)
    # sets household for new household member
    @user.household_members.last.household = @household
    @user.household_members.last.save
    # now let's refer to the newly created household member as an instance variable
    @household_member = @user.household_members.last

    # sets user for new household member
    @user2.household_members << HouseholdMember.new(:manager => false)
    # sets household for new household member
    @user2.household_members.last.household = @household
    @user2.household_members.last.save
    # now let's refer to the newly created household member as an instance variable
    @household_member2 = @user2.household_members.last

  end

  it "has a first_name" do
    expect(@user.first_name).to eq "Aron"
  end

  it "has a last_name" do
    expect(@user.last_name).to eq "Hegyi"
  end

  it "has a full name" do
    expect(@user.name).to eq "Aron Hegyi"
  end

  it "has an e-mail address" do
    expect(@user.email).to eq "ahegyi@gmail.com"
  end

  it "has a household member id in the context of a particular household" do
    expect(@user.household_member_id_of(@household)).to eq @household_member.id
  end

  it "is present in many different households" do
    expect(@user.household_members).to be_an Array
    expect(@user.households).to be_an Array
  end

  it "has the ability to check whether it's a manager of a particular household" do
    expect(@user.is_manager_of?(@household)).to be_true
    expect(@user2.is_manager_of?(@household)).to be_false
  end

end