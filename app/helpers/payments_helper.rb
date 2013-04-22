module PaymentsHelper

  def build_venmo_link(household_member, integer_amount)
    email = URI.escape(household_member.user.email)
    amount = URI.escape(integer_to_currency(integer_amount))
    note = URI.escape("Payment for #{household_member.household.name} on Rentsplit")
    href = "https://venmo.com?txn=Pay&amp;recipients=#{email}&amp;amount=#{amount}&amp;note=#{note}"
  end

end
