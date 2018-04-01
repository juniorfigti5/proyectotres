# Preview all emails at http://localhost:3000/rails/mailers/convert_mailer
class ConvertMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/convert_mailer/singup_confirmation
  def singup_confirmation
    ConvertMailer.singup_confirmation
  end

end
