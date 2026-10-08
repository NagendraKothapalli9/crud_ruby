class PasswordResetsController < ApplicationController
  def new; end

  def create
    @admin = SchoolAdmin.find_by(email: params[:email])
    if @admin
      otp = rand(100000..999999).to_s
      @admin.update(
        otp_code: otp,
        otp_sent_at: Time.current
      )
      UserMailer.otp_email(@admin).deliver_now
      redirect_to edit_password_reset_path(@admin.id), notice: "OTP sent to email"
    else
      flash.now[:alert] = "Email address not found."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @admin = SchoolAdmin.find_by(id: params[:id])
    if @admin.nil? || @admin.otp_code.nil?
      redirect_to new_password_reset_path, alert: "Invalid password reset request."
    else
       @admin.otp_code = nil
    end
  end

  def update
    @admin = SchoolAdmin.find_by(id: params[:id])

    if @admin.nil? || @admin.otp_code.nil?
      redirect_to new_password_reset_path, alert: "Invalid request."
    elsif @admin.otp_sent_at < 10.minutes.ago
      redirect_to new_password_reset_path, alert: "OTP has expired. Please request a new one."
    elsif @admin.otp_code != params[:school_admin][:otp_code]
      @admin.errors.add(:otp_code, "is invalid")
      render :edit, status: :unprocessable_entity
    elsif @admin.update(admin_params)
      @admin.update(otp_code: nil, otp_sent_at: nil)
      redirect_to login_path, notice: "Password successfully reset. Please log in."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def admin_params
    params.require(:school_admin).permit(:password, :password_confirmation)
  end
end