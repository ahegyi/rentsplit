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
    a_datetime.strftime("%B #{a_datetime.day.ordinalize}, %Y")
  end

end
