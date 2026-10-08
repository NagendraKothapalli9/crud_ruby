class UserMailer < ApplicationMailer
  def otp_email(admin)
    @user = admin

    mail(
      to: @user.email,
      subject: "Your OTP"
    )
  end
end
