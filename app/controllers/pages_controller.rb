class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to households_url
    else
      render :layout => "bare"  
    end  
  end
end