class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :get_current_household

  # private

  # def get_current_household
  #   # Is there a better way!?!?
  #   raise "hellow"
  #   @current_household_id = params[:household_id] || params[:id]

  #   # if request.path.start_with?("/households/")
  #   #   @current_household_id = request.path.split("/households/")[1].split("/")[0].to_i
  #   # end

  # end

end
