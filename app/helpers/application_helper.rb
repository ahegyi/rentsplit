module ApplicationHelper

  # Get "resource" as :user for devise forms
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  # Get a nice date format: January 14th, 1984
  def ordinalize_date(a_datetime)
    a_datetime.strftime("%B #{a_datetime.day.ordinalize}, %Y") if a_datetime
  end

  # Get currency format: e.g. from 1220 => $12.20
  def integer_to_currency(an_integer)
    number_to_currency(an_integer/100.0)
  end

end
