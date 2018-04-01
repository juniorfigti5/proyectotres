# Preview all emails at http://localhost:3000/rails/mailers/con_mailer
class ConMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/con_mailer/confirmation
  def confirmation
    ConMailer.confirmation
  end

end
