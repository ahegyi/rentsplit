class DeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  # default from: "Rentsplit"

  # def confirmation_instructions(record, opts={})
  #   headers["Subject"] = "Rentsplit: Confirm Your E-mail"
  #   super
  # end

  # def reset_password_instructions(record, opts={})
  #   headers["Subject"] = "Rentsplit: Reset Your Password"
  #   super
  # end

  # def unlock_instructions(record, opts={})
  #   super
  # end

end