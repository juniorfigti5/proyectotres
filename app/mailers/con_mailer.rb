class ConMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.con_mailer.confirmation.subject
  #
  def confirmation(voice)
   @voice = voice

    mail to: @voice.email, subject: "VOZ CARGADA "
  end
end
