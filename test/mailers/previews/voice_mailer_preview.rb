# Preview all emails at http://localhost:3000/rails/mailers/voice_mailer
class VoiceMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/voice_mailer/singup_confirmation
  def singup_confirmation
    VoiceMailer.singup_confirmation
  end

end
