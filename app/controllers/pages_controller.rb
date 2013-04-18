class PagesController < ApplicationController
  def home
    render :layout => "bare"    
  end
end